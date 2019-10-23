"
" vim config file
"
" Author: Atsushi Sakai
"

"encoding
set encoding=utf-8
scriptencoding utf-8 
set fileencoding=utf-8 
set fileencodings=utf-8

let g:myvimpath = $HOME . '/dotfiles/vim/'
let g:win_myvimpath = "~\myvim"

"autocmd用 autocmdのすべてにautocmd vimrcとすること
augroup vimrc
  autocmd! 
augroup END

source $VIMRUNTIME/defaults.vim

" setup colorscheme
colorscheme darkblue

"=====Set up filetype===="
filetype on
filetype plugin indent on

" md as markdown, instead of modula2
autocmd vimrc Bufnewfile,bufread *.{mark*,md} set filetype=markdown
autocmd vimrc Bufnewfile,bufread *.{launch,srv} set filetype=xml
autocmd vimrc Bufnewfile,bufread *.jl set filetype=julia
autocmd vimrc Bufnewfile,bufread *.rst set filetype=rst
autocmd vimrc Bufnewfile,bufread *.py set filetype=python

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

"<F5> code run
function! Exe()
  echo "Exe"
  let filename = expand('%:t')
  if stridx(filename, ".py") != -1 
    !python %
  elseif stridx(filename, ".jl") != -1
    !julia %
  elseif stridx(filename, ".cpp") != -1 
    !./build_run.sh
  elseif stridx(filename, ".sh") != -1 
	!./%
  else
	QuickRun
  endif
endfunction
command! Exe :call Exe()

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

"別ファイルで修正された場合に自動読み込み"
set autoread
set ttymouse=xterm2     " setup high function mouse
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く

"検索時に大文字を含んでいたら大/小を区別
set ignorecase smartcase

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

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
nnoremap <space>h :<c-u>tabedit ~/myvim/help.md<CR>

":Vimrcsourceでvimrcを読み込む"
if !exists('*Vimrcsource')
  function! Vimrcsource()
    source ~/myvim/.vimrc
  endfunction
  command! Vimrcsource :call Vimrcsource()
endif

"ctags関係
set tags=~/tags

" For completor
let g:completor_python_binary = "~/.pyenv/shims/python"

" select with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

set shellpipe= " for windows setting
let g:this_is_win = 0

"OS毎の設定
if stridx(system('uname'),'Dar')!=-1
    " Mac環境用のコード
    " echo 'This is mac'

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

	"let g:completor_python_binary = 'C:\ProgramData\Anaconda3\python'

elseif stridx(system('uname'),'Linu')!=-1
    " Linux用のコード
    "echo 'This is unix'

    "日本語入力をノーマルモードでオフにする
    function! ImInActivate()
      call system('fcitx-remote -c')
    endfunction
    inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>

    " Open finder
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

"========ROS=======
let $V_ROS_ROOT='/opt/ros/fuerte/include'
let $V_ROS_TOOLS='~/fuerte_workspace/Tools/'
set path+=$V_ROS_ROOT+$V_ROS_TOOLS

"ROSのトピックのリストを表示するコマンドを有効にする
"source ~/.vim/script/RosTopicList.vim

"ROSのmsgの構成を表示するコマンドを有効にする
"source ~/.vim/script/RosmsgShow.vim

"SVN Commit時にsvn diffの結果を追加する
"source ~/.vim/script/svndiffandcommit.vim

"catkin_makeを実施するコマンドを有効化
"source ~/.vim/script/RosCatkinMake.vim

"catkin_makeを実施するコマンドを有効化
"source ~/.vim/script/DecimalChange.vim

"Translateコマンド
"source ~/.vim/script/Translate.vim

"Cppコマンド
"source ~/.vim/script/ComfortableCpp.vim

"gvimのCdCurrentを設定 "
"command! -nargs=0 CdCurrent cd %:p:h

