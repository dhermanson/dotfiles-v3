# function e() {
#     create_emacs_frame_or_use_existing "$@"
# }

function e() {
    if [ $# -eq 0 ]; then
        file=$(fzf) && create_emacs_frame_or_use_existing $file
    else
        create_emacs_frame_or_use_existing $@
    fi
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
      -o -type d -print 2> /dev/null | fzf +m) &&
  fi

  cd "$dir"
}
