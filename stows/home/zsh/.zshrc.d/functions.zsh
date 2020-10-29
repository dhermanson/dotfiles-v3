# function e() {
#     create_emacs_frame_or_use_existing "$@"
# }

function jc {
    curl -s -H "Accept: application/json" "$@" | python -m json.tool
}

function i() {
    if [ $# -eq 0 ]; then
        file=$(fzf) && touch $file && idea $file
    else
        touch $@ && idea $@
    fi
}

function deh-open-current-dir-in-emacs-magit() {
    emacsclient -c -n .
    sleep 0.5
    emacsclient -e "(projectile-vc)"
    emacsclient -e "(delete-other-windows)"
}

# fd - cd to selected directory (scope to git repo if in one)
fd() {
  local dir
  toplevel=$(git rev-parse --show-toplevel)
  retval=$?
  if [ $retval -eq 0 ]; then
    relative_to_toplevel=$(find $toplevel -path '*/\.*' -prune -o -type d -print 2> /dev/null | xargs -- realpath --relative-to=$toplevel | fzf +m) &&
    dir=$toplevel/$relative_to_toplevel
  else
    dir=$(find ${1:-.} -path '*/\.*' -prune \
      -o -type d -print 2> /dev/null | fzf +m)
  fi

  cd "$dir"
}
