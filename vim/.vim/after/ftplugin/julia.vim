"
" vim config for Julia
"
" Author: Atsushi Sakai
"

let g:julia_lint_ignores = ["E321"]
packadd julia.vim
packadd julia-vim
syntax on

let g:latex_to_unicode_auto = 1

command! Doc :call JuliaDocstring()

if has('terminal')
    function! s:JuliaREPL()
        :vert term ++close bash -c julia 
    endfunction
    command! REPL :call s:JuliaREPL() " Open JuliaREPL
end


