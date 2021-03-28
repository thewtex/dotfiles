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

Rust packages
-------------------

::

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  ./rust-clis.sh

Install nvm, node
------------------

::

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install --lts
  nvm use --lts

config setup
-------------

::

  ./directory-layout
  ./symlinks-config

  cd .vim/bundle/YouCompleteMe
  ./install.py --ninja --ts-completer --clang-completer --rust-completer
  cd -

  cd /tmp/ && git clone --depth 1 https://github.com/ryanoasis/nerd-fonts && cd nerd-fonts && ./install.sh
  cd /tmp/ && git clone --depth 1 https://github.com/powerline/fonts && cd fonts && ./install.sh
