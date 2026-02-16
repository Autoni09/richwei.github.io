#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [ "$#" -lt 2 ]; then
  echo "[error] usage: scripts/commit-safe.sh <type> <subject>" >&2
  exit 1
fi

commit_type="$1"
shift
commit_subject="$*"

valid_types="feat fix docs chore refactor style test perf build ci revert"
if ! echo " $valid_types " | grep -q " ${commit_type} "; then
  echo "[error] invalid commit type: ${commit_type}" >&2
  echo "[error] allowed types: ${valid_types}" >&2
  exit 1
fi

if [ -z "${commit_subject}" ]; then
  echo "[error] commit subject cannot be empty" >&2
  exit 1
fi

echo "[commit] run pre-check"
"$ROOT_DIR/scripts/check.sh"

echo "[commit] ensure staged files exist"
staged_files="$(git diff --cached --name-only)"
if [ -z "$staged_files" ]; then
  echo "[error] no staged files. Stage changes first." >&2
  exit 1
fi

echo "[commit] block forbidden paths (themes/, public/)"
forbidden_files="$(git diff --cached --name-only | grep -E '^(themes/|public/)' || true)"
if [ -n "$forbidden_files" ]; then
  echo "[error] forbidden staged files detected:" >&2
  echo "$forbidden_files" >&2
  exit 1
fi

echo "[commit] create commit"
git commit -m "${commit_type}: ${commit_subject}"

echo "[commit] done"
