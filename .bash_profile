echo '.bash_profile'

if [ -f $(which vim) ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
if [ -d "~/bin" ]; then
    export PATH=~/bin:$PATH
fi
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'

# Load .bashrc & .bashrc_local
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

