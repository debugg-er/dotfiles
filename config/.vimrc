let mapleader = " "

set mouse=a       " mouse enable
set cursorline

set termguicolors

set nowrap        " prevent break line

" set cmdheight=1
set confirm
set signcolumn=yes
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line

set autoindent
set smartindent

set autoread
set autowrite     " Automatically :write before running commands

" Softtabs, 2 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround
set expandtab

set listchars=tab:\┊\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Show relative number line by default
set number relativenumber

" Folding
set foldmethod=indent
set foldlevel=30 " expand all fold when open file

" System clipboard
set clipboard=unnamedplus

" Disable insert the comment character on new line
autocmd FileType * set formatoptions-=cro

" refresh
nmap <space>r :w<cr>:source ~/.config/nvim/init.vim<cr>

" Copy all line
nnoremap <space>y ggyG<C-o>zz

" Indent whole file
nnoremap <space>= gg=G<C-o>zz

" Return to normal mode
tnoremap jk <C-\><C-n>
inoremap jk <ESC>

" Prevent yank jump back
" vnoremap y ygv<ESC>
" inoremap <C-CR> <ESC><S-A>;
" nnoremap <C-CR> <S-A>;<ESC>

" Replace
" nnoremap <C-A-h> :%s//g<left><left>

" Indent multiple line
vmap <A-l> >gv
vmap <A-h> <gv

" " Move line
" nnoremap <A-j> :m +1<CR>==
" nnoremap <A-k> :m -2<CR>==
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi

" Remove highlight
nnoremap <A-h> :nohl<CR>

" Search without case-sensitive
nnoremap ? /\c

" Fix <S-k> visual mode throw error
vnoremap <S-k> <up>
vnoremap <S-j> <down>

" Prevent cut or copy of some key
vnoremap c "_c
vnoremap x "_x
nnoremap x "_x
nnoremap c "_c
nnoremap s "_s
nnoremap S "_S
nnoremap D "_D
nnoremap C "_C
vnoremap p "_dP

" Save/Quit
nmap <space>q :q<CR>
nmap <space>w :w<CR>
