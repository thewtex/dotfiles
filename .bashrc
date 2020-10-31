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

macosx=false
if $(which uname &> /dev/null); then
  if test $(uname) = "Darwin"; then
    macosx=true
  fi
fi

### Source functions ###
[[ -f /etc/profile.d/bash-completion.sh ]] && \
  source /etc/profile.d/bash-completion.sh
source ~/.config/dotfiles/.bash_completion.d/cmake-completion
source ~/.config/dotfiles/.bash_completion.d/git-prompt

[ -f /usr/share/cdargs/cdargs-bash.sh ] && \
  source /usr/share/cdargs/cdargs-bash.sh

#complete -W "$(teamocil --list)" teamocil

### Variables ###
export CCACHE_COMPRESS=1
export EDITOR=/usr/bin/vim
export ExternalData_OBJECT_STORES=${HOME}/data
export GREP_COLOR="01;32"  # color grep matches green
export HISTTIMEFORMAT="%Y%m%d %H:%M: "
export HISTCONTROL=ignoreboth
export HISTSIZE=2000
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export LESS="$LESS -iJr"
PATH="${HOME}/.config/dotfiles/bin:${PATH}"
PATH="${HOME}/.npm-global/bin:${PATH}"
PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/bin/exe:${PATH}"
export LP_RUNTIME_THRESHOLD=3
[[ -e ~/.config/dotfiles/liquidprompt/liquidprompt ]] && source ~/.config/dotfiles/liquidprompt/liquidprompt
GPG_TTY=$(tty)
export GPG_TTY
[[ -e /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]] && source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
[[ -e /usr/bin/virtualenvwrapper_lazy.sh ]] && source /usr/bin/virtualenvwrapper_lazy.sh
export WORKON_HOME=${HOME}/bin/venvs/
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--system-site-packages'

### Aliases ###
alias cmake='cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias ccmake='ccmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias grep='grep --color'
alias gca='git commit -a'
alias gsa='git status -sb'
if type nproc > /dev/null; then
  cores=$(nproc)
elif test -d /sys/bus/cpu/devices; then
  cores=$(ls /sys/bus/cpu/devices | wc -w)
elif $macosx; then
  cores=$(sysctl -n hw.ncpu)
else
  # Windows
  cores=$(wmic cpu get NumberOfCores | tail -n 2 | head -n 1)
fi
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
#alias tmux='tmux -2 a -d || tmux -2'

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

function x() {
  echo $1 | xclip ;
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/matt/bin/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/matt/bin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/matt/bin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/matt/bin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

