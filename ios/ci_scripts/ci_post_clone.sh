#!/bin/sh

# Prepare Xcode Cloud's clean build machine for this Flutter project.
set -eu

cd "$CI_PRIMARY_REPOSITORY_PATH"

# Xcode Cloud exposes workflow variables to this script, but Flutter expects
# them in the ignored .env asset declared by pubspec.yaml. Validate the full
# runtime configuration and create that asset only on the ephemeral CI host.
: "${API_URL:?Missing Xcode Cloud variable: API_URL}"
: "${FIREBASE_WEB_CLIENT_ID:?Missing Xcode Cloud variable: FIREBASE_WEB_CLIENT_ID}"
: "${ONESIGNAL_KEY:?Missing Xcode Cloud variable: ONESIGNAL_KEY}"
: "${SEARCH_API:?Missing Xcode Cloud variable: SEARCH_API}"
: "${SEARCH_API_KEY:?Missing Xcode Cloud variable: SEARCH_API_KEY}"
: "${SENTRY_DSN:?Missing Xcode Cloud variable: SENTRY_DSN}"
: "${SUPABASE_URL:?Missing Xcode Cloud variable: SUPABASE_URL}"
: "${SUPABASE_SECRET:?Missing Xcode Cloud variable: SUPABASE_SECRET}"

(
  umask 077
  {
    printf 'API_URL=%s\n' "$API_URL"
    printf 'FIREBASE_WEB_CLIENT_ID=%s\n' "$FIREBASE_WEB_CLIENT_ID"
    printf 'ONESIGNAL_KEY=%s\n' "$ONESIGNAL_KEY"
    printf 'SEARCH_API=%s\n' "$SEARCH_API"
    printf 'SEARCH_API_KEY=%s\n' "$SEARCH_API_KEY"
    printf 'SENTRY_DSN=%s\n' "$SENTRY_DSN"
    printf 'SUPABASE_URL=%s\n' "$SUPABASE_URL"
    printf 'SUPABASE_SECRET=%s\n' "$SUPABASE_SECRET"
  } > .env
)

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
