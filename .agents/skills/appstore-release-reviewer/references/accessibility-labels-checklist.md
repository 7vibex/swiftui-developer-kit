# Accessibility Nutrition Labels Checklist

Use this checklist when release readiness touches App Store accessibility metadata.

## Evidence Required

- Common task list for each supported device family.
- Results for VoiceOver, Voice Control where relevant, Larger Text, Sufficient Contrast, Dark Interface, Differentiate Without Color Alone, and Reduced Motion.
- Known blockers that prevent users from completing common tasks.
- Accessibility URL or support page decision when the app wants to describe caveats or extra support.
- Confirmation that recent UI, navigation, purchase, login, settings, or core workflow changes did not invalidate existing claims.

## Go / No-Go

- **Go**: every claimed feature supports all common tasks for the relevant device family, and evidence is current.
- **No-go**: a claimed feature has a known blocker in a common task, evidence is missing, or metadata no longer matches app behavior.
- **Needs owner decision**: a feature is partially supported and should either be fixed before release or not claimed.

## Release Notes And Review Notes

- Mention accessibility improvements when they are user-visible.
- Do not overclaim store labels in release notes.
- If a diagnostic, screenshot, or feedback feature changes data collection, route to privacy and release metadata review.
