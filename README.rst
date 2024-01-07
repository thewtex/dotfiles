Development environment configuration files
===========================================

Basic setup
-----------

::

  sudo apt install git
  mkdir -p ~/.config
  cd ~/.config
  git clone --recursive git@github.com:thewtex/dotfiles.git
  cd dotfiles

Debian/Ubuntu setup
-------------------

::

  sudo ./debian-packages

config setup
-------------

::

  ./directory-layout
  ./symlinks-configs
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

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm install --lts
  nvm use --lts


kitty, starship, wezterm, wasmtime, micromamba
-----------------------------------------------

::

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  mkdir -p ~/.terminfo
  rsync -a ~/.local/kitty.app/share/terminfo/x ~/.terminfo/

  curl https://wasmtime.dev/install.sh -sSf | bash

  curl -sS https://starship.rs/install.sh | sh

  wget https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage
  chmod +x WezTerm-nightly-Ubuntu20.04.AppImage
  mv WezTerm-nightly-Ubuntu20.04.AppImage wezterm
  sudo mv wezterm /usr/local/bin/

  "${SHELL}" <(curl -L micro.mamba.pm/install.sh)
