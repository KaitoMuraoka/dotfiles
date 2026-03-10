#!/bin/sh
# Claude Code ステータスライン設定スクリプト
# robbyrussell テーマ風のプロンプトに Claude Code の情報を追加

input=$(cat)

# Claude Code の情報を取得
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
dir=$(basename "$cwd")
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# カレントディレクトリ表示
printf "\033[36m%s\033[0m" "$dir"

# Git ブランチ表示（利用可能な場合）
git_branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$git_branch" ]; then
  printf " \033[33mgit:(\033[31m%s\033[33m)\033[0m" "$git_branch"
fi

# モデル表示
printf " \033[35m[%s]\033[0m" "$model"

# コンテキスト使用率表示（データがある場合）
if [ -n "$used_pct" ]; then
  used_int=$(echo "$used_pct" | cut -d'.' -f1)
  if [ "$used_int" -ge 80 ]; then
    printf " \033[31mctx:%s%%\033[0m" "$used_int"
  elif [ "$used_int" -ge 50 ]; then
    printf " \033[33mctx:%s%%\033[0m" "$used_int"
  else
    printf " \033[32mctx:%s%%\033[0m" "$used_int"
  fi
fi
