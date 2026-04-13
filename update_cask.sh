#!/bin/bash

set -euo pipefail

VERSION=$1

if [ -z "$VERSION" ]; then
    echo "Error: Version not specified."
    echo "Usage: sh update.sh <version>"
    exit 1
fi

CASK_FILE="Casks/laradumps.rb"
YAML_TMP="latest-mac.yaml"

if [ ! -f "$CASK_FILE" ]; then
    echo "Error: Cask file not found: $CASK_FILE"
    exit 1
fi

cleanup() {
    rm -f "$YAML_TMP"
    [ -n "${ZIP_PATH:-}" ] && rm -f "$ZIP_PATH"
}
trap cleanup EXIT

LATEST_URL="https://github.com/laradumps/app/releases/download/v$VERSION/latest-mac.yml"

echo "Fetching release metadata from $LATEST_URL..."
if ! curl -fsSL "$LATEST_URL" -o "$YAML_TMP"; then
    echo "Error: Failed to download release metadata from $LATEST_URL"
    exit 1
fi

ZIP_PATH=$(grep -E "^path:" "$YAML_TMP" | awk '{print $2}')

if [ -z "$ZIP_PATH" ]; then
    echo "Error: Could not extract ZIP path from release metadata."
    cat "$YAML_TMP"
    exit 1
fi

ZIP_URL="https://github.com/laradumps/app/releases/download/v$VERSION/$ZIP_PATH"

echo "New version: $VERSION"
echo "Download URL: $ZIP_URL"
echo "Downloading $ZIP_PATH..."

if ! curl -fSL --progress-bar "$ZIP_URL" -o "$ZIP_PATH"; then
    echo "Error: Failed to download $ZIP_URL"
    exit 1
fi

if [ ! -f "$ZIP_PATH" ] || [ ! -s "$ZIP_PATH" ]; then
    echo "Error: Downloaded file is missing or empty: $ZIP_PATH"
    exit 1
fi

echo "Computing SHA256..."
SHA256=$(shasum -a 256 "$ZIP_PATH" | awk '{print $1}')

if [ -z "$SHA256" ] || [ ${#SHA256} -ne 64 ]; then
    echo "Error: Invalid SHA256 hash: '$SHA256'"
    exit 1
fi

echo "SHA256: $SHA256"
echo "Updating the Cask file ($CASK_FILE)..."

sed -i '' "s/^  version \".*\"/  version \"$VERSION\"/" "$CASK_FILE"
sed -i '' "s/^  sha256 \".*\"/  sha256 \"$SHA256\"/" "$CASK_FILE"

if ! grep -q "version \"$VERSION\"" "$CASK_FILE"; then
    echo "Error: Failed to update version in $CASK_FILE"
    exit 1
fi

if ! grep -q "sha256 \"$SHA256\"" "$CASK_FILE"; then
    echo "Error: Failed to update sha256 in $CASK_FILE"
    exit 1
fi

echo "Update complete!"

git add "$CASK_FILE"
git commit -m "v$VERSION"
git push
