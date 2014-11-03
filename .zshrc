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
. ${HOME}/.git_prompt.zsh

# history
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# misc
setopt autocd
setopt extendedglob

# vi key bindings
bindkey -v

# do not require 'rehash' to be run to find new executables
setopt nohashdirs

# misc environmental variables
export CCACHE_COMPRESS=1
export EDITOR=/usr/bin/vim
export ExternalData_OBJECT_STORES=${HOME}/data
export GREP_COLOR="01;32"  # color grep matches green
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export LESS="$LESS -iJ"
PATH="${HOME}/.config/dotfiles/bin:${PATH}"
export PATH="${HOME}/bin/exe:${PATH}"

# misc aliases
alias cmake='cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias ccmake='ccmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias grep='grep --color'
alias gca='git commit -a'
alias gsa='git status'
cores=$(ls /sys/bus/cpu/devices | wc -w)
alias mj="make -j${cores} -l${cores}"
alias nj="ninja -j${cores} -l${cores}"
# This causes aliases passed to the notify script to also
# be expanded before being sent to the script.
alias notify='notify '
alias pyclewn='pyclewn --gdb=async,/tmp/pyclewn_project'
alias wp='wgetpaste --nick thewtex -X'
alias iv='ImageViewer'
alias tmux='tmux -2 a -d || tmux -2'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'

function aunpack() {
  local TMP=$(mktemp /tmp/aunpack.XXXXXXXXXX)
  atool -x --save-outdir=$TMP "$@"
  DIR="$(cat $TMP)"
  [ "$DIR" != "" -a -d "$DIR" ]  && cd "$DIR"
  rm $TMP
}

function ch() {
  cmake --help-command $1 | less ;
}

# need to open port 2628
function dict() {
  curl -s dict://dict.org/d:$1 | perl -ne 's/\r//; last if /^>$/; print if /^151/../^250/';
}

function pps() {
  ps -eF | grep "$@" | grep --colour=auto -v 'grep';
}

ranger() {
  command ranger --fail-unless-cd $@ &&
  cd "$(grep \^\' ~/.ranger/bookmarks | cut -b3-)"
}

function x() {
  echo $1 | xclip ;
}
