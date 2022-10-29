#! /usr/bin/env zsh
# shellcheck shell=bash

set -euo pipefail

swift build -c release

BUILT_EXECUTABLE=.build/x86_64-apple-macosx/release/WKPreferencesExperimentalFeaturesExtractor

echo "# Safari Beta:"
DYLD_FRAMEWORK_PATH=/Library/Apple/System/Library/StagedFrameworks/Safari/ "$BUILT_EXECUTABLE"

echo "\n"

echo "# Safari Technology Preview:"
DYLD_FRAMEWORK_PATH=/Applications/Safari\ Technology\ Preview.app/Contents/Frameworks/ "$BUILT_EXECUTABLE"
