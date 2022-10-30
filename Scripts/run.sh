#! /usr/bin/env zsh
# shellcheck shell=bash

set -euo pipefail

swift build -c release

UNAME_ARCH=$(uname -m)
BUILT_EXECUTABLE=.build/"$UNAME_ARCH"-apple-macosx/release/WKPreferencesExperimentalFeaturesExtractor

SAFARI_FRAMEWORKS_PATH=/Applications/Safari.app/Contents/Frameworks/
if [ -d "$SAFARI_FRAMEWORKS_PATH" ]; then
  echo "# Safari:"
  DYLD_FRAMEWORK_PATH="$SAFARI_FRAMEWORKS_PATH" "$BUILT_EXECUTABLE"
  printf "\n"
fi

SAFARI_BETA_FRAMEWORKS_PATH=/Library/Apple/System/Library/StagedFrameworks/Safari/ 
if [ -d "$SAFARI_BETA_FRAMEWORKS_PATH" ]; then
  echo "# Safari Beta:"
  DYLD_FRAMEWORK_PATH="$SAFARI_BETA_FRAMEWORKS_PATH" "$BUILT_EXECUTABLE"
  printf "\n"
fi

SAFARI_TECHNOLOGY_PREVIEW_FRAMEWORKS_PATH=/Applications/Safari\ Technology\ Preview.app/Contents/Frameworks/
if [ -d "$SAFARI_TECHNOLOGY_PREVIEW_FRAMEWORKS_PATH" ]; then
  echo "# Safari Technology Preview:"
  DYLD_FRAMEWORK_PATH="$SAFARI_TECHNOLOGY_PREVIEW_FRAMEWORKS_PATH" "$BUILT_EXECUTABLE"
fi
