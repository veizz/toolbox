set tabstop=4
set smarttab
set shiftwidth=4
set expandtab
set autoindent
set hlsearch
set ignorecase
set is
set nu
filetype off
syntax on
filetype plugin indent on
"set encoding
set encoding=utf8
set fileencodings=utf8,gbk,ucs-bom,cp936
set fileencoding=utf8

set laststatus=2

highlight StatusLine cterm=bold ctermfg=blue ctermbg=grey

" On OSX, map control-c to copy to system clipboard
"vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
"vmap <D-c> y:call system("pbcopy", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

" pathogen plugin
"call pathogen#infect()

"vim markdown options
"let g:vim_markdown_folding_disabled=1
