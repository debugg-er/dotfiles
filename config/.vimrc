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

tnoremap JK <C-\><C-n>

" refresh
nmap <space>r :w<cr>:source ~/.config/nvim/init.vim<cr>

" refresh NERDTree
" nmap <space>r :NERDTreeRefreshRoot<CR>

" copy all line
nnoremap <space>y ggyG<C-o>zz

" indent whole file
nnoremap <space>= gg=G<C-o>zz

" return to normal mode
inoremap jk <ESC>
inoremap Jk <ESC>
inoremap jK <ESC>
inoremap JK <ESC>

" prevent yank jump back
" vnoremap y ygv<ESC>
" inoremap <C-CR> <ESC><S-A>;
" nnoremap <C-CR> <S-A>;<ESC>

" replace
nnoremap <C-A-h> :%s//g<left><left>

" indent multiple line
vmap <A-l> >gv
vmap <A-h> <gv

" Remove highlight
nnoremap <A-h> :nohl<CR>

" fzf
" noremap ` :Files<CR>
" noremap gs :Ag<CR>

" search without case-sensitive
nnoremap ? /\c

" fix <S-k> visual mode throw error
vnoremap <S-k> <up>
vnoremap <S-j> <down>

" prevent cut or copy of some key
vnoremap c "_c
vnoremap x "_x
nnoremap x "_x
nnoremap c "_c
nnoremap D "_D
nnoremap C "_C
vnoremap p "_dP


nmap <space>q :q<CR>
nmap <space>w :w<CR>
" rename current word like VSCode
" nmap <space>r <Plug>(coc-rename)

" NERDTree
" nnoremap <space>f :NERDTreeToggle<CR>

" open coc-explorer
" nmap <space>f :CocCommand explorer<CR>

" git gutter
" nmap <space>p <Plug>(GitGutterPreviewHunk)
" nmap ghs <Plug>(GitGutterStageHunk)
" nmap ghu <Plug>(GitGutterUndoHunk)

" insert ; to end line
" inoremap <A-CR> <ESC><S-A>;
" nnoremap <A-CR> <S-A>;<ESC>

" move in insert and command mode
" inoremap <C-h> <Left>
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-l> <Right>
" cnoremap <C-h> <Left>
" cnoremap <C-j> <Down>
" cnoremap <C-k> <Up>
" cnoremap <C-l> <Right>

" W to save file
" cabb W w
" cabb Q q

" prevent 'q + :'
" nnoremap q: <CR>

" move line
nnoremap <A-j> :m +1<CR>==
nnoremap <A-k> :m -2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi

tnoremap jk <C-\><C-n>
