# this is for homebrew's ruby-build
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# https://github.com/rbenv/ruby-build/issues/1353#issuecomment-551348180
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"

