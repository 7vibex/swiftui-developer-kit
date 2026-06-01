# Scheme Detection Notes

Safe detection commands:

```bash
find . -maxdepth 3 \( -name "*.xcworkspace" -o -name "*.xcodeproj" -o -name Package.swift \) -print
xcodebuild -list -project App.xcodeproj
xcodebuild -list -workspace App.xcworkspace
swift package describe
```

These commands inspect metadata. They do not build the app. Ask for confirmation before running build, test, archive, launch, or clean commands.
