#!/bin/sh -x
# mypercol
# author: Atsushi Sakai
# echo "Source mypercol"

#========history search=======
# $B=EJ#MzNr$rL5;k(B
export HISTCONTROL=ignoreboth:erasedups
#history$B$NJ]B8$N?t$r(B10000$B$K(B
export HISTSIZE=10000

replace_by_history() {
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
#bind $B$7$J$$$HA*$s$@J8;zNs$,A^F~$5$l$J$$(B
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

  #.bashrc$B:G8e$K0J2<$r=q$/$3$H$G%m%0%*%U;~$KMzNr$r=q$-9~$`!#(B
  function exit(){
    dirssave
    builtin exit
  }
  
  #.bashrc$B:G8e$K0J2<$r=q$/$3$H$G%m%0%$%s;~$KMzNr$rFI$_9~$`!#(B
  dirsload

