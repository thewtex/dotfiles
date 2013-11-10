Development environment configuration files
===========================================

Basic setup
-----------

::

  mkdir -p ~/.config
  cd ~/.config
  git clone git@github.com:thewtex/dotfiles.git

.bashrc setup
-------------

::

  ln -s ~/.config/.bash_profile ~/.bash_profile
  ln -s ~/.config/.bashrc ~/.bashrc

As *root*::

  emerge ranger cdargs pdfgrep keychain flake8 clang ctags fortune-mod-all atool tig
  eselect bashcomp enable --global bash-builtins configure eix gdb git git-prompt gpg2 imagemagick make python ssh tig vim
  gem install teamocil
