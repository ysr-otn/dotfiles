;;; howm のドキュメントを置くディレクトリ
(setq howm-directory "~/Documents/memo")
;;; howm のメニューの言語設定
(setq howm-menu-lang 'ja)
;;; howm のメニューファイル
(setq howm-menu-file "~/.howm-menu")

(require 'howm)
;(howm-setup-changelog)


;;;; org-mode との連携の設定
;;; howm の新規ファイル作成時のファイル名のフォーマット(org ファイルを作成)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.org")

;;; howm ファイル作成時のテンプレートに用いる日付のフォーマット ([YYYY-MM-DD] を使用)
(setq howm-template-date-format (concat "[" howm-date-format "]"))

;;; howm モードのテンプレート
(setq howm-template
  '(
	;;; 覚え書き
	"#+STARTUP: showall
#+TITLE: %date- %cursor
#+OPTIONS: ^:{}
"
	
	;;; TODO
	"#+STARTUP: showall
#+TITLE: %date+ %cursor
#+OPTIONS: ^:{}
"
	;;; 予定
	"#+STARTUP: showall
#+TITLE: %date@ %cursor
#+OPTIONS: ^:{}
"
	
	;;; 締め切り
	"#+STARTUP: showall
#+TITLE: %date! %cursor
#+OPTIONS: ^:{}
"
	))
