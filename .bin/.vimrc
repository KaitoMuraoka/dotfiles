set fileencodings=utf-8 "エンコーディング
set number "行番号
set relativenumber "相対番号
set hlsearch "検索ハイライト
set incsearch "インクリメントサーチ
set smartindent "インデント
set clipboard+=unnamed "クリップボード
set laststatus=2 "ステータスライン
set smartindent "改行の時に自動でインデント
syntax enable "シンタックス
if has('persistent_undo')" Undoの永続化
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

" Plugin
call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='molokai'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'ghifarit53/tokyonight-vim'
  " lsp
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  "other lsp
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-lsp-icons'

  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()

" colorscheme
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
