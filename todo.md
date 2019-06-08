# Things I need to do
```zsh
➜  ~ function _my_fzf {
BUFFER="fzf"
zle accept-line
}

➜  ~ zle -N _my_fzf

➜  ~ bindkey '\e^f' _my_fzf

```

```sh
function _my_emacsclient {
BUFFER="e"
zle accept-line
}

zle -N _my_emacsclient

bindkey '\e^o' _my_emacsclient
bindkey '\e^f' _my_emacsclient
```
