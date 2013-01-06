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

set -o vi

function pps(){ ps -eF | grep "$@" | grep --colour=auto -v 'grep'; }

export HISTTIMEFORMAT="%Y%m%d %H:%M: "
export HISTCONTROL=ignoreboth
export HISTSIZE=2000
shopt -s histappend

[[ -f /etc/profile.d/bash-completion ]] && source /etc/profile.d/bash-completion

source /usr/share/bash-completion/git-prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="verbose"
PS1='\[\033[01;32m\]\u\[\033[00;34m\]@\[\033[01;35m\]\h\[\033[01;36m\] \w$(__git_ps1 " (%s)")\[\033[00;34m\]\$\[\033[00m\] '

# Put your fun stuff here.

#PATH="/home/matt/scripts:/usr/libexec/cw:${PATH}"
export PATH=/home/matt/bin:$PATH

export PYTHONSTARTUP='/home/matt/.pystartup' 
export PYTHONPATH="${PYTHONPATH}"
export LESS="$LESS -iJ"
export GREP_COLOR="01;32"  # color grep matches green
export EDITOR=/usr/bin/vim

alias grep='grep --color'
alias appareo='appareo -d /tmp'
#alias gdb=/mnt/datac/archer/install/bin/gdb
alias gca='git commit -a'
alias gsa='git status'
alias gnuc='git commit -a -e -m "$(/usr/bin/vc-chlog)"'
alias mj='make -j8'
alias pyclewn='pyclewn --gdb=async,/tmp/pyclewn_project'
function pdfrgrep() { find -name "*.pdf"  -print0 -exec pdfgrep -C50 -Hni $1 ‘{}’ \; ; }
alias scre='screen -RD'
# fix crashing at end of video play ?
alias wp='wgetpaste --nick thewtex -X'
alias q='qataki'
alias iv='ImageViewer'
# for pyclewn
alias mq='hg -R $(hg root)/.hg/patches'
alias tmux='tmux a -d || tmux'

function x() { echo $1 | xclip ; }

function em() { ebuild $1 manifest ; git add Manifest ; }

function ch() { cmake --help-command $1 | less ; }
source /home/matt/apps/cmake-completion

export TERM=xterm-256color

# need to open port 2628
dict() { curl -s dict://dict.org/d:$1 | perl -ne 's/\r//; last if /^>$/; print if /^151/../^250/'; }

#if [[ -n ${NXSESSIONID} ]]; then
  #asdf
#fi

#source '/home/matt/scripts/convert3d_bashcomp.sh'

aunpack() {
  local TMP=$(mktemp /tmp/aunpack.XXXXXXXXXX)
  atool -x --save-outdir=$TMP "$@"
  DIR="$(cat $TMP)"
  [ "$DIR" != "" -a -d "$DIR" ]  && cd "$DIR"
  rm $TMP
}

# to allow the creation of core dumps, run this
#ulimit -c unlimited

[ -f /usr/share/cdargs/cdargs-bash.sh ] && \
source /usr/share/cdargs/cdargs-bash.sh

pl() {
  gnuplot -e "set term dumb; plot \"${1}\""
}
ppl() {
  gnuplot -e "plot \"${1}\"; pause -1"
}

ranger() {
  command ranger --fail-unless-cd $@ &&
  cd "$(grep \^\' ~/.ranger/bookmarks | cut -b3-)"
}
