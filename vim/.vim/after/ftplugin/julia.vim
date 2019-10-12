"
" vim config for Julia
"
" Author: Atsushi Sakai
"

let g:julia_lint_ignores = ["E321"]
packadd julia.vim
packadd julia-vim

source ~/.vim/pack/mypackage/opt/julia-vim/ftplugin/juliadoc.vim
syntax on

command! Doc :call JuliaDocstring()

