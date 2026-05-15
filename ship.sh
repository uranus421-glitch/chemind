#!/usr/bin/env bash
# ship.sh — 一键提交推送 + 同步 vault
# Usage: bash ship.sh "改动描述"

set -euo pipefail

MSG="${1:-update}"
VAULT_DIR="$HOME/OneDrive/Desktop/AI/Obsidian/xinku"
SKILL_NAME="synthon"
REPO="coeus-io/$SKILL_NAME"

echo ">>> 1/3 提交推送..."
cd "$(dirname "$0")"
git add -A
git commit -m "$MSG" || echo "(nothing to commit, continuing)"
git push origin master

echo ">>> 2/3 同步 vault..."
cd "$VAULT_DIR"
npx skills install "github:$REPO"

echo ">>> 3/3 完成!"
git -C "$(dirname "$0")" log --oneline -3
