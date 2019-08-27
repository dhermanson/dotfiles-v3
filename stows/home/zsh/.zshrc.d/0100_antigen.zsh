# ANTIGEN
# source the Antigen plugin manager
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussel's oh-my-zsh)
antigen bundle git
antigen bundle gradle
antigen bundle mvn
antigen bundle tmux

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell
# antigen theme candy
# antigen theme gozilla
# antigen theme terminalparty
# antigen theme refined
# antigen theme gentoo
# antigen theme sorin
# antigen theme bira
# antigen theme gnzh
# antigen theme mh
# antigen theme agnoster

# Tell Antigen that you're done.
antigen apply
