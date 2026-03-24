---
name: kiro-like-spec
description: |
  Kiro の Specs ドキュメントに基づいたスペック駆動開発を実行するスキル。
  ユーザーがアイデアを説明したとき、「仕様を作って」「spec を書いて」「要件定義して」
  「設計書を作って」「タスクに分解して」「Kiroスタイルで」などのフレーズが出たら必ず使うこと。
  requirements.md / design.md / tasks.md の3ファイルを順番に生成し、
  各フェーズでユーザーの承認を得てから次へ進む。承認後は tasks.md に従って実装も担当する。
  Claude Code での利用を主目的とするが、Claude Web でも Markdown 生成として動作する。
---

# kiro-spec

Kiro の Spec システムを Claude で再現するスキル。
アイデア → requirements → design → tasks → 実装 の流れを、ユーザー承認を挟みながら進める。

## ディレクトリ規約

ホームディレクトリの `~/.claude/kiro/specs/<feature-name>/` を作成し、以下の3ファイルを配置する。
（プロジェクトには手を加えず、すべてのスペックファイルをグローバルに一元管理する）

```
~/.claude/kiro/specs/<feature-name>/
├── requirements.md   # EARS記法のユーザーストーリー＋受け入れ基準
├── design.md         # アーキテクチャ・シーケンス図・実装方針
└── tasks.md          # 細粒度の実装タスク一覧
```

既存の spec ファイルを渡された場合は「実装フェーズ」から開始する（後述）。

---

## Phase 0: スタート判定

ユーザーの入力から開始ポイントを判断する。

| 入力の状態 | 開始フェーズ |
|---|---|
| アイデア・機能説明のみ | Phase 1（requirements 生成） |
| requirements.md のみ存在 | Phase 2（design 生成） |
| requirements + design が存在 | Phase 3（tasks 生成） |
| 3ファイルすべて存在 | Phase 4（実装） |

---

## Phase 1: Requirements

### 生成ルール

`requirements.md` を以下の構造で生成する。

```markdown
# Requirements: <feature-name>

## Overview
（機能の1〜2行概要）

## User Stories

### Story 1: <ストーリータイトル>
**As a** <ユーザー種別>
**I want** <やりたいこと>
**So that** <目的・価値>

#### Acceptance Criteria
- WHEN <条件> THE SYSTEM SHALL <振る舞い>
- WHEN <条件> THE SYSTEM SHALL <振る舞い>
- WHEN <エラー条件> THE SYSTEM SHALL <エラー時の振る舞い>

（Story を必要なだけ繰り返す）

## Out of Scope
- （今回含まない機能を明示）
```

### EARS 記法の必須チェック

生成後、以下を自己チェックし、問題があれば生成しなおす。

- [ ] すべての Acceptance Criteria が `WHEN ... THE SYSTEM SHALL ...` 形式になっている
- [ ] 曖昧語（「適切に」「素早く」「なるべく」など）が含まれていない
- [ ] 正常系・異常系・境界値のシナリオが網羅されている
- [ ] "Out of Scope" が明示されている
- [ ] 各 SHALL が単一の振る舞いのみ記述している（ANDで複数振る舞いを並べていない）

### ユーザー承認プロンプト

自己チェック通過後、必ず以下を出力してから止まる。

```
📋 requirements.md を生成しました。

レビューしてください：
- 追加・変更したいユーザーストーリーはありますか？
- Out of Scope に漏れはありますか？
- Acceptance Criteria で不明確な点はありますか？

問題なければ「承認」と入力してください。修正があればご指摘ください。
```

ユーザーが修正を指摘した場合 → 修正して再度承認を求める（指摘0件になるまで繰り返す）。
ユーザーが「承認」した場合 → Phase 2 へ進む。

---

## Phase 2: Design

### 生成ルール

`design.md` を以下の構造で生成する。

```markdown
# Design: <feature-name>

## Overview
（技術的アプローチの1〜2行サマリ）

## Architecture

### Component Diagram
（Mermaid の graph/flowchart でコンポーネント図を記述）

### Data Model
（主要なデータ構造・スキーマ）

## Sequence Diagrams

### <主要フロー名>
（Mermaid の sequenceDiagram で記述）

## Implementation Notes

### Error Handling
（エラーケースの処理方針）

### Testing Strategy
（ユニットテスト・統合テストの方針）

### Non-functional Considerations
（パフォーマンス・セキュリティ・スケーラビリティ等、該当するもの）
```

### 設計チェック

生成後、以下を自己チェックする。

- [ ] requirements.md の全 Story に対応するフローが設計に含まれている
- [ ] Sequence Diagram が正常系・異常系を両方カバーしている
- [ ] 外部依存（API・DB・ライブラリ）が明示されている
- [ ] Testing Strategy が具体的（何をどう test するか書かれている）

### ユーザー承認プロンプト

```
🏗️ design.md を生成しました。

レビューしてください：
- アーキテクチャの方針に問題はありますか？
- Sequence Diagram に漏れているフローはありますか？
- 使用技術・ライブラリの選択に問題はありますか？

問題なければ「承認」と入力してください。
```

---

## Phase 3: Tasks

### 生成ルール

`tasks.md` を以下の構造で生成する。

```markdown
# Tasks: <feature-name>

## Implementation Tasks

- [ ] 1. <タスクタイトル>
  - 詳細: <何をするか1〜2文>
  - 参照: requirements.md Story X / design.md Section Y
  - [ ] 1.1 <サブタスク>
  - [ ] 1.2 <サブタスク>

- [ ] 2. <タスクタイトル>
  ...
```

### タスク品質チェック

- [ ] 各タスクが単一の関心事のみ扱っている
- [ ] 1タスクの実装量が概ね1〜2時間以内に収まる粒度である
- [ ] タスクに依存順序があれば番号順に並んでいる
- [ ] 各タスクに requirements.md / design.md への参照が付いている
- [ ] テストタスクが実装タスクと対になって存在する

### ユーザー承認プロンプト

```
✅ tasks.md を生成しました。

レビューしてください：
- タスクの粒度は適切ですか？（大きすぎ・小さすぎ）
- 抜けているタスクはありますか？
- 実装順序に問題はありますか？

問題なければ「承認」と入力してください。
実装を開始するには「実装開始」と入力してください。
```

---

## Phase 4: 実装

tasks.md を受け取って実装する場合（既存 spec を渡された場合を含む）。

### 実装ループ

1. tasks.md の未完了タスク（`- [ ]`）を上から1つ選ぶ
2. 対応する requirements.md の Acceptance Criteria と design.md の設計を確認する
3. 実装する
4. 実装後、該当 Acceptance Criteria を満たしているか自己検証する
5. tasks.md の該当タスクを `- [x]` に更新する
6. ユーザーに「タスク X 完了。次のタスク Y に進みます」と報告する
7. 次のタスクへ（すべて完了したら終了を報告）

### 実装時の制約

- design.md の設計から逸脱する場合は、先にユーザーに報告・相談する
- requirements.md の Acceptance Criteria を満たせない場合は、実装を止めてユーザーに報告する
- テストタスクはスキップしない

---

## 既存 spec ファイルの読み込み

`#requirements.md` `#design.md` `#tasks.md` などでファイルが参照された場合、
または `~/.claude/kiro/specs/` ディレクトリが存在する場合は Phase 0 の判定を行い適切なフェーズから開始する。

詳細なリファレンスは `references/` を参照。
- `references/ears-guide.md` — EARS記法の詳細ガイドと例
- `references/review-rules.md` — 各フェーズのレビュー基準詳細
