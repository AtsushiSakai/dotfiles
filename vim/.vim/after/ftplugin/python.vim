"
" vim configuration for python
"
" Author: Atsushi Sakai
"
packadd vim-pydocstring
command! Doc :call pydocstring#insert()

if has("python3") || has("python")
    " auto formatting
    "autocmd BufWritePre <buffer> LspDocumentFormatSync
    command! Doc :call pydocstring#insert()
else
    echo "python is not enabled..."
endif

