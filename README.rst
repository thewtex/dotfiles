Development environment configuration files
===========================================

GitHub CLI
----------

::

  (type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
  && sudo mkdir -p -m 755 /etc/apt/keyrings \
  && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
  && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

  gh extension install github/gh-copilot

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
  chsh -s /bin/zsh matt

Rust packages
-------------------

::

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  source $HOME/.cargo/env
  ./rust-clis.sh

pnpm, node, kitty, starship, wezterm, wasmtime, micromamba
-----------------------------------------------

::

  curl -fsSL https://get.pnpm.io/install.sh | sh -

  pnpm env use --global lts

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
