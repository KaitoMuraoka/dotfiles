#!/usr/bin/env python3
"""
AtCoder の REVEL_SESSION cookie を oj と acc の両方に注入するスクリプト。

使い方:
  1. Chrome で atcoder.jp にログイン
  2. DevTools (F12) → Application → Cookies → https://atcoder.jp
  3. REVEL_SESSION の値をコピー
  4. python3 inject_cookie.py
"""

import http.cookiejar
import json
import pathlib
import time

OJ_COOKIE_PATH = pathlib.Path.home() / "Library/Application Support/online-judge-tools/cookie.jar"
ACC_SESSION_PATH = pathlib.Path.home() / "Library/Preferences/atcoder-cli-nodejs/session.json"


def inject_oj(revel_session: str):
    OJ_COOKIE_PATH.parent.mkdir(parents=True, exist_ok=True)
    jar = http.cookiejar.LWPCookieJar(str(OJ_COOKIE_PATH))
    cookie = http.cookiejar.Cookie(
        version=0,
        name="REVEL_SESSION",
        value=revel_session,
        port=None,
        port_specified=False,
        domain=".atcoder.jp",
        domain_specified=True,
        domain_initial_dot=True,
        path="/",
        path_specified=True,
        secure=False,
        expires=int(time.time()) + 86400 * 365,
        discard=False,
        comment=None,
        comment_url=None,
        rest={},
    )
    jar.set_cookie(cookie)
    jar.save(ignore_discard=True)
    OJ_COOKIE_PATH.chmod(0o600)
    print(f"[oj]  Cookie を保存しました: {OJ_COOKIE_PATH}")


def inject_acc(revel_session: str):
    session = {
        "cookies": [
            "REVEL_FLASH=",
            f"REVEL_SESSION={revel_session}",
        ]
    }
    ACC_SESSION_PATH.write_text(json.dumps(session, indent="\t"))
    print(f"[acc] Session を保存しました: {ACC_SESSION_PATH}")


def main():
    revel_session = input("REVEL_SESSION の値を貼り付けてください: ").strip()
    if not revel_session:
        print("値が空です。終了します。")
        return

    inject_oj(revel_session)
    inject_acc(revel_session)

    print("\nログイン状態の確認:")
    print("  oj login --check https://atcoder.jp")


if __name__ == "__main__":
    main()
