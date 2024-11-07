#!/bin/bash

REPO="laradumps/app"
API_URL="https://api.github.com/repos/laradumps/app/releases/latest"

LATEST_RELEASE=$(curl -sL "$API_URL")
VERSION=$(echo "$LATEST_RELEASE" | jq -r '.tag_name' | sed 's/^v//')
LATEST_URL="https://github.com/$REPO/releases/download/v$VERSION/latest-mac.yml"

echo "Downloading $LATEST_URL..."

curl -sL "$LATEST_URL" -o latest-mac.yaml

ZIP_PATH=$(grep -E "^path:" latest-mac.yaml | awk '{print $2}')
ZIP_URL="https://github.com/$REPO/releases/download/v$VERSION/$ZIP_PATH"

echo "New version: $VERSION"
echo "Download URL: $ZIP_URL"

echo "Downloading $ZIP_PATH..."

curl -sL "$ZIP_URL" -o "$ZIP_PATH"

echo "Updating the Cask file (laradumps.rb)..."

SHA256=$(shasum -a 256 "$ZIP_PATH" | awk '{print $1}')

sed -i '' "s/^  version \".*\"/  version \"$VERSION\"/" "Casks/laradumps.rb"
sed -i '' "s/^  sha256 \".*\"/  sha256 \"$SHA256\"/" "Casks/laradumps.rb"

rm -f latest-mac.yaml "$ZIP_PATH"

echo "Update complete!"
