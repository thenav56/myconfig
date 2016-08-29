filetype off
call plug#begin('~/.config/nvim/bundle')

" This is the Vundle package, which can be found on GitHub.
" For GitHub epos, you specify plugins using the
" 'user/repository' format
"Plug 'lervag/vimtex'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'NLKNguyen/papercolor-theme'
Plug 'Yggdroot/indentLine'
Plug 'CmdlineComplete'
Plug 'Chiel92/vim-autoformat'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'nvie/vim-flake8'
"Plug 'klen/python-mode'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
call plug#end()

" Now we can turn our filetype functionality back on
filetype plugin indent on
let python_highlight_all=1
syntax on

"set runtimepath -=~/.nvim/bundle/YouCompleteMe       "disable plugin without deleting it / temporarily 

" GENERAL
set encoding=utf-8                                  " Set character encoding
set lazyredraw                                      " Don't draw while executing macros
set hidden                                          " Don't unload a buffer when no longer show in window
set foldenable                                      " Set to display all folds open
set remap                                           " Recognize mappings in mapped keys
"set nospell                                         " Disable spell correction
set scroll=9                                        " Number of lines to scroll for Ctrl-U and Ctrl-D
set scrolloff=3                                     " Minimal number of screen lines to keep above/below the cursor.
set scrolljump=5                                    " Lines to scroll when cursor leaves screen
set mousehide                                       " Hide mouse while typing
set mouse=a                                         " Enable mouse for all modes
set incsearch                                       " Show match for partly typed search command
set hlsearch                                        " Highlight search
set ignorecase                                      " Uses case insensitive search
set splitbelow                                      " A new window is put below the current one
set splitright                                      " A new window is put right of the current one
set history=100                                     " Set number of command line history remembered
set directory=~/.nvim/tmp/swap,/tmp                  " Directory for nvim swap
set updatetime=4000                                 " Time in ms after which swap will be updated
set updatecount=200                                 " Number of characters typed to cause a swap file update
set undofile                                        " Automatically save and restore undo history
set undodir=~/.nvim/tmp/undo,/tmp                    " Directory for nvim undo
set undolevels=1000                                 " Over 1000 levels of undo
set undoreload=10000                                " Maximum number lines to save for undo on a buffer reload
set backup                                          " Enable backup
set backupdir=~/.nvim/tmp/backup,/tmp                " Set backup dir

if !has('nvim')
    set viminfo+=n~/.nvim/tmp/nviminfo                " Put nviminfo inside .vim/tmp folder
else
    set viminfo+=n~/.nvim/tmp/nviminfo.nvim           " Put viminfo inside .nvim/tmp folder
endif

" FORMATTING
set backspace=indent,eol,start                      " Smart backspace
set tabstop=4                                       " Number of spaces a <Tab> in text stands for
set shiftwidth=4                                    " Number of spaces used for each step of indent
set smarttab                                        " a <Tab> is an indent inserts 'shiftwidth' spaces
set expandtab                                       " Set <Tab> to spaces in Insert mode
set softtabstop=4                                   " number of spaces to insert for a <Tab>
set autoindent                                      " Auto indentation
set smartindent                                     " Do clever auto indentation
set nowrap                                          " Don't wrap long lines
set clipboard=unnamedplus                          "vim uses system clipboard to copy/paste
set whichwrap=b,s,h,l,<,>,[,]                       " Backspace and cursor keys wrap too
"set wrapmargin=10                                  " Number of characters from right window border where wrapping starts

au Filetype python call SetPython()
function! SetPython()
    setlocal textwidth=79                                    " Set maximum width of text that is being inserted
    " Set colorcolumn highlight beyond textwidth
    "execute "setlocal colorcolumn=".join(range(80,80+255-1),",")
endfunction

