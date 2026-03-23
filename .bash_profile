if test -e /usr/bin/keychain; then
  /usr/bin/keychain ~/.ssh/id_rsa
  . ~/.keychain/$HOSTNAME-sh
fi

source ~/.bashrc

. "$HOME/.cargo/env"
. "$HOME/.local/bin/env"
