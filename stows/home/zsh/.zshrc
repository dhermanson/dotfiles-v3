# SETTINGS
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# FUNCTIONS
function e() {
    # emacsclient -t "$@"
    # emacsclient --no-wait "$@"
    create_emacs_frame_or_use_existing "$@"
}

# ALIASES
alias xup="xrdb ~/.Xresources"


# ANTIGEN
# source the Antigen plugin manager
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bungles from the default repo (robbyrussel's oh-my-zsh)
antigen bundle git
antigen bundle gradle
antigen bundle tmux

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

# SOURCES
# make sure asdf always gets sourced after antigen
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
