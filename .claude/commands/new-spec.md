# /new-spec

## 目的
新しい機能の仕様書（PRD.md）を作成する。

## Claude への指示
1. まず「workプロジェクトですか？personalプロジェクトですか？」と確認する
2. ~/.claude/templates/prd-template.md を読み込む
3. 回答に応じて保存先を決定する
   - work   → ~/.claude/specs/work/[機能名]/PRD.md
   - personal → ~/.claude/specs/personal/[機能名]/PRD.md
4. [機能名] のPRDを作成する
5. 作成したら「何を・なぜ作るか」を私に確認する
6. 確認が取れたらタスクを3〜5個に分解する
7. 最終的に決定した保存先にファイルを作成する

