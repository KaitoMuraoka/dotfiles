# /commit

---
description: ステージング済み変更を分析し、変更内容に見合った日本語コミットメッセージを生成してコミットする。
allowed-tools: Bash
---


## コミットメッセージ規約
- git diffを確認して、Conventional Commits形式で
- コミットメッセージを提案してください。
- Co-authored-byは追加しないでください。

形式: <type>(<scope>): <日本語の説明>
type: feat / fix / refactor / chore / docs / test
