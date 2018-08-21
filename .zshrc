####### Options #######
bindkey -e					# キーバインドに設定: Emacs 風
setopt autolist				
setopt correct				# 入力ミス修正
setopt ignoreeof
setopt nobeep				# ビープ音無し
setopt auto_pushd			# 過去に移動したヂィレクトリをスタックに自動で入れ cd -[TAB] で表示
bindkey "^]" vi-cmd-mode		# 一時的に vi モードにするハック
	

####### Terminal #######
export TERM="xterm-256color"	# 256 色表示のターミナルに対応


####### Complement #######
autoload -U compinit
compinit

####### History #######
fignore=( .o \~ .bak .junk )
HISTFILE=~/.zsh_history	
### どうも SAVEHIST が 20000 を越えた当たりから極端に
### zsh の挙動が遅くなるので 10000 ぐらいで辞めておく
#HISTSIZE=126976
#SAVEHIST=126976
HISTSIZE=20000
SAVEHIST=10000
setopt extended_history
function history-all { history -E 1 }	
setopt share_history		# share command history data
# setopt hist_ignore_dups     # ignore duplication command history list

PROMPT='%m%S[%~]%s(%h)
%# '
WORDCHARS='*?[]~'

####### Set Host #######
export HOSTNAME=`hostname`

if [ $HOSTNAME = imglinux110 ]; then
	export HOSTTYPE=linux
elif [ "$OS" ]; then
	export HOSTTYPE=windows
else
	export HOSTTYPE=i386		# mac
fi


####### Set lang #######
if [ $HOSTTYPE = linux ]; then
	export LANG=ja_JP.eucJP
else
	export LANG=ja_JP.UTF-8
fi
	
###### Set Editor ######
if [ $HOSTTYPE != linux ]; then			# Linux 環境では vim の日本語設定が正しく動作しないのでエディタに vim は設定しない
	export EDITOR=vim
fi



########## PATH ##########
export PATH=$HOME/Tools/$HOSTTYPE/bin:$HOME/Tools/share/bin:$PATH
if [ $HOSTTYPE = linux ]; then
	export PATH=${HOME}/pkg/bin:${HOME}/pkg/sbin:${PATH}
fi
export MANPATH=$MANPATH

export GITHUG_DOTFILE_DIR=$HOME/Development/github/ysr-otn/dotfiles

# llvm 関係のパス設定
if [ $HOSTTYPE = i386 ]; then
	export PATH=/usr/local/Cellar/llvm/3.5.0/bin:$PATH
	export DYLD_LIBRARY_PATH=/usr/local/Cellar/llvm/3.5.0/lib:$DYLD_LIBRARY_PATH 
fi

####### Emacs Environment ########
export EMACS_DIR=$HOME/.inits/share/emacs
export EMACS_STARTUP=$EMACS_DIR/startup
export EMACS_SITE_LISP=$HOME/Tools/$HOSTTYPE/share/emacs/site-lisp
export EMACS_INFO=$HOME/Tools/$HOSTTYPE/share/info
export EMACS_INFO2=$HOME/Tools/$HOSTTYPE/info


#######	Python の設定  #######
if [ $HOSTTYPE = i386 ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
elif [ $HOSTTYPE = windows ]; then
	export PATH="/cygdrive/c/ProgramData/Anaconda3:$PATH"
fi


#######	Aliasis  #######
alias la='ls -a'
alias lf='ls -FA'
alias ll='ls -lA'
alias ls='ls -F'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias quit='exit'
alias reset='source ~/.zshrc'
alias l='echo \!* > /dev/null'
#alias less='jless'	
alias -g L='| less'	
alias screen='screen -h 65536'
alias Showdotfiles='defaults write com.apple.finder AppleShowAllFiles -boolean TRUE && killall Finder'
alias Hidedotfiles='defaults write com.apple.finder AppleShowAllFiles -boolean FALSE && killall Finder'
# 画像ビューア qlmanage の ql(と古の X11 画像ヒューア xv)のエイリアスを作成
alias ql='qlmanage -p "$@" >& /dev/null'
alias xv='qlmanage -p "$@" >& /dev/null'
# colordiff があれば diff の代りに colordiff を使用する
if type colordiff 2>/dev/null 1>/dev/null ; then
	alias diff='colordiff'
fi
# lv に色ずけを許可する
alias lv='lv -c'


# C-o により dabbrev 風の補完(http://d.hatena.ne.jp/secondlife/20060108/1136650653)
# HARDCOPYFILE=$HOME/tmp/screen-hardcopy
# touch $HARDCOPYFILE
# 
# dabbrev-complete () {
#     local reply lines=1024 # 1024行分
#     screen -X eval "hardcopy -h $HARDCOPYFILE"
#     reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
#     compadd - "${reply[@]%[*/=@|]}"
# }
# 
# zle -C dabbrev-complete menu-complete dabbrev-complete
# bindkey '^o' dabbrev-complete
# bindkey '^o^_' reverse-menu-complete


######### Private setting #########
source $GITHUG_DOTFILE_DIR/.zshrc-private
