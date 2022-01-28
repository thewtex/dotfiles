Development environment configuration files
===========================================

Basic setup
-----------

::

  mkdir -p ~/.config
  cd ~/.config
  git clone --recursive git@github.com:thewtex/dotfiles.git

Debian/Ubuntu setup
-------------------

::

  sudo ./debian-packages

config setup
-------------

::

  ./directory-layout
  ./symlinks-config
  ./install-fonts

Rust packages
-------------------

::

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  ./rust-clis.sh

Install nvm, node
------------------

::

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install --lts
  nvm use --lts


YouComplete, kitty
--------------------------

::

  cd .vim/bundle/YouCompleteMe
  ./install.py --ninja --ts-completer --clang-completer --rust-completer --system-libclang
  cd -

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
  sudo apt install gh
