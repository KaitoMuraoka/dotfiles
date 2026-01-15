-- lazy.nvimの自動インストール設定
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- lazy.nvimがまだインストールされていなければ、gitでcloneする
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- lazy.nvimをruntimepathに追加
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- プラグインの設定
require("lazy").setup({
  -- ここにプラグインを列挙していく
  
  -- 例1: ファイルツリー
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",  -- アイコン表示のために必要
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
})
