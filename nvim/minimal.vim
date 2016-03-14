" ~/.config/nvim/init.min.vim
"    A minimal NeoVim configuration file

"""""""""""""""""""""""""""""
" => Plugins {{{
"""""""""""""""""""""""""""""
" Auto install plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Use vim-plug to manage plugins
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
call plug#end()
"}}}

"""""""""""""""""""""""""""""
" => General {{{
"""""""""""""""""""""""""""""
" lines of history to remember
set history=50

let mapleader=','
noremap ; :

set timeout ttimeout
set timeoutlen=400 ttimeoutlen=10

"}}}

"""""""""""""""""""""""""""""
" => VIM user interface {{{
"""""""""""""""""""""""""""""
" This probably wont work everwhere
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

set noerrorbells
set belloff="all"

set scrolloff=5

" Show line numbers
set relativenumber
set number

" highlight 80th column
set colorcolumn=80

" Searching
set ignorecase      " ignore case
set smartcase       " be smart
set hlsearch        " highlight
set incsearch       " incremental search
" clear highlight
nmap <leader><space> :nohlsearch<CR>

" use global substitutions by default
set gdefault

" Show matching brackets when text indicator is over them
set showmatch

set whichwrap+=<,>

" use X11 clipboard
set clipboard+=unnamedplus
"}}}

"""""""""""""""""""""""""""""
" => Folding {{{
"""""""""""""""""""""""""""""
set foldenable
set foldlevelstart=10  " open most folds by default
set foldnestmax=10     " 10 nested folds max
" open/close folds
nnoremap <space> za
set foldmethod=indent  " fold based on indent level
" }}}

"""""""""""""""""""""""""""""
" => Colors {{{
"""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set background=dark
colorscheme desert
" }}}

"""""""""""""""""""""""""""""
" => Backups and undo {{{
"""""""""""""""""""""""""""""
" Turn backup off
set nobackup
set nowritebackup
set noswapfile

set undofile
set undodir=~/.cache/nvim/undo
" }}}

"""""""""""""""""""""""""""""
" => Tab, Indent {{{
"""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" indenting
set autoindent
set smartindent

" wrap lines
set wrap
"}}}

"""""""""""""""""""""""""""""
" => Moving around {{{
"""""""""""""""""""""""""""""
" allow files to be open but not displayed
set hidden

" moving between buffers
nnoremap <C-K> :bnext<CR>
nnoremap <C-J> :bprev<CR>

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
map <Up> gk
map <Down> gj

" show tabline only if there are at least two tabs
set showtabline=1

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab,newtab

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"}}}

"""""""""""""""""""""""""""""
" => Status line {{{
"""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" if airline is running, we do not need showmode
set noshowmode

set ruler
set showtabline=2
set showcmd
" }}}

"""""""""""""""""""""""""""""
" => Terminal {{{
"""""""""""""""""""""""""""""
" open a terminal
nnoremap <Leader>t :vsplit +terminal<CR>

" Easier normal mode
tnoremap <ESC> <C-\><C-n>

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"}}}

"""""""""""""""""""""""""""""
" => Misc {{{
"""""""""""""""""""""""""""""
" command line mode more like a command line
cnoremap <C-a>  <Home>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" no ex mode
nnoremap Q <nop>

" move current line up/down
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" add a blank line above/below
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

xnoremap <  <gv
xnoremap >  >gv

" toggle wrapping
nmap \w :setlocal wrap!<CR> :setlocal wrap?<CR>

" Delete trailing white space on save
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

set splitbelow
set splitright
"}}}

"""""""""""""""""""""""""""""
" => Filetypes {{{
"""""""""""""""""""""""""""""
" TECS files
autocmd BufNewFile,BufRead *.jack :setlocal filetype=jack
autocmd BufNewFile,BufRead *.vm   :setlocal filetype=vm
" z80 assembly
autocmd BufNewFile,BufRead *.z80 :setlocal filetype=z80
" markdown
autocmd BufNewFile,BufRead *.md :setlocal filetype=markdown
" mail
autocmd BufNewFile,BufRead *mutt-* :setlocal filetype=mail

"}}}

"""""""""""""""""""""""""""""
" => Spellchecking {{{
"""""""""""""""""""""""""""""
set spellsuggest=best,10

" use spell checking for mail and markdown
autocmd FileType mail     :setlocal spell spelllang=en_us
autocmd FileType markdown :setlocal spell spelllang=en_us

" toggle spell
nmap \s :setlocal spell!<CR> :setlocal spell?<CR>
" }}}

"""""""""""""""""""""""""""""
" => Vim-airline {{{
"""""""""""""""""""""""""""""
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" show buffers in tabline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_min_count=2

" word count
let g:airline#extension#wordcount#enabled=1
let g:airline#extension#wordcount#filetypes="\vhelp|markdown|rst|org|text|mail"
" }}}

"""""""""""""""""""""""""""""
" => NerdTree {{{
"""""""""""""""""""""""""""""
map <C-f> :NERDTreeToggle<CR>

" }}}

" vim:foldmethod=marker:foldlevel=0
