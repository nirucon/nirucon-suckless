" vimrc by Nicklas Rudolfsson
" https://github.com/nirucon

" Enable syntax highlighting
syntax enable

" Set line numbers
set number
set relativenumber

" Set color scheme to match Equilux colors
set background=dark
highlight Normal guifg=#E6E6E6 guibg=#2E2E2E
highlight Comment guifg=#444444
highlight CursorLine guibg=#444444
highlight LineNr guifg=#444444

" Highlight current line
set cursorline

" Enable line wrapping
set wrap

" Enable mouse support
set mouse=a

" Show matching parentheses
set showmatch

" Enable incremental search
set incsearch

" Set the command line height to 2
set cmdheight=2

" Enable clipboard support (requires Vim to be compiled with +clipboard)
set clipboard=unnamedplus

" Enable auto indentation
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" Display line and column numbers in the status line
set laststatus=2
set statusline=%f\ %y\ %m\ %r\ %=%l,%c\ %p%%

" Key mappings for convenience
nnoremap <C-c> :w<CR> " Save file with Ctrl + c
nnoremap <C-x> :q<CR> " Quit file with Ctrl + x
nnoremap <C-z> u " Undo with Ctrl + z

" Highlight search results
set hlsearch

" Show line numbers relative to the cursor
set relativenumber

" Enable command line completion
set wildmenu

" Enable filetype detection and plugins
filetype plugin indent on
