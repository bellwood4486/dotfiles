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

##################################################################
#                   環境固有設定のロード                         #
##################################################################

cygwin=false;
darwin=false;
linux=false;
msys=false;
case "$(uname)" in
        CYGWIN*) cygwin=true ;;
        Darwin*) darwin=true ;;
        Linux*)  linux=true ;;
        MSYS*) msys=true ;;
esac

if $cygwin; then
        if [ -f ~/.bashrc_cygwin ]; then
                . ~/.bashrc_cygwin
        fi
fi

if $darwin; then
        if [ -f ~/.bashrc_darwin ]; then
                . ~/.bashrc_darwin
        fi
fi

if $linux; then
        if [ -f ~/.bashrc_linux ]; then
                . ~/.bashrc_linux
        fi
fi

if $msys; then
        if [ -f ~/.bashrc_msys ]; then
                . ~/.bashrc_msys
        fi
fi

# ローカル固有の設定があればそれを読む
if [ -f ~/.bashrc_local ]; then
        . ~/.bashrc_local
fi
