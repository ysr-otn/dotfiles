####### Options #######
bindkey -e					# キーバインドに設定: Emacs 風
setopt autolist				
setopt correct				# 入力ミス修正
setopt ignoreeof
setopt nobeep				# ビープ音無し
setopt auto_pushd			# 過去に移動したヂィレクトリをスタックに自動で入れ cd -[TAB] で表示
bindkey "^]" vi-cmd-mode		# 一時的に vi モードにするハック
disable r				# R のためにビルドインコマンドの r を無効化


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
elif [ $HOSTNAME = PC-PA1710C2120R -a `uname -s` = Linux ]; then
	export HOSTTYPE=ubuntu
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
export MANPATH=$HOME/Tools/$HOSTTYPE/man:$MANPATH

export GITHUB_DOTFILE_DIR=$HOME/Development/github/ysr-otn/dotfiles

# llvm 関係のパス設定
if [ $HOSTTYPE = i386 ]; then
	export PATH=/usr/local/opt/llvm/bin:$PATH
	export DYLD_LIBRARY_PATH=/usr/local/opt/llvm/lib:$DYLD_LIBRARY_PATH 
	export LDFLAGS="-L/usr/local/opt/llvm/lib"
	export CPPFLAGS="-I/usr/local/opt/llvm/include"	
elif [ $HOSTTYPE = windows ]; then
	export PATH=/cygdrive/c/msys64/mingw64/bin:$PATH
	export DYLD_LIBRARY_PATH=/cygdrive/c/msys64/mingw64/lib:$DYLD_LIBRARY_PATH 
	export LDFLAGS="-L/cygdrive/c/msys64/mingw64/lib"
	export CPPFLAGS="-I/cygdrive/c/msys64/mingw64/include"	
fi

####### Emacs Environment ########
export EMACS_DIR=$HOME/.inits/share/emacs
export EMACS_STARTUP=$EMACS_DIR/startup
export EMACS_SITE_LISP=$HOME/Tools/$HOSTTYPE/share/emacs/site-lisp
export EMACS_INFO=$HOME/Tools/$HOSTTYPE/share/info
export EMACS_INFO2=$HOME/Tools/$HOSTTYPE/info

#######	C/C++ の設定  #######
if [ $HOSTTYPE = i386 ]; then
	# Catalina 以降の Mac での stdio.h のインクルードエラー対策
	export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
fi

#######	Python の設定  #######
if [ $HOSTTYPE = i386 -o $HOSTTYPE = ubuntu ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
elif [ $HOSTTYPE = windows ]; then
	export PATH="$HOME/AppData/Local/Programs/Python/Python39:$HOME/AppData/Local/Programs/Python/Python39/Scripts:$PATH"
fi


#######	Ruby の設定  #######
if [ $HOSTTYPE = windows ]; then
	export PATH="$HOME/.gem/ruby/2.6.0/gems/taskjuggler-3.7.1/bin:$PATH"
fi

#######	Go の設定 #######
export PATH=$HOME/go/bin:$PATH

#######	Haskell の設定 #######
export PATH=$HOME/.cabal/bin:$PATH

#######	Node.js の設定 #######
if [ $HOSTTYPE = i386 ]; then
	export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

#######	CMake の設定 #######
if [ $HOSTTYPE = windows ]; then
	export CMAKE_GENERATOR="Unix Makefiles"
	export CMAKE_MAKE_PROGRAM=/usr/bin/make.exe
fi

####### cd の絶対パス履歴保存 cdr ####### 
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi


if [ $HOSTTYPE != windows ]; then

	#######	helm ライクな絞り込み検索 peco の設定  #######
	function peco-history-selection() {
		# 改行を含む履歴の展開に対応
		# https://gist.github.com/ay65535/1b4f73ffd029f51a9959
		local buffer
		local sep='⏎'
		buffer=$(
			# awk で重複した履歴を削除
			history -nr $'\n'=$sep 1 | awk '!a[$0]++' | \
				peco | \
				sed s/$sep/\\$'\n'/g)
		if [[ ! -z buffer ]]; then
			BUFFER=$buffer
		fi
		CURSOR=$#BUFFER
		zle redisplay
	}
	zle -N peco-history-selection
	bindkey '^r' peco-history-selection			# C-r で peco によるコマンドの絞り込み検索
	
	function peco-history-selection-migemo() {
		# 改行を含む履歴の展開に対応
		# https://gist.github.com/ay65535/1b4f73ffd029f51a9959
		local buffer
		local sep='⏎'
		buffer=$(
			# awk で重複した履歴を削除
			history -nr $'\n'=$sep 1 | awk '!a[$0]++' | \
				peco --initial-filter Migemo | \
				sed s/$sep/\\$'\n'/g)
		if [[ ! -z buffer ]]; then
			BUFFER=$buffer
		fi
	    CURSOR=$#BUFFER
		zle redisplay
	}
	
	zle -N peco-history-selection-migemo
	bindkey '^[r' peco-history-selection-migemo	# M-r で migemo 有りの peco によるコマンドの絞り込み検索
	
	# peco を用いた cdr
	# https://qiita.com/tmsanrinsha/items/72cebab6cd448704e366
	function peco-cdr () {
	    # cdr を用いて $NUMBER	$DIRECTORY のフォーマットでディレクトリの履歴を表示
		# ($NUMBER 部分があると helm 的に $NUMBER を指定しても絞り込み検索が可能)
		local selected_dir="$(cdr -l | peco --prompt="cdr >" --query "$LBUFFER")"
	    if [ -n "$selected_dir" ]; then
	        # cd に渡す時は $NUMBER の部分とその後の空白を削除
			BUFFER="cd `echo ${selected_dir} | sed 's/[0-9]*[ \t]*//'`"
	        zle accept-line
	    fi
	}
	zle -N peco-cdr
	bindkey '^x' peco-cdr	# C-x で peco-cdr
	
	function peco-cdr-migemo () {
	    # cdr を用いて $NUMBER	$DIRECTORY のフォーマットでディレクトリの履歴を表示
		# ($NUMBER 部分があると helm 的に $NUMBER を指定しても絞り込み検索が可能)
		local selected_dir="$(cdr -l | peco --initial-filter Migemo --prompt="cdr >" --query "$LBUFFER")"
	    if [ -n "$selected_dir" ]; then
	        # cd に渡す時は $NUMBER の部分とその後の空白を削除
			BUFFER="cd `echo ${selected_dir} | sed 's/[0-9]*[ \t]*//'`"
	        zle accept-line
	    fi
	}
	zle -N peco-cdr-migemo
	bindkey '^[x' peco-cdr-migemo	# M-x で peco-cdr-migemo
fi


# コマンドラインから天気を取得するスクリプト wttrin(https://linuxfan.info/wttr-in)
wttrin() {
  location=${1:-大阪}
  curl ja.wttr.in/$location
}

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

if [ $HOSTTYPE = i386 ]; then
# jnethack の文字コードを cocot を使って UTF-8 に変換する
alias jnethack='cocot -t UTF-8 -p eucjp -- jnethack'
fi

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
source $GITHUB_DOTFILE_DIR/.zshrc-private
