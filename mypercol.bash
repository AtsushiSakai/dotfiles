#!/bin/sh -x
# mypercol
# author: Atsushi Sakai
echo "Source mypercol"

# $B=EJ#MzNr$rL5;k(B
export HISTCONTROL=ignoreboth:erasedups

# $BMzNrJ]B8BP>]$+$i30$9(B
export HISTIGNORE="fg*:bg*:history*:wmctrl*:exit*:ls -al:cd ~"

# $B%3%^%s%IMzNr$K%3%^%s%I$r;H$C$?$N;~9o$r5-O?$9$k(B
export HISTTIMEFORMAT='%Y%m%d %T '

export HISTSIZE=10000

# settings for peco
_replace_by_history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | percol --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": _replace_by_history'
bind    '"\C-xr": reverse-search-history'

bind -x '"\C-x;": READLINE_LINE=${READLINE_LINE:0:${READLINE_POINT}}$(date +%Y%m%d)${READLINE_LINE:${READLINE_POINT}}; ((READLINE_POINT+=8))'

alias phistory="history | percol"

