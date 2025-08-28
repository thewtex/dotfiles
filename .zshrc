#!/bin/zsh

macosx=false
if $(which uname &> /dev/null); then
  if test $(uname) = "Darwin"; then
    macosx=true
    if [ "$(arch)" = "arm64" ]; then
        eval $(/opt/homebrew/bin/brew shellenv);
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    else
        eval $(/usr/local/bin/brew shellenv);
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    fi
  fi
fi

GPG_TTY=$(tty)
export GPG_TTY
# keychain
if type keychain > /dev/null; then
  #keychain --agents "gpg,ssh" --timeout 1440 ~/.ssh/id_rsa 2E6EE54E654A512B
  keychain --agents "ssh" --timeout 1440 ~/.ssh/id_rsa
  [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
  [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
    . $HOME/.keychain/$HOSTNAME-sh
  #[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
    #. $HOME/.keychain/$HOSTNAME-sh-gpg
fi

export NVM_LAZY_LOAD=true
if test -e ~/.zsh-nvm/zsh-nvm.plugin.zsh; then
  source ~/.zsh-nvm/zsh-nvm.plugin.zsh
fi

# tab completion
autoload -U compinit
compinit
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path /tmp/.zsh_cache
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o comm,%cpu,tty,cputime,pid'
zstyle ':completion:*:cd:*' ignore-parents parent pwd
export LS_COLORS=${LS_COLORS:=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.pdf=00;32:*.ps=00;32:*.txt=00;32:*.patch=00;32:*.diff=00;32:*.log=00;32:*.tex=00;32:*.doc=00;32:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:}
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# does not play well with AI agents
unsetopt correct_all

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# prompt
autoload -U promptinit
promptinit
prompt adam2
export LP_RUNTIME_THRESHOLD=3
#[[ $- = *i* ]] && [[ -e ~/.config/dotfiles/liquidprompt/liquidprompt ]] && source ~/.config/dotfiles/liquidprompt/liquidprompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(battery dir dir_writable vcs virtualenv vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator history time)
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=8
#POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes) # git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-remotebranch) # git-tagname)
[[ $- = *i* ]] && [[ -e ~/.config/dotfiles/powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/.config/dotfiles/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# Activate syntax highlighting from
# https://github.com/zsh-users/zsh-syntax-highlighting/
#
# Set colors according to a 256 color scheme if supported.
# (We assume always a black background since anything else causes headache.)
# This is tested with xterm and the following xresources:
#
# XTerm*cursorColor: green
# XTerm*background:  black
# XTerm*foreground:  white
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
if [[ $#ZSH_HIGHLIGHT_MATCHING_BRACKETS_STYLES -eq 0 ]] &&
        . "$(for i in ${DEFAULTS:+${^DEFAULTS%/}/zsh{/zsh-syntax-highlighting,}} \
                ${HOME}/.config/dotfiles/zsh-syntax-highlighting \
                /usr/share/zsh/site-contrib{/zsh-syntax-highlighting,} \
                $path
        do      j=$i/zsh-syntax-highlighting.zsh && [[ -f $j ]] && echo -nE $j && exit
        done)" NIL
then    typeset -gUa ZSH_HIGHLIGHT_HIGHLIGHTERS
        ZSH_HIGHLIGHT_HIGHLIGHTERS+=(
                main            # color syntax while typing (active by default)
#                patterns        # color according to ZSH_HIGHLIGHT_PATTERNS
                brackets        # color matching () {} [] pairs
#                cursor          # color cursor; useless with cursorColor
                root            # color if you are root; broken in some versions
        )
        typeset -gUa ZSH_ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS
        ZSH_HIGHLIGHT_TOKENS_PRECOMMANDS+=(sudo fakeroot fakeroot-ng)
        typeset -ga ZSH_HIGHLIGHT_MATCHING_BRACKETS_STYLES
        typeset -gA ZSH_HIGHLIGHT_STYLES
        if [[ $(echotc Co) -ge 256 ]]
        then    ZSH_HIGHLIGHT_MATCHING_BRACKETS_STYLES=(
                        fg=98,bold
                        fg=135,bold
                        fg=141,bold
                        fg=147,bold
                        fg=153,bold
                )
                ZSH_HIGHLIGHT_STYLES+=(
                        'default'                       fg=252
                        'unknown-token'                 fg=64,bold
                        'reserved-word'                 fg=84,bold
                        'alias'                         fg=118,bold
                        'builtin'                       fg=47,bold
                        'function'                      fg=76,bold
                        'command'                       fg=40,bold
                        'precommand'                    fg=40,bold
                        'hashed-command'                fg=40,bold
                        'path'                          fg=214,bold
                        'path_prefix'                   fg=214,bold
                        'path_approx'                   none
                        'globbing'                      fg=190,bold
                        'history-expansion'             fg=166,bold
                        'single-hyphen-option'          fg=33,bold
                        'double-hyphen-option'          fg=45,bold
                        'back-quoted-argument'          fg=202
                        'single-quoted-argument'        fg=181,bold
                        'double-quoted-argument'        fg=181,bold
                        'dollar-double-quoted-argument' fg=196
                        'back-double-quoted-argument'   fg=202
                        'assign'                        fg=159,bold
                        'bracket-error'                 fg=196,bold
                )
                if [[ ${SOLARIZED:-n} != [nNfF0]* ]]
                then    ZSH_HIGHLIGHT_STYLES+=(
                        'default'                       none
                        'unknown-token'                 fg=red,bold
                        'reserved-word'                 fg=white
                        'alias'                         fg=cyan,bold
                        'builtin'                       fg=yellow,bold
                        'function'                      fg=blue,bold
                        'command'                       fg=green
                        'precommand'                    fg=green
                        'hashed-command'                fg=green
                        'path'                          fg=yellow
                        'path_prefix'                   fg=yellow
                        'path_approx'                   none
                        'globbing'                      fg=magenta
                        'single-hyphen-option'          fg=green,bold
                        'double-hyphen-option'          fg=magenta,bold
                        'assign'                        fg=cyan
                        'bracket-error'                 fg=red
                )
                fi
        else    ZSH_HIGHLIGHT_MATCHING_BRACKETS_STYLES=(
                        fg=cyan
                        fg=magenta
                        fg=blue,bold
                        fg=red
                        fg=green
                )
                ZSH_HIGHLIGHT_STYLES+=(
                        'default'                       none
                        'unknown-token'                 fg=red,bold
                        'reserved-word'                 fg=green,bold
                        'alias'                         fg=green,bold
                        'builtin'                       fg=green,bold
                        'function'                      fg=green,bold
                        'command'                       fg=yellow,bold
                        'precommand'                    fg=yellow,bold
                        'hashed-command'                fg=yellow,bold
                        'path'                          fg=white,bold
                        'path_prefix'                   fg=white,bold
                        'path_approx'                   none
                        'globbing'                      fg=magenta,bold
                        'history-expansion'             fg=yellow,bold,bg=red
                        'single-hyphen-option'          fg=cyan,bold
                        'double-hyphen-option'          fg=cyan,bold
                        'back-quoted-argument'          fg=yellow,bg=blue
                        'single-quoted-argument'        fg=yellow
                        'double-quoted-argument'        fg=yellow
                        'dollar-double-quoted-argument' fg=yellow,bg=blue
                        'back-double-quoted-argument'   fg=yellow,bg=blue
                        'assign'                        fg=yellow,bold,bg=blue
                        'bracket-error'                 fg=red,bold
                )
        fi
        () {
                local i
                for i in {1..5}
                do      ZSH_HIGHLIGHT_STYLES[bracket-level-$i]=${ZSH_HIGHLIGHT_MATCHING_BRACKETS_STYLES[$i]}
                done
        }
fi


# vi key bindings
bindkey -v

# do not require 'rehash' to be run to find new executables
setopt nohashdirs

# misc environmental variables
export CCACHE_COMPRESS=1
export EDITOR=/usr/bin/vim
export ExternalData_OBJECT_STORES=${HOME}/data
export GREP_COLORS='ms=01;33:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export LESS="$LESS -iJr"
export GEM_HOME="${HOME}/bin/gems"
export PATH="${PATH}:${GEM_HOME}/bin"
PATH="${HOME}/.config/dotfiles/bin:${PATH}"
PATH="${HOME}/.npm-global/bin:${PATH}"
PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/bin/exe:${PATH}"
if $macosx || [ -n "$NIX_PROFILES" ]; then
  export TERM=screen-256color
fi
[[ -e /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]] && source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
[[ -e /usr/bin/virtualenvwrapper_lazy.sh ]] && source /usr/bin/virtualenvwrapper_lazy.sh
export WORKON_HOME=${HOME}/bin/venvs/
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--system-site-packages'
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# misc aliases
alias cmake='cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias ccmake='ccmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias icmake='CC=ccache-clang CXX=ccache-clang++ cmake -G Ninja -DITK_USE_CCACHE=1 -DITK_USE_SYSTEM_LIBRARIES:BOOL=ON -DITK_USE_SYSTEM_HDF5:BOOL=OFF -DITK_USE_SYSTEM_GOOGLETEST=OFF -DCMAKE_BUILD_TYPE=MinSizeRel -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias grep='grep --color'
alias gca='git commit -a'
alias gsa='git status -sb'
alias pn=pnpm
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
alias prettyjson='python -m json.tool'
alias pyclewn='pyclewn --gdb=async,/tmp/pyclewn_project'
alias wp='wgetpaste --nick thewtex -X'
alias iv='ImageViewer'
#alias tmux='tmux -2 a -d || tmux -2'
if type lsd > /dev/null; then
  alias ls=lsd
else
  if ! $macosx; then
    alias ls='ls --color=auto --human-readable --group-directories-first --classify'
  fi
fi
if type nvim > /dev/null; then
  alias vim=nvim
fi
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias -s cxx=vim
alias -s h=vim
alias -s hxx=vim
alias -s pdf=evince

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

function x() {
  echo $1 | xclip ;
}

function battery() {
  upower -i $(upower -e | grep 'BAT') | grep -E "state|to\ full|percentage";
}

function ris2bib() {
  # utilities from the bibutils package
  ris2xml $1 | xml2bib -b > $(basename $1 .ris).bib
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/matt/bin/micromamba/micromamba';
export MAMBA_ROOT_PREFIX='/home/matt/bin/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
# Wasmer
export WASMER_DIR="/home/matt/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/matt/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/Users/matt/.pixi/bin:$PATH"
alias p=pixi