" UI
if has('gui_running')
    set guifont=Hack\ 12    "Powerline\ Consolas\ 10
    set guioptions -=m                              " Remove menubar
    set guioptions -=T                              " Remove GUI toolbar
    set guioptions -=l                              " Remove left-hand scroll bar
    set guioptions -=r                              " Remove right-hand scroll bar
    set guioptions -=L                              " Remove left-hand scroll bar
    set guioptions -=R                              " Remove left-hand scroll bar
else
    set t_Co=256                                    " Set terminal color to 256
    "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set background=dark                                 " Set dark background
    colorscheme PaperColor                               " Set colorscheme
    hi Normal ctermbg=none                             " enables transparent
endif
set showmatch                                       " When inserting bracket, briefly jump to its match
set number                                          " Show line number for each line
set cursorline                                      " Show cursor line
set fillchars+=vert:\                               " Remove ugly | in split
set laststatus=2

if has('cmdline_info')
    set ruler                                           " Shows current position below each window
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)  " A ruler on steroids
    set showcmd                                         " Show command in the last line of the screen
    set showmode                                        " Show current mode in last line
endif
set shortmess=filmnrxoOtT                           " Show short message to avoid hit-enter
set viewoptions=folds,options,cursor,unix,slash     " Better Unix / Windows compatibility
set iskeyword-=.                                    " '.' is an end of word designator
set list                                            " Useful to see difference between tab and space
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.      " Highlight problematic whitespace
set wildmenu                                        " Command-line completion show a list of matches
set wildmode=list:longest                           " Specifies how command line completion works
set wildignore=*.o,*.obj                            " List of file patterns ignored while expanding wildcards
set wildignorecase                                  " Ignore case when completing file names

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" ignore files in NERDTREE
let NERDTreeIgnore = ['\.pyc$', '\~$']

" MAPPINGS
nmap <C-i> :NERDTreeToggle <CR>
" Map leader to ,
let mapleader = ','
" nice navigation in splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Setup some default ignores
"let g:ctrlp_custom_ignore = {
  "\ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  "\ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
"\}
"let g:ctrlp_max_files=0
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
"let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_open_multiple_files = 'ij'
" Use a leader instead of the actual named binding
"nmap <leader>p :CtrlP<cr>
" FZF alternative for ctrlP
nmap <leader>bf :FZF! -m<cr>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Easy bindings for its various modes
"nmap <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
"nmap <leader>bb :CtrlPBuffer<cr>
"nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nmap m :bprevious<cr>
nmap <leader>, :bnext<cr>
nmap <leader>c :bd<cr>
"Quickly edit/reload the vimrc file
nmap <silent> <leader>e :e $MYVIMRC<CR>
nmap <silent> <leader>r :so $MYVIMRC<CR>
" Change Working Directory to that of the current file
cmap cd. cd %:p:h
" For when you forget to sudo
cmap w!! w !sudo tee % >/dev/null
" run python from current buffer
"nmap <leader>pr :exec '!python' shellescape(@%, 1)<cr>
"nmap <leader>pr2 :exec '!python2' shellescape(@%, 1)<cr>
"nmap <leader>pr3 :exec '!python3' shellescape(@%, 1)<cr>
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" space open/closes folds
nnoremap <space> za

" Vim
let g:indentLine_color_term = 239
"GVim
let g:indentLine_color_gui = '#08434c'
" none X terminal
let g:indentLine_color_tty_light = 4 " (default: 4)
let g:indentLine_color_dark = 2 " (default: 2)
let g:indentLine_char = '┆'

" vim-airline 
let g:airline_theme = 'PaperColor'
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

"let g:pymode_python = 'python3'
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0

" syantastic config
let g:syntastic_python_python_exec = "/usr/bin/python3"
"let g:syntastic_python_flake8_exec = "/usr/bin/python3"

map <Leader> <Plug>(easymotion-prefix)
map  <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)
vnoremap <C-c> "*y


" Exit in Terminal mode
:tnoremap <C-l> <C-\><C-n>
