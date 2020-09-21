# SETTINGS
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

unsetopt nomatch # see https://github.com/thoughtbot/dotfiles/pull/194/commits/330d098a7f4e5bcacb30b2f735e096b6fd3731c8

for file in $HOME/.zshrc.d/*.zsh;
do
  source $file
done
