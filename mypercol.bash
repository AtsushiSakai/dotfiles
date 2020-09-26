#!/bin/sh -x
# mypercol
# author: Atsushi Sakai
# echo "Source mypercol"

#========history search=======
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000

alias percol='fzf'

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always %'"


# file search and open vim
f_file_search() {
    vim $(fzf)
}

# fcoc_preview - checkout git commit with previews
f_git_checkout() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
f_git_commit_show() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fuzzy branch search
f_git_change_branch() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

_replace_by_history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | percol --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": _replace_by_history'

#=====For rostopic or rosnode=====
function rosn() {
    if [ "$1" = "" ]; then
        topic=$(rosnode list | percol | xargs -n 1 rosnode info | percol | sed -e 's%.* \* \(/[/a-zA-Z0-9_]*\) .*%\1%')
    else
        topic=$(rosnode info $1 | percol | sed -e 's%.* \* \(/[/a-zA-Z0-9_]*\) .*%\1%')
    fi
    if [ "$topic" != "" ] ; then
        rost $topic
    fi
}
function rost() {
    if [ "$1" = "" ]; then
        node=$(rostopic list | percol | xargs -n 1 rostopic info | percol | sed -e 's%.* \* \(/[/a-zA-Z0-9_]*\) .*%\1%')
    else
        node=$(rostopic info $1 | percol | sed -e 's%.* \* \(/[/a-zA-Z0-9_]*\) .*%\1%')
    fi
    if [ "$node" != "" ] ; then
        rosn $node
    fi
}

function _rostopicecho() {
    declare topic=$(rostopic list | percol --query "$READLINE_LINE")
    cmd='rostopic echo '$topic
    READLINE_LINE="$cmd"
    READLINE_POINT=${#cmd}
}
#bind しないと選んだ文字列が挿入されない
bind -x '"\C-e": _rostopicecho'

#====For cd ranking====

function cd(){
     builtin pushd ${1:-$HOME} > /dev/null
     cnt=`builtin dirs -v -l |grep ${PWD}$|wc -l`
     if [ $cnt -gt 1 ];then
       popd_num=`builtin dirs -v -l |grep ${PWD}$|tail -1|awk 'BEGIN {FS=" "}{print $1}'`
       builtin popd \+${popd_num} > /dev/null
     fi
   }
  function dirs(){
    if [ $# -eq 0 ]; then
        builtin dirs -v -l|sort -k 2
    else
      builtin dirs $*
    fi
  }
  function dirsload(){
    if [ ! -f ${HOME}/.bash_dirs ]; then
      touch ${HOME}/.bash_dirs
      return
    fi
    local __PWD=${PWD}
    export FILES=`awk '{print $1}' ${HOME}/.bash_dirs`;
    for FILE in $FILES;
    do
      cd $FILE >/dev/null 2>&1;
    done
    cd ${__PWD}
  }

  function dirssave(){
    if [ ! -f ${HOME}/.bash_dirs ]; then
      touch ${HOME}/.bash_dirs
      return
    fi
    builtin dirs -p -l >>${HOME}/.bash_dirs
    sed "s@^~@`echo ${HOME}`@g" ${HOME}/.bash_dirs|sort |uniq >${HOME}/.bash_dirs.tmp
    cat ${HOME}/.bash_dirs.tmp > ${HOME}/.bash_dirs
    \rm ${HOME}/.bash_dirs.tmp
  }

  alias dg='dirs|grep'

  #.bashrc最後に以下を書くことでログオフ時に履歴を書き込む。
  function exit(){
    dirssave
    builtin exit
  }
  
  #.bashrc最後に以下を書くことでログイン時に履歴を読み込む。
  dirsload

