
function _my_emacsclient {
  BUFFER="e"
  zle accept-line
}

zle -N _my_emacsclient

bindkey '\e^o' _my_emacsclient
bindkey '\e^f' _my_emacsclient
