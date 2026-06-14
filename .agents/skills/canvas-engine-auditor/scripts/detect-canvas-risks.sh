#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"
if [[ ! -d "$root" ]]; then
  echo "error: directory not found: $root" >&2
  exit 1
fi

swift_files=()
while IFS= read -r file; do
  swift_files+=("$file")
done < <(find "$root" -type f -name "*.swift" \
  -not -path "*/.build/*" \
  -not -path "*/DerivedData/*" \
  -not -path "*/Pods/*" \
  -not -path "*/Carthage/*" | sort)

if [[ "${#swift_files[@]}" -eq 0 ]]; then
  echo "No Swift files found under $root"
  exit 0
fi

echo "# Canvas Risk Scan"
echo

echo "## Canvas/PencilKit/PaperKit Entry Points"
grep -HnE "\b(PKCanvasView|PencilKit|PaperKit|PaperMarkup|PaperMarkupViewController|PKToolPicker|PKDrawing|PKStroke|UIViewRepresentable|Canvas\s*\{|GraphicsContext)\b" "${swift_files[@]}" || true
echo

echo "## Gesture And Coordinate Hotspots"
grep -HnE "\b(DragGesture|MagnificationGesture|SpatialTapGesture|GestureState|simultaneousGesture|highPriorityGesture|coordinateSpace|GeometryReader|contentOffset|zoomScale|minimumScale|maximumScale)\b" "${swift_files[@]}" || true
echo

echo "## PDF Overlay And Export Hotspots"
grep -HnE "\b(PDFKit|PDFView|PDFPage|PDFPageOverlayViewProvider|pageOverlayViewProvider|PDFAnnotation|write|export|dataRepresentation)\b" "${swift_files[@]}" || true
echo

echo "## Apple Pencil Pro Hotspots"
grep -HnE "\b(UIPencilInteraction|preferredTapAction|preferredSqueezeAction|squeeze|hover|roll|UIPencilHoverPose|UICanvasFeedbackGenerator)\b" "${swift_files[@]}" || true
echo

echo "## Persistence / Undo Hotspots"
grep -HnE "\b(dataRepresentation|PKDrawing\(|UndoManager|undo|redo|autosave|save|load|SwiftData|ModelContext|FileManager|UserDefaults|Codable)\b" "${swift_files[@]}" || true
echo

echo "## Performance Hotspots"
grep -HnE "\b(TimelineView|drawingGroup|Task\s*\{|MainActor|onChanged|onChange|thumbnail|UIImage|Data\(|pngData|jpegData)\b" "${swift_files[@]}" || true
echo

echo "## Large SwiftUI Files"
for file in "${swift_files[@]}"; do
  lines=$(wc -l < "$file" | tr -d ' ')
  if [[ "$lines" -ge 500 ]]; then
    echo "$lines $file"
  fi
done | sort -nr || true
