# AtCoder CLI セットアップ (Python)

## 概要

Python で AtCoder のコンテストに参加するための CLI 環境セットアップ記録。

## 使用ツール

| ツール | バージョン | 役割 |
|--------|-----------|------|
| `online-judge-tools` (oj) | 11.5.1 | テストケース取得・テスト実行 |
| `atcoder-cli` (acc) | 2.2.0 | コンテスト管理・提出 |

## インストール

```bash
pip install online-judge-tools
npm install -g atcoder-cli
```

## 設定ファイル

### acc テンプレート (Python)

`~/Library/Preferences/atcoder-cli-nodejs/templates/python/`

- `main.py` : 解答のテンプレート
- `template.json` : acc へのテンプレート登録設定

### acc config

`~/Library/Preferences/atcoder-cli-nodejs/config.json`

- `default-template` を `"python"` に設定
- `oj-path` に oj の絶対パスを設定済み

## エイリアス (`.zshrc`)

```zsh
alias acnew='acc new'                                             # コンテスト取得
alias actest='oj test -c "python3 main.py"'                      # テスト実行
alias acsub='acc submit main.py'                                  # 提出
alias aclogin='python3 ~/dotfiles/atcoder/inject_cookie.py'       # Cookieでログイン
```

## 基本的な使い方

```bash
# 1. コンテストのセットアップ
acnew abc123
# → abc123/{a,b,c,...}/main.py とテストケースが生成される

# 2. 解答を書いて、テスト実行
cd abc123/a
actest

# 3. 提出
acsub
```

---

## ログイン問題と解決方法

### 問題

`oj login` および `acc login` が **Cloudflare に弾かれてログインできない**。

```
# 試したが全滅
oj login https://atcoder.jp                  # Cloudflare でブロック
oj login --use-browser=always https://atcoder.jp  # 認証失敗
acc login                                    # login failed
```

AtCoder が Cloudflare による Bot 対策を導入しており、CLI からの自動ログインが
ブロックされる既知の問題。

### 解決方法

**ブラウザから `REVEL_SESSION` Cookie を手動で取得し、注入する。**

#### REVEL_SESSION の取得手順

1. Chrome で [atcoder.jp](https://atcoder.jp) にログイン
2. DevTools を開く (`Cmd + Option + I`)
3. **Application** タブ → **Cookies** → `https://atcoder.jp`
4. `REVEL_SESSION` の Value をコピー

#### Cookie の注入

```bash
aclogin
# → REVEL_SESSION の値を貼り付けると oj と acc の両方に設定される
```

スクリプト: `~/dotfiles/atcoder/inject_cookie.py`

- **oj** : `~/Library/Application Support/online-judge-tools/cookie.jar` (LWPCookieJar 形式)
- **acc** : `~/Library/Preferences/atcoder-cli-nodejs/session.json` (JSON 形式)

#### ログイン確認

```bash
oj login --check https://atcoder.jp
```

### 注意

- `REVEL_SESSION` はセッションが切れると無効になる。再ログインが必要になったら `aclogin` を再実行する。
- ブラウザで AtCoder からログアウトすると Cookie が無効になる。
