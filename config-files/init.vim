call plug#begin()

" Plug 'wikitopian/hardmode'
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
" Plug 'ryanoasis/vim-devicons'


Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'crusoexia/vim-monokai'

Plug 'sheerun/vim-polyglot/'
" Plug 'pangloss/vim-javascript'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'elzr/vim-json' " fix indentline on json file
" Plug 'mxw/vim-jsx'

Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

set mouse=a       " mouse enable
set cursorline

set termguicolors

set nowrap        " prevent break line

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
" colorscheme one
" set background=light
set background=dark
syntax enable

" prevent cursorline ignore symbol
hi CursorLine ctermfg=00 ctermbg=00 cterm=bold

" allow transparent
" hi Normal guibg=NONE ctermbg=NONE

" NERDTree
" let NERDTreeShowHidden=1
" let g:NERDTreeIgnore = ['^.git$', '.class$']
" let g:NERDTreeDirArrowExpandable = '+'
" let g:NERDTreeDirArrowCollapsible = '~'
" let NERDTreeMinimalUI=1

" make fuzzy search show hidden file
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:fzf_layout = { 'down': '~40%' }

" indent tab┊
let g:indentLine_char_list = ['┊']

" resolve indentline conflict with cursorline
let g:indentLine_concealcursor = 0

" fix indentLine on json file
" let g:vim_json_syntax_conceal = 0

" disable AutoPairs remap C-H in insert mode
" let g:AutoPairsMapCh = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" let g:airline_powerline_fonts = 1
let g:airline_section_y = ''

let g:coc_global_extensions = [
            \ 'coc-tsserver',
            \ 'coc-json',
            \ 'coc-snippets',
            \ 'coc-prettier',
            \ 'coc-eslint',
            \ 'coc-pairs',
            \ 'coc-explorer',
            \ 'coc-css'
        \ ]

" Open and close nerdtree automatically
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" disable indentLine in coc-explorer
au FileType coc-explorer exec('IndentLinesDisable')

" prevent commentary in new line
au Filetype * set fo-=cro

" autoread
au FocusGained,BufEnter * :silent! !

" indent
au FileType typescript set colorcolumn=100
au FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 colorcolumn=80
au FileType json set tabstop=2 shiftwidth=2 softtabstop=2
au FileType html set tabstop=2 shiftwidth=2 softtabstop=2

" ================================ mapping ================================

" breakline
nmap <S-k> i<CR><ESC>k$

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

" rename current word like VSCode
nmap <F2> <Plug>(coc-rename)

" NERDTree
" nnoremap <space>f :NERDTreeToggle<CR>

" open coc-explorer
nmap <space>f :CocCommand explorer<CR>

" git gutter
nmap <space>p <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

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

" next buffer
nnoremap gn :bn<cr>
" previous buffer
nnoremap gp :bp<cr>
" delete current buffer
nnoremap ge :bp<bar>sp<bar>bn<bar>bd<CR>

" prevent 'q + :'
nnoremap q: <CR>

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

fun GoToBuffer(num)
    let l:bufferDetail=@%
    redir => l:bufferDetail
    :exe "silent :ls"
    redir END

    let l:buffers = []
    let l:regex = '\d\+\( \)\@='
    call substitute(l:bufferDetail, regex, '\=add(l:buffers, submatch(0))', 'g')

    if a:num <= len(l:buffers) && a:num >= 0
        :exec "buffer" l:buffers[a:num - 1]
    endif
endfun

nnoremap <silent> <A-1> :call GoToBuffer(1)<CR>
nnoremap <silent> <A-2> :call GoToBuffer(2)<CR>
nnoremap <silent> <A-3> :call GoToBuffer(3)<CR>
nnoremap <silent> <A-4> :call GoToBuffer(4)<CR>
nnoremap <silent> <A-5> :call GoToBuffer(5)<CR>
nnoremap <silent> <A-6> :call GoToBuffer(6)<CR>
nnoremap <silent> <A-7> :call GoToBuffer(7)<CR>
nnoremap <silent> <A-8> :call GoToBuffer(8)<CR>
nnoremap <silent> <A-9> :call GoToBuffer(9)<CR>

au FileType c nnoremap <C-A-n> :call Execute("runc")<CR>
au FileType cpp nnoremap <C-A-n> :call Execute("runcpp")<CR>
au FileType javascript nnoremap <C-A-n> :call Execute("node")<CR>
au FileType typescript nnoremap <C-A-n> :call Execute("ts-node")<CR>

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

" Improve coc-pairs when breakline
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
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
" Manage extensions
nnoremap <silent> <Leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <Leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <Leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <Leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <Leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <Leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Leader>p  :<C-u>CocListResume<CR>

" =========================== coc.nvim remap ==========================

" Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>
" Fix autofix problem of current line
nmap <space>l <Plug>(coc-fix-current)
" Navigate diagnostics
nmap <silent> <space>k <Plug>(coc-diagnostic-prev)
nmap <silent> <space>j <Plug>(coc-diagnostic-next)

