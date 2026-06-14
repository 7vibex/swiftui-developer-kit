#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/detect-swiftui-antipatterns.sh [--format markdown|json] [PATH...]

Scans SwiftUI source files for deterministic Apple app risk signals.
The scan is read-only and does not build, launch, or capture anything.

Options:
  --format FORMAT  Output markdown or json. Default: markdown.
  -h, --help       Show this help.
USAGE
}

format="markdown"
paths=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --format)
      if [[ $# -lt 2 ]]; then
        echo "--format requires markdown or json." >&2
        exit 2
      fi
      format="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      paths+=("$1")
      shift
      ;;
  esac
done

if [[ "$format" != "markdown" && "$format" != "json" ]]; then
  echo "Unsupported format: $format" >&2
  exit 2
fi

if [[ "${#paths[@]}" -eq 0 ]]; then
  paths=(".")
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

json_escape() {
  local value="$1"
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  value="${value//$'\n'/\\n}"
  printf '%s' "$value"
}

emit_finding() {
  local rule="$1"
  local severity="$2"
  local file="$3"
  local line="$4"
  local message="$5"
  local recommendation="$6"

  if [[ "$format" == "json" ]]; then
    if [[ "$json_first" -eq 0 ]]; then
      printf ','
    fi
    json_first=0
    printf '{"rule":"%s","severity":"%s","file":"%s","line":%s,"message":"%s","recommendation":"%s"}' \
      "$(json_escape "$rule")" \
      "$(json_escape "$severity")" \
      "$(json_escape "$file")" \
      "$line" \
      "$(json_escape "$message")" \
      "$(json_escape "$recommendation")"
  else
    printf -- '- **%s** `%s:%s` [%s]: %s %s\n' \
      "$rule" "$file" "$line" "$severity" "$message" "$recommendation"
  fi
}

collect_swift_files() {
  local target
  for target in "${paths[@]}"; do
    if [[ -f "$target" && "$target" == *.swift ]]; then
      printf '%s\n' "$target"
    elif [[ -d "$target" ]]; then
      find "$target" \
        \( -name .git -o -name .build -o -name DerivedData -o -name build -o -name xcuserdata \) -prune \
        -o -type f -name '*.swift' -print
    fi
  done | sort -u
}

line_for_pattern() {
  local file="$1"
  local pattern="$2"
  local found
  found="$(grep -nE "$pattern" "$file" | head -n 1 | cut -d: -f1 || true)"
  printf '%s' "${found:-1}"
}

if [[ "$format" == "json" ]]; then
  printf '['
  json_first=1
else
  echo "# SwiftUI Anti-Pattern Scan"
  echo
fi

finding_count=0

while IFS= read -r file; do
  [[ -f "$file" ]] || continue
  rel_file="${file#$repo_root/}"
  line_count="$(wc -l < "$file" | tr -d ' ')"

  if [[ "$line_count" -gt 120 ]] && grep -qE 'struct[[:space:]]+[A-Za-z0-9_]+[[:space:]]*:[[:space:]]*View' "$file"; then
    emit_finding \
      "large-swiftui-file" \
      "medium" \
      "$rel_file" \
      "1" \
      "SwiftUI view file has $line_count lines." \
      "Split rendering, state, and helper views before adding more behavior."
    finding_count=$((finding_count + 1))
  fi

  if grep -q 'Button' "$file" && grep -q 'Image(systemName:' "$file" && ! grep -q 'accessibilityLabel' "$file"; then
    line="$(line_for_pattern "$file" 'Image\(systemName:')"
    emit_finding \
      "image-button-missing-accessibility-label" \
      "high" \
      "$rel_file" \
      "$line" \
      "A button appears to rely on an SF Symbol without an accessibility label." \
      "Add a clear .accessibilityLabel or use a Label with visible text."
    finding_count=$((finding_count + 1))
  fi

  if grep -qE '\.onAppear[[:space:]]*\{' "$file" && grep -qE 'Task[[:space:]]*\{' "$file"; then
    line="$(line_for_pattern "$file" 'Task[[:space:]]*\{')"
    emit_finding \
      "unstructured-task-in-view-lifecycle" \
      "medium" \
      "$rel_file" \
      "$line" \
      "View lifecycle starts an unstructured Task." \
      "Prefer .task(id:), cancellation-aware view models, or explicit task storage."
    finding_count=$((finding_count + 1))
  fi

  if grep -qE '\.(foregroundColor|foregroundStyle|background)\(\.(red|blue|green|orange|purple|pink|yellow|black|white|gray)\)' "$file"; then
    line="$(line_for_pattern "$file" '\.(foregroundColor|foregroundStyle|background)\(\.(red|blue|green|orange|purple|pink|yellow|black|white|gray)\)')"
    emit_finding \
      "hardcoded-foreground-color" \
      "low" \
      "$rel_file" \
      "$line" \
      "View uses a hardcoded semantic-hostile color." \
      "Use asset colors, semantic roles, or environment-aware styles."
    finding_count=$((finding_count + 1))
  fi

  if grep -q 'modelContext.delete' "$file" && ! grep -qE 'confirmationDialog|Alert|undo|UndoManager' "$file"; then
    line="$(line_for_pattern "$file" 'modelContext\.delete')"
    emit_finding \
      "swiftdata-delete-without-recovery-signal" \
      "high" \
      "$rel_file" \
      "$line" \
      "SwiftData delete path has no nearby confirmation or recovery signal." \
      "Verify destructive actions have confirmation, undo, or a clear recovery path."
    finding_count=$((finding_count + 1))
  fi

  if grep -qE '(\.glassEffect\(|GlassEffectContainer|GlassButtonStyle|\.buttonStyle\(\.glass)' "$file"; then
    if ! grep -qE '(@available|#available)\([^)]*(iOS|iPadOS|macOS|tvOS|watchOS)[^)]*26' "$file"; then
      line="$(line_for_pattern "$file" '(\.glassEffect\(|GlassEffectContainer|GlassButtonStyle|\.buttonStyle\(\.glass)')"
      emit_finding \
        "glass-effect-missing-availability-guard" \
        "high" \
        "$rel_file" \
        "$line" \
        "Liquid Glass usage has no nearby platform availability policy in this file." \
        "Add an availability guard and a semantic material or opaque older-OS fallback."
      finding_count=$((finding_count + 1))
    fi

    if grep -qE '(^|[^A-Za-z0-9_])(ScrollView|List|TextEditor|PDFView|PDFPage|Markdown|CodeBlock|Transcript|Flashcard)([^A-Za-z0-9_]|$)' "$file"; then
      line="$(line_for_pattern "$file" '(\.glassEffect\(|GlassEffectContainer|GlassButtonStyle|\.buttonStyle\(\.glass)')"
      emit_finding \
        "glass-on-scroll-content-surface" \
        "high" \
        "$rel_file" \
        "$line" \
        "Glass appears in a file with scrolling, document, or long-form content surfaces." \
        "Move Liquid Glass to fixed chrome and keep reading, writing, PDF, and transcript content opaque."
      finding_count=$((finding_count + 1))
    fi

    if grep -qE '(\.glassEffect\([^)]*\.clear|\.glass\([^)]*\.clear|Glass[^[:space:]]*[Cc]lear)' "$file" && ! grep -qE '(legibility|contrast|scrim|dimming|Reduce Transparency|accessibilityReduceTransparency)' "$file"; then
      line="$(line_for_pattern "$file" '(\.glassEffect\([^)]*\.clear|\.glass\([^)]*\.clear|Glass[^[:space:]]*[Cc]lear)')"
      emit_finding \
        "clear-glass-without-legibility-treatment" \
        "medium" \
        "$rel_file" \
        "$line" \
        "Clear glass appears without an obvious legibility or Reduce Transparency treatment." \
        "Prefer regular glass for controls with text, or add contrast and Reduce Transparency fallback behavior."
      finding_count=$((finding_count + 1))
    fi
  fi

  if grep -qE 'PKToolPicker\.shared|shared\(for:' "$file"; then
    line="$(line_for_pattern "$file" 'PKToolPicker\.shared|shared\(for:')"
    emit_finding \
      "deprecated-pktoolpicker-shared-for-window" \
      "medium" \
      "$rel_file" \
      "$line" \
      "Code uses the legacy shared PKToolPicker lookup pattern." \
      "Use current PencilKit tool-picker lifecycle patterns and verify first-responder ownership."
    finding_count=$((finding_count + 1))
  fi

  if grep -q 'PKCanvasView' "$file" && ! grep -q 'canvasViewDrawingDidChange' "$file"; then
    line="$(line_for_pattern "$file" 'PKCanvasView')"
    emit_finding \
      "pkcanvasview-no-change-hook" \
      "high" \
      "$rel_file" \
      "$line" \
      "PKCanvasView appears without a drawing-change hook in this file." \
      "Verify drawing changes feed an autosave/debounce or persistence path."
    finding_count=$((finding_count + 1))
  fi

  if grep -qE 'PDFPageOverlayViewProvider|pageOverlayViewProvider' "$file" && ! grep -qE '(^|[^A-Za-z0-9_])(save|write|export|annotation|PDFAnnotation|dataRepresentation)([^A-Za-z0-9_]|$)' "$file"; then
    line="$(line_for_pattern "$file" 'PDFPageOverlayViewProvider|pageOverlayViewProvider')"
    emit_finding \
      "pdf-overlay-without-roundtrip-save" \
      "high" \
      "$rel_file" \
      "$line" \
      "PDF overlay provider appears without an obvious annotation, export, save, or reopen path." \
      "Verify PDF overlays round-trip to persisted annotation or document data."
    finding_count=$((finding_count + 1))
  fi

  if [[ "$line_count" -gt 120 ]] && grep -q '@Query' "$file"; then
    line="$(line_for_pattern "$file" '@Query')"
    emit_finding \
      "query-in-heavy-root-view" \
      "medium" \
      "$rel_file" \
      "$line" \
      "A large SwiftUI file uses @Query." \
      "Move heavy data orchestration out of large root views and keep @Query for straightforward view-facing streams."
    finding_count=$((finding_count + 1))
  fi

  if grep -qE '(Logger\(|logger\.(debug|info|notice|warning|error|critical|fault)\()' "$file" && grep -qE '(email|accountEmail|prompt|noteText|noteBody|messageBody|transcript|token|secret|documentTitle)' "$file" && ! grep -qE '(privacy:[[:space:]]*\.(private|sensitive)|\.private|hash)' "$file"; then
    line="$(line_for_pattern "$file" '(logger\.(debug|info|notice|warning|error|critical|fault)\(|Logger\()')"
    emit_finding \
      "logger-unsafe-interpolation" \
      "high" \
      "$rel_file" \
      "$line" \
      "Logger usage appears near sensitive user-content fields without obvious privacy handling." \
      "Mark interpolated user data private, hash identifiers where needed, and avoid raw study content in logs."
    finding_count=$((finding_count + 1))
  fi

  sheet_count="$(grep -Ec '\.sheet\(isPresented:' "$file" || true)"
  bool_count="$(grep -Ec '@State.*(show|is)[A-Za-z0-9_]*[[:space:]]*=[[:space:]]*false' "$file" || true)"
  if [[ "$sheet_count" -ge 2 && "$bool_count" -ge 2 ]]; then
    line="$(line_for_pattern "$file" '\.sheet\(isPresented:')"
    emit_finding \
      "multiple-presentation-booleans" \
      "medium" \
      "$rel_file" \
      "$line" \
      "Multiple boolean-driven sheets appear in one SwiftUI file." \
      "Use one enum or item-backed presentation state for mutually exclusive sheets, alerts, popovers, or destinations."
    finding_count=$((finding_count + 1))
  fi
done < <(collect_swift_files)

if [[ "$format" == "json" ]]; then
  printf ']\n'
else
  if [[ "$finding_count" -eq 0 ]]; then
    echo "No deterministic SwiftUI risk signals found."
  else
    echo
    echo "Findings: $finding_count"
  fi
fi
