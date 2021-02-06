export PATH="$HOME/.jenv/bin:$PATH"

# eval "$(jenv init -)"

# jenv enable-plugin export >/dev/null 2>/dev/null 

if command -v jenv &> /dev/null
then
  _evalcache jenv init -
fi
