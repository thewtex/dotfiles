Development environment configuration files
===========================================

Basic setup
-----------

::

  mkdir -p ~/.config
  cd ~/.config
  git clone git@github.com:thewtex/dotfiles.git

gentoo setup
------------

::

  ./gentoo-packages

config setup
-------------

::

  ./directory-layout
  ./symlinks-config

  cd /tmp/ && git clone --depth 1 https://github.com/ryanoasis/nerd-fonts && cd nerd-fonts && ./install.sh

As *root*::

  ./gentoo-packages
  gem install teamocil
