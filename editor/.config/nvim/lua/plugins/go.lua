return {
  -- Goの開発環境設定
  -- テスト実行、タグ追加、インポート管理など）を提供
  {
    -- Go専用のプラグイン
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua", -- UIコンポーネント（フローティングウィンドウなど）
      "neovim/nvim-lspconfig", -- LSPの基本設定
      "nvim-treesitter/nvim-treesitter", -- シンタックスハイライト
    },
    config = function()
      -- go.nvimのセットアップ
      -- なぜ: Goの標準的な開発ワークフローに最適化された設定
      require("go").setup({
        -- gofmt on save（保存時に自動フォーマット）
        -- なぜ: Goコミュニティの標準的なコーディングスタイルを自動適用
        gofmt = "gofumpt", -- gofumpt は gofmt よりも厳格

        -- auto import（未使用インポートの削除と必要なインポートの追加）
        -- なぜ: 手動でimport文を管理する手間を省く
        goimports = "gopls",

        -- linter（静的解析ツール）
        -- なぜ: コードの潜在的な問題を早期発見
        linter = "golangci-lint",

        -- LSP設定
        -- なぜ: gopls（Go公式のLSP）を使用してコード補完などを実現
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,

        -- テスト関連
        -- なぜ: Neovim内でテストを実行・確認できる
        run_in_floaterm = true,
      })

      -- Auto format on save
      -- なぜ: 保存のたびに手動でフォーマットコマンドを実行する必要がない
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    -- イベント: Goファイルを開いたときのみ読み込む
    -- なぜ: 起動時間を短縮（Goファイル以外では不要）
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
}