" Ctrl x completion
let s:compl_key_dict = {
      \ char2nr("\<C-l>"): "\<C-x>\<C-l>",
      \ char2nr("\<C-n>"): "\<C-x>\<C-n>",
      \ char2nr("\<C-p>"): "\<C-x>\<C-p>",
      \ char2nr("\<C-k>"): "\<C-x>\<C-k>",
      \ char2nr("\<C-t>"): "\<C-x>\<C-t>",
      \ char2nr("\<C-i>"): "\<C-x>\<C-i>",
      \ char2nr("\<C-]>"): "\<C-x>\<C-]>",
      \ char2nr("\<C-f>"): "\<C-x>\<C-f>",
      \ char2nr("\<C-d>"): "\<C-x>\<C-d>",
      \ char2nr("\<C-v>"): "\<C-x>\<C-v>",
      \ char2nr("\<C-u>"): "\<C-x>\<C-u>",
      \ char2nr("\<C-o>"): "\<C-x>\<C-o>",
      \ char2nr('s'): "\<C-x>s",
      \ char2nr("\<C-s>"): "\<C-x>s"
      \}

let s:hint_i_ctrl_x_msg = join([
      \ '<C-l>: While lines',
      \ '<C-n>: keywords in the current file',
      \ "<C-k>: keywords in 'dictionary'",
      \ "<C-t>: keywords in 'thesaurus'",
      \ '<C-i>: keywords in the current and included files',
      \ '<C-]>: tags',
      \ '<C-f>: file names',
      \ '<C-d>: definitions or macros',
      \ '<C-v>: Vim command-line',
      \ "<C-u>: User defined completion ('completefunc')",
      \ "<C-o>: omni completion ('omnifunc')",
      \ "s: Spelling suggestions ('spell')"
      \], "\n")
function! s:hint_i_ctrl_x() abort
  echo s:hint_i_ctrl_x_msg
  let c = getchar()
  return get(s:compl_key_dict, c, nr2char(c))
endfunction

inoremap <expr> <C-x>  <SID>hint_i_ctrl_x()

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
set laststatus=2
set statusline=%<%f%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [ENC=%{&fileencoding}]

" LSP Setting
let g:lsp_log_verbose = 1  " デバッグ用ログを出力
"let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定

" Language Server setting
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

augroup MyLsp
  autocmd!

  " For Python
  if executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {
        \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
        \})
    autocmd FileType python call s:configure_lsp()
  endif

  " For Julia (this does not work in windows)
  if executable('julia') && g:this_is_win == 0
    let s:julia_exe = $JULIA_EXE_FOR_VIM
    let s:julia_lsp_startscript = g:myvimpath . '/.vim/script/startlanguageserver.jl'
    autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'julia',
    \ 'cmd': {server_info->[s:julia_exe, '--startup-file=no', '--history-file=no', s:julia_lsp_startscript]},
    \ 'whitelist': ['julia'],
    \ })
  endif

  " for java
  if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.300.v20190213-1655.jar'),
        \     '-configuration',
        \     expand('~/lsp/eclipse.jdt.ls/config_mac'),
        \     '-data',
        \     getcwd()
        \ ]},
        \ 'whitelist': ['java'],
        \ })

    " for cpp
    if executable('clangd')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-background-index']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })
    endif
endif

augroup END

""" Automatic hover docstring like IDE """
autocmd CursorMoved,CursorMovedI * call s:cursor_moved()
function! s:cursor_moved() abort
    if exists('s:timer_id')
        call timer_stop(s:timer_id)
    endif
    let s:timer_id = timer_start(3000, function('s:enable_hover'))
endfunction

function! s:enable_hover(timer_id) abort
    ":LspHover
endfunction


function! s:configure_lsp() abort
  setlocal omnifunc=lsp#complete
  nnoremap <buffer> gd :<C-u>LspReferences<CR>
  nnoremap <buffer> gD :<C-u>LspDefinition<CR>
  nnoremap <buffer> K :<C-u>LspHover<CR>
  "nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
  nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
  nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
  nnoremap <buffer> <space>r :<C-u>LspRename<CR>
endfunction
