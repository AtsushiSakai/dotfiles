"
" vim config file
"
" Author: Atsushi Sakai
"

"encoding
"set encoding=utf-8
scriptencoding utf-8 
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8

source $VIMRUNTIME/defaults.vim

" setup colorscheme
colorscheme darkblue

" git commit spell check setting
augroup GitSpellCheck
    autocmd!
    autocmd FileType gitcommit setlocal spell
augroup END

" Do not read vimrc at git commit 
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
  finish
end

let g:myvimpath = $HOME . '/dotfiles/vim/'

"autocmd用 autocmdのすべてにautocmd vimrcとすること
augroup vimrc
  autocmd! 
augroup END


"=====Set up filetype===="
"filetype on
"filetype plugin indent on

" md as markdown, instead of modula2
autocmd vimrc Bufnewfile,bufread *.{mark*,md} set filetype=markdown
autocmd vimrc Bufnewfile,bufread *.{launch,srv} set filetype=xml
autocmd vimrc Bufnewfile,bufread *.jl set filetype=julia
autocmd vimrc Bufnewfile,bufread *.rst set filetype=rst
autocmd vimrc Bufnewfile,bufread *.py set filetype=python

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunction

"netrw settings
let g:netrw_liststyle=1
let g:netrw_sizestyle="h"
let g:netrw_timefmt="%Y/%m/%d:%H:%M:%S"
let g:netrw_preview=1 " vertial prevbiew

"Quick run setting
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'terminal',
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }

command! Exe :QuickRun
nmap <F5> :Exe

" Ideavim compatible map
nnoremap <C-r> :Exe<CR>
nnoremap <C-d> :Doc<CR>

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"nerdcommenter用 cc でコメントorコメントアウト
nmap cc <Plug>NERDCommenterToggle
vmap cc <Plug>NERDCommenterToggle

"MRUスペースx2で過去に修正したファイルエクスプローラを起動する(MRU)
nnoremap <space><space> :<c-u>MRU<CR>

" 検索時に検索文字を真ん中に持ってくる
nnoremap n nzzzv
nnoremap N Nzzzv

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

set nofoldenable    " disable folding

" Initial template setting
augroup templateGroup
autocmd!
autocmd BufNewFile *.py 0r $HOME/.vim/snippets/python.py
autocmd BufNewFile *.jl 0r $HOME/.vim/snippets/julia.jl
autocmd BufNewFile *.sh 0r $HOME/.vim/snippets/shellscript.sh
augroup END

set binary
set hlsearch
set ignorecase
set smartcase
set wrapscan

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

set autoread            "別ファイルで修正された場合に自動読み込み
set mouse=a             " for window size adustment in ubuntu
set ttymouse=xterm2     " setup high function mouse
"set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
"set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く

"検索時に大文字を含んでいたら大/小を区別
set ignorecase smartcase

" 閉じ括弧を表示した時に，対応する括弧を表示する
set showmatch

set backup
set backupdir=~/.vim/backup/
set undofile
set undodir=~/.vim/undo/
set noswapfile
set number "line number
set cindent "auto indent

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mm

set title

" tabsetting: converting tab to space 4
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

" clipboard setting
if has('clipboard') 
  vmap ,y "+y 
  nmap ,p "+gp 
  " exclude:{pattern} must be last ^= prepend += append 
  if has('gui_running') || has('xterm_clipboard') 
    silent! set clipboard^=unnamedplus 
    set clipboard^=unnamed 
  endif 
endif 

" past error prevention
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

set clipboard+=unnamed
set clipboard+=autoselect

