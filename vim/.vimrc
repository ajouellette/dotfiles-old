"
" ~/.vimrc
"    vim configuration file
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Using vundle to manage plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-unimpaired'
" Source code completion
Plugin 'Valloric/YouCompleteMe'
" YCM config generator
Plugin 'rdnetto/YCM-Generator'
" vim-fugitive: git support
Plugin 'tpope/vim-fugitive'
" auto end certain code structures
Plugin 'tpope/vim-endwise'
" automatic closing of quotes, braces, ...
Plugin 'Raimondi/delimitMate'
" un/comment code
Plugin 'scrooloose/nerdcommenter'
" file browser
Plugin 'scrooloose/nerdtree'
" highlight color codes with proper colors
Plugin 'Colorizer'
" fancy status line
Plugin 'bling/vim-airline'
" Colorscheme previewer
Plugin 'ScrollColors'
" i3 config syntax highlighting
Plugin 'PotatoesMaster/i3-vim-syntax'
" Colorschemes
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'NLKNguyen/papercolor-theme'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lines of history to remember
set history=50

" auto read file when changed from the outside
set autoread

" command timeout
set ttimeout
set ttimeoutlen=100

let mapleader=','
let g:mapleader=','

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 5 lines to the cursor 
set so=5

" Turn on the WiLd menu
set wildmenu

" Show line numbers
set number

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Searching:
set ignorecase      " ignore case 
set smartcase       " be smart
set hlsearch        " highlight
set incsearch       " incremental search
set magic           " regular expression magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

set t_Co=256
set background=dark
colorscheme solarized

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" separate undo dir
set undofile
set undodir=~/.vim/undo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" not for kernel patches!
autocmd BufNewFile,BufRead *.patch set noexpandtab
autocmd BufNewFile,BufRead *.patch set shiftwidth=8
autocmd BufNewFile,BufRead *.patch set tabstop=8

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" use pastetoggle to fix indenting when pasting
set pastetoggle=<F2>

" make vim use X11 clipboard (needs clipboard support)
set clipboard=unnamedplus

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow files to be open but not displayed
set hidden

" moving betweeen buffers
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" if airline is running, we do not need showmode
set noshowmode

set ruler
set showtabline=2
set showcmd

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" .md is markdown
autocmd BufNewFile,BufRead *.md :set filetype=markdown

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_detect_modified=1
let g:airline_detect_paste=1

" install powerline fonts to use special symbols
let g:airline_powerline_fonts=1

let g:airline_theme='jellybeans'

" show buffers in tabline
let g:airline#extensions#tabline#enabled=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => You Complete Me settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" seed identifier database with keywords from vim syntax files
let g:ycm_seed_identifiers_with_syntax=1

" location of global extra conf files (c and c++)
autocmd BufRead,BufNewFile *.c,*.h :let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.c.py"
autocmd BufRead,BufNewFile *.cpp,*hpp :let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.cpp.py"

" disable confirmation of conf files
let g:ycm_confirm_extra_conf=0

" autoclose preview window
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERD Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-f> :NERDTreeToggle<CR>

" close vim if only nerdtree is left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" open nerdtree if no file is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
