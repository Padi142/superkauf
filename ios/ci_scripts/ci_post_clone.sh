#!/bin/sh

# Prepare Xcode Cloud's clean build machine for this Flutter project.
set -eu

cd "$CI_PRIMARY_REPOSITORY_PATH"

FLUTTER_VERSION="${FLUTTER_VERSION:-3.41.3}"
FLUTTER_HOME="$HOME/flutter"

git clone \
  --depth 1 \
  --branch "$FLUTTER_VERSION" \
  https://github.com/flutter/flutter.git \
  "$FLUTTER_HOME"

export PATH="$FLUTTER_HOME/bin:$PATH"

flutter config --no-analytics
flutter precache --ios
flutter pub get

if ! command -v pod >/dev/null 2>&1; then
  HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods
fi

cd ios
pod install
