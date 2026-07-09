#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

find "$root" -maxdepth 4 \
  \( -path "*/.git" -o -path "*/.build" -o -path "*/DerivedData" -o -path "*/Pods" -o -path "*/Carthage" \) -prune \
  -o \( -name "*.xcworkspace" -o -name "*.xcodeproj" -o -name "Package.swift" -o -name "Info.plist" -o -name "PrivacyInfo.xcprivacy" \) -print | sort
