#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="$HOME/.config/claude-usage-bar"
CACHE="$CACHE_DIR/statusline-cache.json"
TTL=300
mkdir -p "$CACHE_DIR"

STDIN=$(cat)
MODEL=$(printf '%s' "$STDIN" | jq -r '.model.display_name // .model.id // empty' 2>/dev/null)

fetch_usage() {
  local token
  token=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null \
            | jq -r '.claudeAiOauth.accessToken' 2>/dev/null) || return
  [ -n "$token" ] && [ "$token" != "null" ] || return
  curl -sS --max-time 8 \
    -H "Authorization: Bearer $token" \
    -H "anthropic-beta: oauth-2025-04-20" \
    https://api.anthropic.com/api/oauth/usage > "$CACHE.tmp" 2>/dev/null \
    && mv "$CACHE.tmp" "$CACHE" || rm -f "$CACHE.tmp"
}

if [ ! -f "$CACHE" ] || [ "$(( $(date +%s) - $(stat -f %m "$CACHE") ))" -ge "$TTL" ]; then
  fetch_usage &
fi

MODEL_LABEL=""
[ -n "$MODEL" ] && MODEL_LABEL="\033[36m$MODEL\033[0m  "

if [ ! -f "$CACHE" ] || ! jq -e . "$CACHE" >/dev/null 2>&1; then
  printf "%busage …" "$MODEL_LABEL"
  exit 0
fi

RESET="\033[0m"
color() {  # $1=int percent -> ANSI color
  if   [ "$1" -lt 50 ]; then printf '\033[32m'
  elif [ "$1" -lt 80 ]; then printf '\033[33m'
  else printf '\033[31m'
  fi
}

bar() {  # $1=int percent (0-100)
  local p="$1" filled i out=""
  (( p < 0 )) && p=0
  (( p > 100 )) && p=100
  filled=$(( (p + 10) / 20 ))
  for ((i = 0; i < 5; i++)); do
    if [ "$i" -lt "$filled" ]; then out+="▓"; else out+="░"; fi
  done
  printf '%s' "$out"
}

h5=$(jq -r '.five_hour.utilization // 0' "$CACHE")
d7=$(jq -r '.seven_day.utilization // 0' "$CACHE")
h5=${h5%.*}
d7=${d7%.*}

printf "%b5h %b%s %d%%%b  7d %b%s %d%%%b" \
  "$MODEL_LABEL" \
  "$(color "$h5")" "$(bar "$h5")" "$h5" "$RESET" \
  "$(color "$d7")" "$(bar "$d7")" "$d7" "$RESET"
