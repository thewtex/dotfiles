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

  ln -s ~/.config/.bashrc ~/.bashrc

As *root*::

  
  emerge gnuplot ranger
  eselect bashcomp enable --global bash-builtins configure eix gdb git git-prompt gpg2 imagemagick make python ssh starcluster-completion.sh tig vim
