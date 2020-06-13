"
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'powerline/fonts'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Mouse yo
set mouse=a

" default tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
syntax on
colorscheme onedark

" enable transparent background
:hi! Normal ctermbg=NONE guibg=NONE

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" add specific filetype settings
if has("autocmd")
    filetype on
    autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
    " yaml specific bindings
    autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab

    " shell specific bindings
    autocmd Filetype sh setlocal ts=2 sts=2 sw=2 expandtab

    " go specific bindings
    autocmd Filetype go setlocal ts=2 sts=2 sw=2 noexpandtab
    autocmd Filetype go noremap <C-h> <C-o>

    " js specific bindings
    autocmd Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab

    " html specific bindings
    autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab

    " YCM
    autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>

    " insert debug statement w/ Ctrl + Shift + b
    autocmd FileType python noremap <buffer> <silent> <C-B> <ESC>oimport ipdb; ipdb.set_trace()<esc>
    autocmd FileType go noremap <buffer> <silent> <C-B> <ESC>o_ = "breakpoint"<esc>

    " docker
    autocmd BufNewFile,BufRead *.dockerfile set syntax=dockerfile

endif

" allows buffers to be edited and hidden
set hidden

" highlight searched objects
set hlsearch

" moves cursor to the object found in search
set incsearch

" number of commands to save in history
set history=1000

" search will ignore case and allow for use of *
set ignorecase
set smartcase

" Keeps X lines offset while scrolling the file
set scrolloff=2

" Use relative numbering on the side
" set rnu
set number

" also uses the X clipboard when yanking text
set clipboard+=unnamedplus


" sets the ctags location
set tags=./tags;

" By default split screens to the right
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Add soft wrapping line break feature
set wrap linebreak nolist
set showbreak=">"

" sets the textwidth and colorline
set colorcolumn=120
set textwidth=120

" sets the formatter to use par
set formatprg=par\ -w100

" auto indents files
filetype indent plugin on


"========================
"===== key bindings =====
"========================

" no more shift required in normal mode
nnoremap ; :

" leader as space bar is dope
"let mapleader="\<Space>"
map  <Space> <leader>

"===== Line movement =====
" Ctrl up/down will now move lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" remove whitespace
nnoremap <silent> <leader>w :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


"==========================
"===== plugin options =====
"==========================

"===== NERDTree =====
" open and close nerdtree
noremap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['\.pyc$']
map <leader>r :NERDTreeFind<CR>

"===== git gutter =====
nmap <Leader>hv <Plug>GitGutterPreviewHunk
nmap <Leader>hn <Plug>GitGutterNextHunk
nmap <Leader>hb <Plug>GitGutterPrevHunk
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>(GitGutterUndoHunk)

"===== airline =====
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#format = 1
let g:airline#extensions = ['branch', 'virtualenv', 'bufferline']
let g:airline_theme='onedark'
