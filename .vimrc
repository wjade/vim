set guifont=Consolas:h10:cANSI
set hlsearch
set incsearch
set ignorecase
set relativenumber
set number
set nowrap
set encoding=utf-8

syntax on
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ycm-core/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
Plugin 'morhetz/gruvbox'
Plugin 'preservim/nerdtree'
Plugin 'Yggdroot/LeaderF'
Plugin 'jremmen/vim-ripgrep'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
call vundle#end()

colorscheme gruvbox
set background=dark
let mapleader=","

noremap <silent> <Leader>H :vertical resize +30<CR>
noremap <silent> <Leader>L :vertical resize -30<CR>
noremap <silent> <Leader>J :resize +15<CR>
noremap <silent> <Leader>K :resize -15<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" <Leader>f{char} to move to {char}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

nnoremap <space> <Leader>w
nmap <space> <Leader>w

map ; <C-o>
map ' <C-i>
nmap ; <C-o>
nmap ' <C-i>

"NerdTree mapping
noremap <leader>nf : NERDTreeFind<CR>
noremap <leader>nt : NERDTreeToggle<CR>


"map <Leader>fr :Leaderf! rg<CR>
let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
xnoremap gy :<C-U><C-R>=printf("Leaderf! rg -F -e @* ")<CR>

"noremap <leader>fc :<C-U><C-R>=printf("Leaderf! --stayOpen rg %s", expand("<cword>"))<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("Leaderf! rg %s", expand("<cword>"))<CR><CR>
noremap <leader>fr :Leaderf! --stayOpen rg

fun! GoYCM()
    noremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
    noremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
    noremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>
endfun

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

fun! GoCoc()
    inoremap <buffer> <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()

    inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <buffer> <silent><expr> <C-space> coc#refresh()

    " GoTo code navigation.
    map <buffer> <leader>gd <Plug>(coc-definition)
    map <buffer> <leader>gy <Plug>(coc-type-definition)
    map <buffer> <leader>gi <Plug>(coc-implementation)
    map <buffer> <leader>gr <Plug>(coc-references)
    noremap <buffer> <leader>cr :CocRestart
endfun

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

"autocmd BufWritePre * :call TrimWhitespace()
autocmd FileType typescript :call GoYCM()
autocmd FileType cpp,cxx,h,hpp,c,cs :call GoYCM()

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

command CDC cd %:p:h
command CDR cd $INETROOT
command CDT cd $INETROOT/testsrc
command CP let @*=expand("%:p:h")
command CF let @*=expand("%:p")

command Diff execute 'w !git diff --no-index % -'
