# In OSX using homebrew-installed zlib, these seemed to be needed by pyenv at
# the very least to avoid various issues, they may affect other languages as
# well.
#
# in pyenv, if this is working you ought to see lines that look like this when
# installing a new python version:
#  python-build: use openssl from homebrew
#  python-build: use readline from homebrew
if [[ -d /usr/local/opt/zlib ]]; then
  export LDFLAGS="-L/usr/local/opt/zlib/lib"
  export CPPFLAGS="-I/usr/local/opt/zlib/include"
fi
if [[ -x $(which xcrun 2> /dev/null) ]]; then
  export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
fi

# Don't let pyenv mess with the prompt, that confuses starship.rs
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  if [ -d  "$HOME"/.pyenv/plugins/pyenv-virtualenv ]; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
