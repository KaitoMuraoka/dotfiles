set fileencodings=utf-8 "エンコーディング
set number "行番号
set relativenumber "相対番号
set hlsearch "検索ハイライト
set incsearch "インクリメントサーチ
set smartindent "インデント
set clipboard+=unnamed "クリップボード
set laststatus=2 "ステータスライン
set smartindent "改行の時に自動でインデント
set tabstop=2 " タブ幅を2
set shiftwidth=2 " シフト幅を2
syntax enable "シンタックス
if has('persistent_undo')" Undoの永続化
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif
set completeopt=menuone,noinsert
" 補完表示時のEnterで改行をしない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"

" Plugin
call plug#begin()
  Plug 'preservim/nerdtree'
	let NERDTreeShowHidden=1
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='molokai'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'ghifarit53/tokyonight-vim'
  " lsp
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/vim-lsp'
  "other lsp
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-lsp-icons'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
	" Flutter lsp
	Plug 'dart-lang/dart-vim-plugin'
	Plug 'thosakwe/vim-flutter'
	" git
	Plug 'airblade/vim-gitgutter'
call plug#end()

" colorscheme
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

" ==== KeyMap ====
nnoremap <silent><C-e> :NERDTreeToggle<CR>

