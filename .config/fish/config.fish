if status is-interactive
    # Commands to run in interactive sessions can go here
end


####### PATH #######
if [ $HOSTTYPE = windows ]
	# 何故か fish を起動すると zsh の PATH に対して /bin が先頭になって
	# python 等で /bin 以外の PATH のコマンドを優先したい場合に問題となるので
	# 一度 /bin を削除してから PATH の末尾に /bin を追加
	# (/cygdrive/c/msys64/mingw64/bin が PATH の末尾になっているので /cygdrive/c/msys64/mingw64/bin も
	#  削除して /bin -> /cygdrive/c/msys64/mingw64/bin の優先順位になるように再設定)
	set PATH (string match -v /bin $PATH)
	set PATH (string match -v /cygdrive/c/msys64/mingw64/bin $PATH)
	set PATH $PATH /bin /cygdrive/c/msys64/mingw64/bin
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


# コマンドラインから天気を取得するスクリプト wttrin(https://linuxfan.info/wttr-in)
function wttrin -a location
  set -q location[1] || set location 大阪
  curl ja.wttr.in/$location
end
