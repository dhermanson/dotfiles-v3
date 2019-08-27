
function _my_emacsclient {
  BUFFER="e"
  zle accept-line
}

zle -N _my_emacsclient

bindkey '\e^o' _my_emacsclient
bindkey '\e^f' _my_emacsclient

function _my_magit {
  BUFFER="magit"
  zle accept-line
}

zle -N _my_magit

# Ctrl-Alt-x prefixed
# Alt-c prefixed
bindkey '\ec\ef' _my_emacsclient

bindkey '\ec\eg\es' _my_magit
# bindkey '\e^f' _my_emacsclient
