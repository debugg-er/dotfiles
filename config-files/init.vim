call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'

" Plug 'itchyny/lightline.vim'
Plug 'cohama/lexima.vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim'

Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'crusoexia/vim-monokai'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json' " fix indentline on json file
Plug 'mxw/vim-jsx'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

set mouse=a       " mouse enable
set cursorline

set termguicolors
set background=dark

set nowrap        " prevent break line
set colorcolumn=80

" set cmdheight=1
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
set autowrite     " Automatically :write before running commands

set autoindent
set smartindent

set autoread
set autowrite

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
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Show relative number line by default
set number relativenumber

" Folding
set foldmethod=indent
set foldlevel=30 " expand all fold when open file

" System clipboard
set clipboard=unnamedplus

filetype plugin indent on
let g:gruvbox_italic=1
colorscheme gruvbox
syntax enable

" prevent cursorline ignore symbol
hi CursorLine ctermfg=00 ctermbg=00 cterm=bold
hi Normal guibg=NONE ctermbg=NONE

" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['^.git$', '.class$']
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
let NERDTreeMinimalUI=1

" indent tab┊
let g:indentLine_char_list = ['┊']

" resolve indentline conflict with cursorline
let g:indentLine_concealcursor=0

" fix indentLine on json file
let g:vim_json_syntax_conceal = 0

" airline
" let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_y = ''

let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-json',
            \ 'coc-snippets',
            \ 'coc-prettier',
            \ 'coc-eslint',
            \ 'coc-spell-checker'
        \ ]

" open and close nerdtree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" prevent commentary in new line
au Filetype * set fo-=cro

" autoread
au FocusGained,BufEnter * :silent! !

" indent
au FileType javascript set tabstop=2
au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType json set tabstop=2
au FileType json set shiftwidth=2
au FileType json set softtabstop=2

" ================================ mapping ================================


" refresh NERDTree
nmap <space>r :NERDTreeFocus<cr> \| R \| <c-w><c-p>

" return to normal mode
inoremap jk <ESC>
vnoremap ii <ESC>

" prevent yank jump back
" vnoremap y ygv<ESC>
inoremap <C-CR> <ESC><S-A>;
nnoremap <C-CR> <S-A>;<ESC>

" replace
nnoremap <C-A-h> :%s//g<left><left>

" indent multiple line
vmap <A-l> >gv
vmap <A-h> <gv

" Remove highlight
nnoremap <A-h> :nohl<CR>

" fzf
noremap ` :Files<CR>
noremap - :Buffers<CR>

" prevent cut or copy of some key
vnoremap c "_c
vnoremap x "_x
nnoremap x "_x
nnoremap c "_c
nnoremap D "_D
nnoremap C "_C

" rename current word like VSCode
nmap <F2> <Plug>(coc-rename)

" NERDTree
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
nnoremap <F5> :NERDTreeToggle<CR>

" git gutter
nmap <space>p <Plug>(GitGutterPreviewHunk)

" insert ; to end line
inoremap <A-CR> <ESC><S-A>;
nnoremap <A-CR> <S-A>;<ESC>

" move in insert and command mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" easymotion
nmap <space><space> <Plug>(easymotion-bd-w)
nmap <space>f  <Plug>(easymotion-bd-f)
vmap <space><space> <Plug>(easymotion-bd-w)
vmap <space>f  <Plug>(easymotion-bd-f)

" W to save file
cabb W w
cabb Q q

" move line
nnoremap <A-j> :m +1<CR>==
nnoremap <A-k> :m -2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi

" switch tab
nnoremap gn :bn<cr>
nnoremap gp :bp<cr>

" prevent 'q + :'
nnoremap q: <CR>

" smooth scroll
fun! s:smoothScroll(up)
    execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
    redraw
    for l:count in range(3, &scroll, 2)
        sleep 3m
        execute "normal " . (a:up ? "\<c-y>" : "\<c-e>")
        redraw
    endfor
    " bring the cursor in the middle of screen
    execute "normal M"
endf

nnoremap <silent> <c-d> :call <sid>smoothScroll(0)<cr>
nnoremap <silent> <c-u> :call <sid>smoothScroll(1)<cr>

" trim whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

nnoremap <space>t :call TrimWhitespace()<CR>

" code runner
fun Execute(command)
    :w
    :exe "silent !tmux send -t 1 '"a:command""@%"' Enter"
endfun

au FileType c nnoremap <C-A-n> :call Execute("runc")<CR>
au FileType javascript nnoremap <C-A-n> :call Execute("node")<CR>

nnoremap <C-A-b> :exe "silent !tmux send -t 1 ^C"<CR>

" =========================== coc.nvim config ==========================
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <A-t> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" " Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <Leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <Leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <Leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <Leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <Leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Leader>p  :<C-u>CocListResume<CR>
