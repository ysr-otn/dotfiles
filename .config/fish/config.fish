if status is-interactive
    # Commands to run in interactive sessions can go here
end

####### Terminal #######
set -x TERM "xterm-256color"	# 256 色表示のターミナルに対応


####### Set Host #######
set -x HOSTNAME (hostname)


if [ $HOSTNAME = imglinux110 ]
	set -x HOSTTYPE linux
else if [ "$OS" ]
	set -x HOSTTYPE windows
else if [ $HOSTNAME = PC-PA1710C2120R -a (uname -s) = Linux ]
	set -x HOSTTYPE ubuntu
else
	set -x HOSTTYPE i386		# mac
end


####### Set lang #######
if [ $HOSTTYPE = linux ]
	set -x LANG ja_JP.eucJP
else
	set -x LANG ja_JP.UTF-8
end
	
###### Set Editor ######
if [ $HOSTTYPE != linux ]			# Linux 環境では vim の日本語設定が正しく動作しないのでエディタに vim は設定しない
	set EDITOR vim
end

########## PATH ##########
set -x PATH $HOME/Tools/$HOSTTYPE/bin:$HOME/Tools/share/bin:$PATH
if [ $HOSTTYPE = linux ]
	set -x PATH $HOME/pkg/bin:$HOME/pkg/sbin:$PATH
end
set -x MANPATH $HOME/Tools/$HOSTTYPE/man:$MANPATH

set -x GITHUB_DOTFILE_DIR $HOME/Development/github/ysr-otn/dotfiles

# llvm 関係のパス設定
if [ $HOSTTYPE = i386 ]
	set PATH /usr/local/opt/llvm/bin:$PATH
	set DYLD_LIBRARY_PATH /usr/local/opt/llvm/lib:$DYLD_LIBRARY_PATH 
	set LDFLAGS "-L/usr/local/opt/llvm/lib"
	set CPPFLAGS "-I/usr/local/opt/llvm/include"	
else if [ $HOSTTYPE = windows ]
	set PATH /cygdrive/c/msys64/mingw64/bin:$PATH
	set DYLD_LIBRARY_PATH /cygdrive/c/msys64/mingw64/lib:$DYLD_LIBRARY_PATH 
	set LDFLAGS "-L/cygdrive/c/msys64/mingw64/lib"
	set CPPFLAGS "-I/cygdrive/c/msys64/mingw64/include"	
end

####### Emacs Environment ########
set EMACS_DIR $HOME/.inits/share/emacs
set EMACS_STARTUP $EMACS_DIR/startup
set EMACS_SITE_LISP $HOME/Tools/$HOSTTYPE/share/emacs/site-lisp
set EMACS_INFO $HOME/Tools/$HOSTTYPE/share/info
set EMACS_INFO2 $HOME/Tools/$HOSTTYPE/info

#######	C/C++ の設定  #######
if [ $HOSTTYPE = i386 ]
	# Catalina 以降の Mac での stdio.h のインクルードエラー対策
	set SDKROOT (xcrun --sdk macosx --show-sdk-path)
end

#######	Python の設定  #######
if [ $HOSTTYPE = i386 -o $HOSTTYPE = ubuntu ]
	set PYENV_ROOT "$HOME/.pyenv"
	set PATH "$PYENV_ROOT/bin:$PATH"
	pyenv init - | source
else if [ $HOSTTYPE = windows ]
	set PATH "$HOME/AppData/Local/Programs/Python/Python39:$HOME/AppData/Local/Programs/Python/Python39/Scripts:$PATH"
end



#######	Aliasis  #######
# 通常コマンドのデフォルトオプションの追加
alias la='ls -a'
alias lf='ls -FA'
alias ll='ls -lA'
alias ls='ls -F'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

# lv に色ずけを許可する
alias lv='lv -c'

# その他
alias quit='exit'

if [ $HOSTTYPE = i386 ]
   # ドットファイルの表示/非表示
   alias Showdotfiles='defaults write com.apple.finder AppleShowAllFiles -boolean TRUE && killall Finder'
   alias Hidedotfiles='defaults write com.apple.finder AppleShowAllFiles -boolean FALSE && killall Finder'
   
   # 画像ビューア qlmanage の ql(と古の X11 画像ヒューア xv)のエイリアスを作成
   alias ql='qlmanage -p $argv &> /dev/null'
   alias xv='qlmanage -p $argv &> /dev/null'
   
   # jnethack の文字コードを cocot を使って UTF-8 に変換する
   alias jnethack='cocot -t UTF-8 -p eucjp -- jnethack'
end


# for peco z
function peco_z
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  z -l | peco $peco_flags | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end


# key bindings
function fish_user_key_bindings
  # for peco
  # C-r
  bind \cr 'peco_select_history (commandline -b)'
  # C-x C-k
  bind \cx\ck peco_kill

  # for peco + z
  # C-x C-z
  bind \cx\cx peco_z
end
