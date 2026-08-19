#!/bin/bash
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -z "$REPO_ROOT" ] && exit 0

CONFLICTED=$(git -C "$REPO_ROOT" diff --name-only --diff-filter=U -z | tr '\0' '\n')

# コンフリクトが無い = 通常作業 → ガード無効
[ -z "$CONFLICTED" ] && exit 0

REL_PATH="${FILE_PATH#"$REPO_ROOT"/}"
if ! printf '%s\n' "$CONFLICTED" | grep -qxF "$REL_PATH"; then
  echo "Blocked: '$REL_PATH' はコンフリクト中のファイルではありません。" >&2
  exit 2
fi
exit 0
