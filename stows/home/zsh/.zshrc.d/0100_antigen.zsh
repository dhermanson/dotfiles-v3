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
# antigen theme robbyrussell
# antigen theme candy
antigen theme bira
# antigen theme theunraveler
# antigen theme bender
# antigen theme gozilla
# antigen theme terminalparty
# antigen theme kardan
# antigen theme refined
# antigen theme gentoo
# antigen theme sorin
# antigen theme gnzh
# antigen theme mh
# antigen theme agnoster
# antigen theme common
# antigen theme denysdovhan/spaceship-prompt

# Tell Antigen that you're done.
antigen apply
