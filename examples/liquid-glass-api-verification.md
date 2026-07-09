# Liquid Glass API Verification Example

This fictional record shows the minimum evidence required before implementation guidance names SDK-sensitive APIs.

## Recommendation Record

- Surface: notebook toolbar.
- Surface type: chrome.
- SDK verified: yes.
- Toolchain: Xcode 26.5, Swift 6.3.2.
- Availability: iOS and iPadOS 26 or newer.
- API: `glassEffect(_:in:)` and `GlassEffectContainer`.
- Older-OS fallback: existing opaque toolbar material.
- Accessibility fallback: replace transparency with an opaque semantic background when Reduce Transparency is enabled; preserve labels and contrast under Increase Contrast.
- Primary content: editor text remains opaque and outside the glass container.

## Evidence

```bash
./scripts/check-apple-api-inventory.sh --sdk
```

Result: the isolated SwiftUI probe type-checked against the selected local iOS Simulator SDK. The result verifies symbol availability only; it does not prove visual quality or runtime accessibility.
