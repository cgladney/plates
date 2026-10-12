#!/bin/zsh
# Publish a new version: stamps a new version number (so phones pick up the update), commits and pushes.
# Usage: ./deploy.sh "what changed"
set -e
cd "$(dirname "$0")"
V="$(date +%Y.%m.%d-%H%M)"
sed -i '' -E "s/const APP_VERSION = \"[^\"]+\"/const APP_VERSION = \"$V\"/" index.html
sed -i '' -E "s/const CACHE = \"plates-v[^\"]+\"/const CACHE = \"plates-v$V\"/" sw.js
printf '{ "version": "%s" }\n' "$V" > version.json
git add -A
git commit -q -m "${1:-Update app} ($V)"
git push -q origin main
echo "Published version $V"
