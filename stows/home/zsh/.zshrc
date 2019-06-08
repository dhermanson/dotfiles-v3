# SETTINGS
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

for file in $HOME/.zshrc.d/*.zsh;
do
 source $file
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # do this one separate, since fzf always writes it automatically when running a :PlugUpdate in neovim
