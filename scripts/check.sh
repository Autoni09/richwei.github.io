#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[check] verify git repository"
git rev-parse --is-inside-work-tree >/dev/null

echo "[check] verify hugo command exists"
command -v hugo >/dev/null

echo "[check] verify public/ is not tracked"
tracked_public_count="$(git ls-files "public/**" | sed '/^$/d' | wc -l | tr -d ' ')"
if [ "$tracked_public_count" -ne 0 ]; then
  echo "[error] public/ contains tracked files. Run: git rm -r --cached public" >&2
  exit 1
fi

echo "[check] build site with hugo --minify"
hugo --minify >/dev/null

echo "[check] passed"
