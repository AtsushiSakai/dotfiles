" vim configuration for cpp
" Author: Atsushi Sakai
" echo "cpp"

" auto formatting
autocmd BufWrite *.{cpp} :LspDocumentFormat
autocmd BufWrite *.{hpp} :LspDocumentFormat
autocmd BufWrite *.{c} :LspDocumentFormat
autocmd BufWrite *.{h} :LspDocumentFormat

let g:quickrun_config.cpp = {
\   'command': 'g++',
\   'cmdopt': '-std=c++11'
\ }

setlocal autoindent
setlocal indentexpr=GetHaskellIndent()
setlocal indentkeys=!^F,o,O
setlocal cindent

setlocal expandtab
setlocal tabstop<
setlocal softtabstop=2
setlocal shiftwidth=2

" make/cmake file 
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

