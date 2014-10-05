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

.bashrc setup
-------------

::

  ln -s ~/.config/.bash_profile ~/.bash_profile
  ln -s ~/.config/.bashrc ~/.bashrc

As *root*::

  ./gentoo-packages
  gem install teamocil
