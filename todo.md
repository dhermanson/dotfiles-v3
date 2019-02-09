# Things I need to do
```zsh
➜  ~ function _my_fzf {
BUFFER="fzf"
zle accept-line
}

➜  ~ zle -N _my_fzf

➜  ~ bindkey '\e^f' _my_fzf

```
