#!/bin/zsh

# keychain
if test -e /usr/bin/keychain; then
  /usr/bin/keychain ~/.ssh/id_rsa
  HOSTNAME=$(hostname)
  . ~/.keychain/${HOSTNAME}-sh
  . ~/.keychain/${HOSTNAME}-sh-gpg
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

# command correction
setopt correctall

# prompt
autoload -U promptinit
promptinit
prompt adam2
. ${HOME}/.git_prompt.zsh
PURE_CMD_MAX_EXEC_TIME=2
# Adapted from
# Pure
# by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License
# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
prompt_pure_human_time() {
	local tmp=$1
	local days=$(( tmp / 60 / 60 / 24 ))
	local hours=$(( tmp / 60 / 60 % 24 ))
	local minutes=$(( tmp / 60 % 60 ))
	local seconds=$(( tmp % 60 ))
	(( $days > 0 )) && echo -n "${days}d "
	(( $hours > 0 )) && echo -n "${hours}h "
	(( $minutes > 0 )) && echo -n "${minutes}m "
	echo "${seconds}s"
}

# displays the exec time of the last command if set threshold was exceeded
prompt_pure_cmd_exec_time() {
	local stop=$EPOCHSECONDS
	local start=${cmd_timestamp:-$stop}
	integer elapsed=$stop-$start
	(($elapsed > ${PURE_CMD_MAX_EXEC_TIME:=5})) && prompt_pure_human_time $elapsed
}

prompt_pure_preexec() {
	cmd_timestamp=$EPOCHSECONDS

	# shows the current dir and executed command in the title when a process is active
	print -Pn "\e]0;"
	echo -nE "$PWD:t: $2"
	print -Pn "\a"
}

prompt_pure_precmd() {
	# shows the full path in the title
        print -Pn '\e]0;%~\a'

	local prompt_pure_preprompt=" %F{yellow}`prompt_pure_cmd_exec_time`%f"
	print -P $prompt_pure_preprompt

	# reset value since `preexec` isn't always triggered
	unset cmd_timestamp
}

show_exit_status() {
        print -P "%(?.%F{green}.%F{red}●)%f "
}

prompt_pure_setup() {
	# prevent percentage showing up
	# if output doesn't end with a newline
	export PROMPT_EOL_MARK=''

	prompt_opts=(cr subst percent)

	zmodload zsh/datetime
	autoload -Uz add-zsh-hook

	add-zsh-hook precmd show_exit_status
	add-zsh-hook precmd prompt_pure_precmd
	add-zsh-hook preexec prompt_pure_preexec
}
prompt_pure_setup "$@"

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
export GREP_COLOR="01;32"  # color grep matches green
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export LESS="$LESS -iJr"
PATH="${HOME}/.config/dotfiles/bin:${PATH}"
export PATH="${HOME}/bin/exe:${PATH}"

# misc aliases
alias cmake='cmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias ccmake='ccmake -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=ON '
alias grep='grep --color'
alias gca='git commit -a'
alias gsa='git status -sb'
if test -d /sys/bus/cpu/devices; then
  cores=$(ls /sys/bus/cpu/devices | wc -w)
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
alias tmux='tmux -2 a -d || tmux -2'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
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

ranger() {
  command ranger --fail-unless-cd $@ &&
  cd "$(grep \^\' ~/.ranger/bookmarks | cut -b3-)"
}

function x() {
  echo $1 | xclip ;
}
