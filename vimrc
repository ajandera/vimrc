colorscheme desert
set number
set guifont=monaco:h12
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_liststyle = 3
set tabstop=4 softtabstop=0 expandtab shiftwidth=4
set encoding=utf-8
set fileencoding=utf-8

"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType latte set omnifunc=phpcomplete#CompletePHP
autocmd  FileType  php set omnifunc=phpcomplete_extended#CompletePHP
autocmd  FileType  latte set omnifunc=phpcomplete_extended#CompletePHP

syntax on
filetype on
au BufNewFile,BufRead *.latte set filetype=php
au BufNewFile,BufRead *.neon set filetype=php

"function! ToggleVExplorer()
"   if exists("t:expl_buf_num")
"      let expl_win_num = bufwinnr(t:expl_buf_num)
"      if expl_win_num !=1
"         let curl_win_nr = winnr()
"         exec expl_win_num . 'wincmd w'
"         close
"         exec cur_win_nr . 'wincmd w'
"         unlet t:expl_buf_num
"      else
"         unlet t:expl_buf_num
"      endif
"   else
"      exec '1wincmd w'
"      Vexplore
"      let t:expl_buf_num = bufnr("%")
"   endif
"endfunction
"map <silent> <C-E> :call ToggleVExplorer()<CR>   

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Git plugin not hosted on GitHub
Bundle 'Shougo/vimproc'
Bundle 'Shougo/unite.vim'
Bundle 'm2mdas/phpcomplete-extended'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'joonty/vdebug'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'git://github.com/craigemery/vim-autotag.git'
Bundle 'arnaud-lb/vim-php-namespace'
Plugin '2072/PHP-Indenting-for-VIm'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
au! BufWritePost .vimrc so %
au! BufWritePost .gvimrc so %

let g:auto_save = 1  " enable AutoSave on Vim startup

"nerd tree"
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"syntactic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', 'js']

let g:autotagTagsFile=".php"
let g:autotagTagsFile=".latte"
let g:autotagTagsFile=".js"
let g:autotagTagsFile=".css"

"namespaces
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

"imap section
imap <S-space> <C-X><C-O>
imap <S-Tab> <C-D>

" cmd + number for switching tabs
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> 0gt

"duplicate line cmd-d
map <D-d> yyp
map <C-B> :!php -l %<CR>

map <C-E> :NERDTreeToggle<CR>

"show whitespaces
function! Whitespace()
    if !exists('b:ws')
        highlight Conceal ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
        highlight link Whitespace Conceal
        let b:ws = 1
    endif

    syntax clear Whitespace
    syntax match Whitespace / / containedin=ALL conceal cchar=·
    setlocal conceallevel=2 concealcursor=c
endfunction

augroup Whitespace
    autocmd!
    autocmd BufEnter,WinEnter * call Whitespace()
augroup END

"selectiong to hold shift and arrows
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif
