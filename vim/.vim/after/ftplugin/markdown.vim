" vim configuration for markdown
" Author: Atsushi Sakai
"echo "markdown on"

packadd previm

"let g:previm_open_cmd = 'open -a Safari'
"let g:previm_open_cmd = 'open -a Firefox'
let g:previm_open_cmd = 'open -a "Google Chrome"'

" <F5>で編集中のファイルをブラウザで表示
nmap <F5> :PrevimOpen<CR>