" 挿入モード終了時に ime 状態を保存しない
inoremap <silent> <esc> <esc>
inoremap <silent> <c-[> <esc>

"w!!でsudoで保存"
cabbr w!! w !sudo tee > /dev/null %

"Open vimrc
nnoremap <space>. :<c-u>tabedit $MYVIMRC<CR>

"Open help.md
nnoremap <space>h :<c-u>tabedit ~/dotfiles/vim/help.md<CR>

":Vimrcsourceでvimrcを読み込む"
if !exists('*Vimrcsource')
  function! Vimrcsource()
    source ~/.vimrc
  endfunction
  command! Vimrcsource :call Vimrcsource()
endif

"ctags関係
set tags=~/tags

" select with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

set shellpipe= " for windows setting
let g:this_is_win = 0

"OS毎の設定
if stridx(system('uname'),'Dar')!=-1
    " Mac環境用のコード
    "echo 'This is mac'

    " Mac の辞書.appで開く {{{
    " 引数に渡したワードを検索
    command! -nargs=1 MacDict      call system('open '.shellescape('dict://'.<q-args>))
    " カーソル下のワードを検索
    command! -nargs=0 MacDictCWord call system('open '.shellescape('dict://'.shellescape(expand('<cword>'))))
    " 辞書.app を閉じる
    command! -nargs=0 MacDictClose call system("osascript -e 'tell application \"Dictionary\" to quit'")
    " 辞書にフォーカスを当てる
    command! -nargs=0 MacDictFocus call system("osascript -e 'tell application \"Dictionary\" to activate'")

    let g:completor_clang_binary = '/usr/bin/clang'

    " Open finder
    command! Open !Open .

	set t_Co=256

elseif stridx(system('uname'),'MING')!=-1 || has("win32") || $WSL != ""
    " Windows環境用のコード
    "echo 'This is win or WSL'
    "
    set encoding=utf-8
    set redrawtime=20000 " for syntax on broken problem

    if $WSL == "" "not for WSL
        let g:this_is_win = 1
    endif

	let Grep_Shell_Quote_Char = "'"
	let Grep_Shell_Escape_Char = '\'

    "Unixのファイルの改行コードをそのままにしておく(^Mを表示させない)
	autocmd vimrc BufNewFile,BufRead * edit ++ff=dos

    " Open finder
    command! Open !start .

elseif stridx(system('uname'),'Linu')!=-1
    " Linux用のコード
    "echo 'This is unix'

    "" Open finder
    command! Open !Open .

endif

"======Interactive Replace======"
" irでカーソル下のキーワードをreplace
function! s:interactive_replace()
	let fromstr = input("Replace from: ", expand("<cword>")) | echo "\r"
	let tostr = input("Replace to: ") | echo "\r"
	let cmd = "%s;".fromstr.';'.tostr.";g"
	call feedkeys(':' . cmd, 'n') "insert command
endfunction
command! InteractiveReplace :call s:interactive_replace()
omap <expr> ir ':InteractiveReplace<CR>'

"======Grep======"
if executable('jvgrep')
  set grepprg=jvgrep
endif

let Grep_Skip_Dirs = '.svn .git'  "無視するディレクトリ
let Grep_Default_Options = '-I'   "バイナルファイルがgrepしない
let Grep_Skip_Files = '*.bak *~'  "バックアップファイルを無視する

" grでカーソル下のキーワードを再帰grep
nnoremap <expr> gr ':Rgrep<CR>'

"gvimのCdCurrentを設定 "
command! -nargs=0 CdCurrent cd %:p:h

" Terminal setting
if has('terminal')
    function! s:Terminal()
        if g:this_is_win == 0
            :vert terminal ++close bash --login
        else
            :vert terminal ++close /usr/bin/bash --login
        endif
    endfunction
    command! Terminal :call s:Terminal() " Open Terminal
    tnoremap <Esc><Esc><Esc> <C-\><C-N> " Change to normal mode with Esc+Esc+Esc
    tnoremap <Esc><Esc> <C-w><C-c> " Close terminal with Esc
end

" Statuslineの設定
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
set laststatus=2
set statusline=%t\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ %{fugitive#statusline()}\ [%{ff_table[&ff]}]\ [ENC=%{&fileencoding}]

" Language Server setting
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:lsp_diagnostics_echo_cursor = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    "nmap <buffer> lr <plug>(lsp-references)
    nmap <buffer> <F3> <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <F6> <plug>(lsp-rename)
    nmap <buffer> <F2> <Plug>(lsp-next-diagnostic)
    nmap <buffer> <F1> <plug>(lsp-hover)
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'priority': 15,
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

