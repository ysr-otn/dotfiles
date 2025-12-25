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
if [ $LANG = ja_JP.UTF-8 ]
    alias lv='lv -c -Ou8'
else
	alias lv='lv -c'	
end


# その他
alias quit='exit'

if [ $HOSTTYPE = i386 ]
   # ドットファイルの表示/非表示
   alias Showdotfiles='defaults write com.apple.finder AppleShowAllFiles -boolean TRUE && killall Finder'
   alias Hidedotfiles='defaults write com.apple.finder AppleShowAllFiles -boolean FALSE && killall Finder'
   
   # 画像ビューア qlmanage の ql(と古の X11 画像ヒューア xv)のエイリアスを作成
   alias ql='qlmanage -p $argv &> /dev/null'
   alias xv='qlmanage -p $argv &> /dev/null'
   
   # jnethack の文字コードを cocot を使って UTF-8 に変換する(2025 年時点で不要になったので無効化)
   # alias jnethack='cocot -t UTF-8 -p eucjp -- jnethack'
end




# for fzf
if type -q fzf
	# 旧いキーバインドを無効化
	set -U FZF_LEGACY_KEYBINDINGS 0
	
	# C-o: 配下のファイルを絞り込みエディタで表示する
	set FZF_ENABLE_OPEN_PREVIEW
	bind \co __fzf_open
	
	# C-r 履歴からコマンドを絞り込み実行する
	bind \cr __fzf_reverse_isearch
	
	# M-c: 配下のディレクトを絞り込み移動する
	bind \ec __fzf_cd

	# C-x C-x: z
	bind \cx\cx __fzf_z
	
	# fzf を使ったコマンド実行のためのシェルスクリプトのエイリアス
	alias fzcmd=fzcmd.sh
	alias fzbat=fzbat.sh
	alias fzopn=fzopn.sh
# for peco
else
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
	  # C-x C-x
	  bind \cx\cx peco_z
	end
end


# コマンドラインから天気を取得するスクリプト wttrin(https://linuxfan.info/wttr-in)
function wttrin -a location
  set -q location[1] || set location 大阪
  curl ja.wttr.in/$location
end
