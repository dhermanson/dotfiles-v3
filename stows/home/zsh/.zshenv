export EDITOR="emacsclient"
export VISUAL="emacsclient"
# export EDITOR="nvim"
# export TERMINAL="urxvtc"
# export DEH_EMACS_SERVER_NAME=server
# export TERMINAL="alacritty"
# export TERMINAL="konsole"
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
# export TERM=xterm-24bit

##############################
# fixes emacs issue
# https://github.com/xmonad/xmonad/issues/34
# export GDK_SCALE=1
# export GDK_DPI_SCALE=1
##############################

# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# export _JAVA_AWT_WM_NONREPARENTING=1 # fix java guis

# kde stuff
# export KDE_SESSION_UID=1000
# export KDE_SESSION_VERSION=5
# export XDG_CURRENT_DESKTOP=KDE

# export XDG_CONFIG_HOME=$HOME/.config

#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
# local executables
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.local/bin

# ruby
export PATH=$PATH:$HOME/.rbenv/bin

# php
export PATH=$PATH:$HOME/.config/composer/vendor/bin

# golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

# java home
# export JAVA_HOME=/usr/lib/jvm/java-11-oracle
# export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
# export JAVA_HOME=/usr/lib/jvm/jdk-11.0.3+7
# export JAVA_HOME=/usr/lib/jvm/jdk8u212-b04
# export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
# export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
