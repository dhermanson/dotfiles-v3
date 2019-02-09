export EDITOR="emacsclient"
export TERMINAL="urxvt"

##############################
# fixes emacs issue
# https://github.com/xmonad/xmonad/issues/34
# export GDK_SCALE=1
# export GDK_DPI_SCALE=1
##############################

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export _JAVA_AWT_WM_NONREPARENTING=1 # fix java guis

# kde stuff
# export KDE_SESSION_UID=1000
export KDE_SESSION_VERSION=5
export XDG_CURRENT_DESKTOP=KDE

export PATH=$PATH:/usr/local/go/bin:$HOME/bin:$HOME/.local/bin:$HOME/.config/composer/vendor/bin
