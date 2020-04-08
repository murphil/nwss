alias rm='rm -i'
alias mv='mv -i'
alias ll='ls -alh'
alias du='du -h'
alias df='df -h'
alias mkdir='mkdir -p'
alias r='grep --color=auto'
alias diff='diff -u'
alias e='code'
alias g='git'
alias s='ssh'
alias sa='ssh-agent $SHELL'
alias sad='ssh-add'
alias t='tmux'
alias tl='tmux list-sessions'
alias ta='tmux attach -t'
alias rs="rsync -avP"

function px { ps aux | grep -i "$*" }
function p { pgrep -a "$*" }
__default_indirect_object="local z=\${@: -1} y=\$1 && [[ \$z == \$1 ]] && y=\"\$default\""


if [ -x "$(command -v nvim)" ]; then
    alias v='nvim'
elif [ -x "$(command -v vim)" ]; then
    alias v='vim'
else
    alias v='vi'
fi

export TIME_STYLE=long-iso
alias n='date +%y%m%d%H%M%S'
alias now='date -Iseconds'
