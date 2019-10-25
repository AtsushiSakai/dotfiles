" vim configuration for json
" Author: Atsushi Sakai
 "echo "json on"

"JSON format
function! JsonFormat()
	%!python -m json.tool
endfunction
command! JsonFormat :call JsonFormat()

"JSON viewer
function! JsonViewer()
	"%!python -m pyjsonviewer -f % > /dev/null
  	let filename = expand('%')
	let s:job = job_start(
	\   ["/bin/sh", "-c", "python -m pyjsonviewer -f".filename],{})
endfunction
command! JsonViewer :call JsonViewer()
