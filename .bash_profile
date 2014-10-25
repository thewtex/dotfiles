if test -e /usr/bin/keychain; then
  /usr/bin/keychain ~/.ssh/id_rsa
  . ~/.keychain/$HOSTNAME-sh
  . ~/.keychain/$HOSTNAME-sh-gpg
fi

source ~/.bashrc
