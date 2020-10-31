if test -e /usr/bin/keychain; then
  /usr/bin/keychain ~/.ssh/id_rsa
  . ~/.keychain/$HOSTNAME-sh
fi

source ~/.bashrc

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
