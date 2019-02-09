# ANTIGEN
# source the Antigen plugin manager
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bungles from the default repo (robbyrussel's oh-my-zsh)
antigen bundle git
antigen bundle gradle
antigen bundle mvn
antigen bundle tmux

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply
