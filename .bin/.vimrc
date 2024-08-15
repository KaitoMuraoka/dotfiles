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
call plug#end()

