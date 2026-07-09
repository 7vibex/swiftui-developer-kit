# SDK Verification Policy

Last verified: 2026-07-09

Liquid Glass and other SDK-sensitive recommendations must distinguish documentation evidence from local compiler evidence.

## Required Fields

Every implementation recommendation for an SDK-sensitive API must state:

- SDK verified: yes or no.
- Local toolchain and SDK version, when verified.
- Platform availability.
- Older-OS fallback.
- Reduce Transparency and Increase Contrast behavior.
- Surface type: content, chrome, navigation, inspector, transient overlay, or destructive/warning UI.

## Verification Order

1. Check [the Apple API inventory](apple-api-inventory.md).
2. Open the linked official Apple documentation.
3. Confirm the symbol exists in the selected local SDK.
4. Type-check or build the smallest relevant source target.
5. Record the exact command and result.
6. Keep the recommendation at `SDK verified: no` when any step is unavailable.

## Release Gate

Run the structural check on every platform:

```bash
./scripts/check-apple-api-inventory.sh
```

On a Mac with Xcode, run the compiler-backed check:

```bash
./scripts/check-apple-api-inventory.sh --sdk
```

The compiler-backed check creates only a temporary probe file and does not build, launch, capture, sign, or modify an app project.
