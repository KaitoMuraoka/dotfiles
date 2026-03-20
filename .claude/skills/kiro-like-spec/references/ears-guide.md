# EARS記法ガイド

EARS (Easy Approach to Requirements Syntax) は要件を明確・テスト可能な形で記述するための記法。

## 基本構文

```
WHEN <条件・イベント>
THE SYSTEM SHALL <期待する振る舞い>
```

## パターン一覧

| パターン | 構文 | 用途 |
|---|---|---|
| Event-driven | WHEN ... THE SYSTEM SHALL | ユーザー操作・外部イベントに対する反応 |
| State-driven | WHILE ... THE SYSTEM SHALL | システムが特定状態にある間の振る舞い |
| Optional | WHERE ... THE SYSTEM SHALL | 特定機能が有効な場合の振る舞い |
| Unwanted | IF ... THEN THE SYSTEM SHALL | エラー・例外ケース |
| Ubiquitous | THE SYSTEM SHALL | 常に成立する要件 |

## 良い例 vs 悪い例

### ❌ 悪い（曖昧）
```
ユーザーがログインできること
エラー時に適切なメッセージを表示する
素早くレスポンスを返す
```

### ✅ 良い（明確・テスト可能）
```
WHEN ユーザーが正しいメールアドレスとパスワードを入力して送信した
THE SYSTEM SHALL セッションを生成してダッシュボードへリダイレクトする

WHEN ユーザーが存在しないメールアドレスでログインを試みた
THE SYSTEM SHALL「メールアドレスまたはパスワードが正しくありません」を表示する
（※メールアドレスの存在を明かさないセキュリティ要件）

WHEN ユーザーが5回連続でログインに失敗した
THE SYSTEM SHALL アカウントを30分間ロックし、登録メールアドレスへ通知する
```

## よくある間違い

1. **AND で複数振る舞いを繋げる**
   - ❌ `THE SYSTEM SHALL メールを送信してリダイレクトする`
   - ✅ 2つの別 Criteria に分割する

2. **主語が人間になっている**
   - ❌ `WHEN ユーザーがボタンを押すと、ユーザーはページに遷移する`
   - ✅ `THE SYSTEM SHALL <ページ>へ遷移させる`

3. **測定不能な形容詞**
   - ❌ `THE SYSTEM SHALL 高速に応答する`
   - ✅ `THE SYSTEM SHALL 95パーセンタイルで200ms以内に応答する`
