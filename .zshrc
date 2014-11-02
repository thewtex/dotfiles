#!/bin/zsh

# tab completion
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# command correction
setopt correctall

# prompt
autoload -U promptinit
promptinit
prompt adam2
export HISTFILE="$HOME/.history"

# history
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# misc
setopt autocd
setopt extendedglob
