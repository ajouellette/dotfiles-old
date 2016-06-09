" ~/.config/nvim/init.vim
"    NeoVim configuration file

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
Plug 'equalsraf/neovim-gui-shim'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'scrooloose/nerdcommenter'
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'i3' }
" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/base16-vim'
call plug#end()
"}}}

"""""""""""""""""""""""""""""
" => General {{{
"""""""""""""""""""""""""""""
" lines of history to remember
set history=50

let mapleader=','
let maplocalleader=','

noremap ; :

set timeout ttimeout
set timeoutlen=500 ttimeoutlen=50

" reload vimrc when written
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
"}}}

"""""""""""""""""""""""""""""
" => VIM user interface {{{
"""""""""""""""""""""""""""""
" true color and cursor shape
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set noerrorbells
set belloff="all"

set scrolloff=5

" Show line numbers
set relativenumber
set number

" highlight current line
set cursorline
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
colorscheme gruvbox
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
nnoremap <C-B> :CtrlPBuffer<CR>

" Move by visual lines, but only when count is 0
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
map <Up> gk
map <Down> gj

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
set showtabline=1
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
autocmd BufNewFile,BufRead *.z80 :set filetype=z80
" markdown
autocmd BufNewFile,BufRead *.md :setlocal filetype=markdown
" mutt files
autocmd BufNewFile,BufRead *mutt-* :setlocal filetype=mail

"}}}

"""""""""""""""""""""""""""""
" => Editing gpg files {{{
"""""""""""""""""""""""""""""
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
    au!
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg set viminfo=
    " We don't want a various options which write unencrypted data to disk
    autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
    " (If you use tcsh, you may need to alter this line.)
    autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
    " Convert all text to encrypted text before writing
    " (If you use tcsh, you may need to alter this line.)
    autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost *.gpg u
augroup END
"}}}

"""""""""""""""""""""""""""""
" => Spellchecking {{{
"""""""""""""""""""""""""""""
set spellsuggest=best,5

" use spell checking for mail and markdown
autocmd FileType mail     :setlocal spell spelllang=en_us
autocmd FileType markdown :setlocal spell spelllang=en_us
autocmd FileType notes    :setlocal spell spelllang=en_us

" toggle spell
nmap \s :setlocal spell!<CR> :setlocal spell?<CR>
" }}}

"""""""""""""""""""""""""""""
" => Vim-airline {{{
"""""""""""""""""""""""""""""
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" install powerline fonts to use special symbols
let g:airline_powerline_fonts=1

"let g:airline_theme='jellybeans'

" show buffers in tabline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_min_count=2

" word count
let g:airline#extension#wordcount#enabled=1
let g:airline#extension#wordcount#filetypes="\vhelp|markdown|rst|org|text|mail"
" }}}

"""""""""""""""""""""""""""""
" => You Complete Me {{{
"""""""""""""""""""""""""""""
" seed identifier database with keywords from vim syntax files
let g:ycm_seed_identifiers_with_syntax=1

let g:ycm_server_python_interpreter = '/usr/bin/python'

" location of global extra conf files (c and c++)
autocmd BufRead,BufNewFile *.c,*.h :let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.c.py"
autocmd BufRead,BufNewFile *.cpp,*hpp :let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.cpp.py"

" disable confirmation of conf files
let g:ycm_confirm_extra_conf=0

" autoclose preview window
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}

"""""""""""""""""""""""""""""
" => NerdTree {{{
"""""""""""""""""""""""""""""
map <C-f> :NERDTreeToggle<CR>

" close vim if only nerdtree is left open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" open nerdtree if no file is specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}

"""""""""""""""""""""""""""""
" => CtrlP {{{
"""""""""""""""""""""""""""""
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

" Open file menu
nnoremap <Leader>o :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo|zip|mp3|pdf|jpg|png|tar|gz)$',
  \ }
"}}}

"""""""""""""""""""""""""""""
" => UltiSnips {{{
"""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"}}}

"""""""""""""""""""""""""""""
" => Notes {{{
"""""""""""""""""""""""""""""
let g:notes_directories = ['~/Dropbox/Notes']
"}}}

"""""""""""""""""""""""""""""
" => VimTex {{{
"""""""""""""""""""""""""""""
" disable vim-polyglot latex support
let g:polyglot_disabled = ['latex']

" use nvim remote
let g:vimtex_latexmk_progname = 'nvr'

let g:vimtex_fold_enabled = 1

" pdf viewer settings
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

" semantic completions
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
      \ 're!\\hyperref\[[^]]*',
      \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
      \ 're!\\(include(only)?|input){[^}]*',
      \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
      \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
      \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
      \ ]
"}}}

" Neomake {{{
autocmd! BufWritePost * Neomake
"}}}

" vim:foldmethod=marker:foldlevel=0
