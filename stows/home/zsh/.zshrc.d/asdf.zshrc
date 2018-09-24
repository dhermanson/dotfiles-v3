# make sure asdf always gets sourced after antigen
[ -f $HOME/.asdf/asdf.sh ] && source $HOME/.asdf/asdf.sh
[ -f $HOME/.asdf/completions/asdf.bash ] && source $HOME/.asdf/completions/asdf.bash

asdf_update_java_home() {
  local current
  if current=$(asdf current java); then
    local version=$(echo $current | sed -e 's|\(.*\) \?(.*|\1|g')
    export JAVA_HOME=$(asdf where java $version)
  else
    echo "No java version set. Type `asdf list-all java` for all versions."
  fi
}

asdf_update_java_home
