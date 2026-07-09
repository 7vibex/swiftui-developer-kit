#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "error: $*" >&2
  exit 1
}

run_sdk_check=0
case "${1:-}" in
  "") ;;
  --sdk) run_sdk_check=1 ;;
  -h|--help)
    echo "Usage: scripts/check-apple-api-inventory.sh [--sdk]"
    exit 0
    ;;
  *) fail "unknown option: $1" ;;
esac

inventory="docs/apple-api-inventory.md"
[[ -f "$inventory" ]] || fail "missing $inventory"

for symbol in 'glassEffect(_:in:)' 'GlassEffectContainer' 'GlassButtonStyle' 'backgroundExtensionEffect()' 'scrollEdgeEffectStyle(_:for:)' 'safeAreaBar(edge:alignment:spacing:content:)'; do
  grep -Fq "$symbol" "$inventory" || fail "missing SDK-sensitive API: $symbol"
done

grep -Fq 'Last verified: ' "$inventory" || fail "Apple API inventory lacks a verification date"
grep -Fq 'SDK verified' examples/liquid-glass-api-verification.md || fail "Liquid Glass verification example lacks SDK status"

if [[ "$run_sdk_check" -eq 1 ]]; then
  command -v xcrun >/dev/null 2>&1 || fail "--sdk requires Xcode command-line tools"
  sdk_path="$(xcrun --sdk iphonesimulator --show-sdk-path)"
  probe="$(mktemp -t swiftui-kit-api-probe).swift"
  trap 'rm -f "$probe"' EXIT
  printf '%s\n' \
    'import SwiftUI' \
    '@available(iOS 26.0, *)' \
    'struct LiquidGlassInventoryProbe: View {' \
    '  var body: some View {' \
    '    GlassEffectContainer {' \
    '      Button("Study") {}' \
    '        .buttonStyle(.glass)' \
    '        .glassEffect()' \
    '    }' \
    '  }' \
    '}' > "$probe"
  xcrun swiftc -typecheck -sdk "$sdk_path" -target arm64-apple-ios26.0-simulator "$probe"
  echo "Apple API inventory SDK check passed: $(xcrun --sdk iphonesimulator --show-sdk-version)."
else
  echo "Apple API inventory structural check passed. Use --sdk for compiler verification."
fi
