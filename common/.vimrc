"设置tab宽度为4个空格
set tabstop=4
"设置按下tab时，显示的空白宽度为4个空格的宽度
set softtabstop=4
"设置当在使用shift+, 或者使用shift+.的时候
" ，缩进的宽度为4个空格
set shiftwidth=4
"在行首的时候，按tab，缩进shiftwidth个空格宽度的空白
"在非行首的地方，按tab，按照tabstop个空格的空白处理
set smarttab
"设置当按下tab时，转化为对应个数的空格
set expandtab
"自动缩进，自动对齐
set autoindent
"搜索时高亮
set hlsearch
"搜索时忽略大小写
set ignorecase
"increse search, 搜索时，逐字搜索，而不是按下enter才去搜索
set is
"设置显示行号，number
set nu
"支持按照文件扩展名判断
filetype off
"打开语法高亮
syntax on
"支持按照文件扩展名进行插件和缩进的选择
filetype plugin indent on

"设置文件编码
"set encoding
set encoding=utf8
set fileencodings=utf8,gbk,ucs-bom,cp936
set fileencoding=utf8

"设置一直显示状态条
set laststatus=2
"设置状态条的颜色等
highlight StatusLine cterm=bold ctermfg=blue ctermbg=grey

" 设置打开文件时，返回上一次光标所在的位置
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  "autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

"
" On OSX, map control-c to copy to system clipboard
"vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
"vmap <D-c> y:call system("pbcopy", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>p

"
" pathogen plugin
"call pathogen#infect()

"
"vim markdown options
"let g:vim_markdown_folding_disabled=1

"设置doxgenToolkit插件的参数，自动生成注释的时候使用
"doxgenToolkit
"let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
"let g:DoxygenToolkit_paramTag_pre="@Param "
"let g:DoxygenToolkit_returnTag="@Returns  "
"let g:DoxygenToolkit_blockHeader="---------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="---------------------------------------------------------------"
"let g:DoxygenToolkit_authorName="veizz: veizzsmile@gmail.com"
"let s:licenceTag="Copyright (C) \<enter>"
"let s:licenceTag=s:licenceTag."mit license. http://mit-license.org/"
"let g:DoxygenToolkit_licenseTag=s:licenceTag
"===============================================================
