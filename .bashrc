echo '.bashrc'

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

cygwin=false;
darwin=false;
case "$(uname)" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true ;;
esac

# Alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
alias less='less -r'
alias whence='type -a'
alias grep='grep --color'
alias mkdir='mkdir -p'
if $darwin; then
  alias o='open'
elif $cygwin; then
  alias o='cygstart'
fi
if $darwin; then
  alias ls='ls -hFG'
elif $cygwin; then
  alias ls='ls -hF --color=tty'
fi
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
if $darwin; then
  # Emacs
  alias cuiemacs="TERM=xterm-256color /usr/local/bin/emacs -nw"
  alias emacsclient='/usr/local/bin/emacsclient'
  alias emacs='emacsclient -n'
  alias e='emacs'
fi

# 環境固有設定のロード
for file in $(\ls .bashrc_*); do source $file; done
