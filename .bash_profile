if test -e /usr/bin/keychain; then
  /usr/bin/keychain ~/.ssh/id_rsa
  . ~/.keychain/$HOSTNAME-sh
fi

source ~/.bashrc

. "$HOME/.cargo/env"
. "$HOME/.deno/env"
source /home/matt/.local/share/bash-completion/completions/deno.bash
. "$HOME/.local/bin/env"
