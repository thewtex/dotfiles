# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

### Shell options ###
set -o vi
shopt -s histappend

### Source functions ###
[[ -f /etc/profile.d/bash-completion.sh ]] && \
  source /etc/profile.d/bash-completion.sh
source ~/.config/dotfiles/.bash_completion.d/cmake-completion

[ -f /usr/share/cdargs/cdargs-bash.sh ] && \
  source /usr/share/cdargs/cdargs-bash.sh

complete -W "$(teamocil --list)" teamocil

### Variables ###
export CCACHE_COMPRESS=1
export EDITOR=/usr/bin/vim
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"
export GREP_COLOR="01;32"  # color grep matches green
export HISTTIMEFORMAT="%Y%m%d %H:%M: "
export HISTCONTROL=ignoreboth
export HISTSIZE=2000
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export LESS="$LESS -iJ"
PATH="${HOME}/.config/dotfiles/bin:${PATH}"
export PATH=/home/matt/bin/exe:$PATH
PS1='\[\033[01;32m\]\u\[\033[00;34m\]@\[\033[01;35m\]\h\[\033[01;36m\] \w$(__git_ps1 " (%s)")\[\033[00;34m\]\$\[\033[00m\] '

### Aliases ###
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
# for pyclewn
alias mq='hg -R $(hg root)/.hg/patches'
alias tmux='tmux -2 a -d || tmux -2'

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

function pdfrgrep() {
  find -name "*.pdf"  -print0 -exec pdfgrep -C50 -Hni $1 ‘{}’ \;
}

function pl() {
  gnuplot -e "set term dumb; plot \"${1}\""
}

function ppl() {
  gnuplot -e "plot \"${1}\"; pause -1"
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
