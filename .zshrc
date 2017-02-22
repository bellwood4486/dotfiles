echo '.zshrc'

# 環境変数
export LANG=ja_JP.UTF-8
if [ -f $(which vim) ]; then
    export EDITOR=vim
fi

# パス
typeset -U path cdpath fpath manpath # 重複する要素を自動的に削除
path=(
  $HOME/bin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  $path
)

# プロンプト
PROMPT="%F{green}%n@%m%f:%F{blue}%~%f
%# "
PROMPT2="%_%# "
SPROMPT="%r is correct? [n,y,a,e]: "
# ウィンドウのタイトルを動的に変える
case "${TERM}" in
    kterm*|xterm)
        autoload -Uz add-zsh-hook
        function _update_window_title() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD/#$HOME/~}\007"
        }
        add-zsh-hook precmd _update_window_title
        ;;
esac

# gitのブランチを表示(とりあえずコピペ)
# http://mollifier.hatenablog.com/entry/20100906/p1
autoload -Uz add-zsh-hook
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
    zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi
function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

# 補完
autoload -Uz compinit; compinit
setopt list_packed # 補完候補を詰めて表示
setopt nolistbeep # 補完候補表示時などにビープ音を鳴らさない
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

# ヒストリ
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# Emacsキーバインド
bindkey -e

# 履歴検索機能
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# auto_cdを使ってディレクトリ名だけでcdできるようにする
setopt auto_cd

# 移動したディレクトリをpushdで自動記録しておく
setopt auto_pushd

# コマンド名が間違っている場合に修正
# setopt correct

# 先方予測機能を有効に
# autoload predict-on
# predict-on

# {a-z}や{0-9}などを使えるようにする
setopt braceccl

# Alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias df='df -h'
alias du='du -h'
alias less='less -r'
alias whence='type -a'
alias grep='grep --color'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias mkdir='mkdir -p'
# maven
alias dmvn='MAVEN_OPTS="-Xnoagent -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n" mvn'

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
        if [ -f ~/.zshrc_cygwin ]; then
                . ~/.zshrc_cygwin
        fi
fi

if $darwin; then
        if [ -f ~/.zshrc_darwin ]; then
                . ~/.zshrc_darwin
        fi
fi

if $linux; then
        if [ -f ~/.zshrc_linux ]; then
                . ~/.zshrc_linux
        fi
fi

if $msys; then
        if [ -f ~/.zshrc_msys ]; then
                . ~/.zshrc_msys
        fi
fi

# ローカル固有の設定があればそれを読む
if [ -f ~/.zshrc_local ]; then
        . ~/.zshrc_local
fi
