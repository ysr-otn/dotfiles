;;; howm のドキュメントを置くディレクトリ
(setq howm-directory "~/Documents/memo/public")
;;; howm のメニューの言語設定
(setq howm-menu-lang 'ja)
;;; howm のメニューファイル
(setq howm-menu-file "~/.howm-menu")

(require 'howm)
;(howm-setup-changelog)


;;; SwitchMemoDirectory(独立した 2 つのメモ束を切り替える)
;;; https://howm.osdn.jp/cgi-bin/hiki/hiki.cgi?SwitchMemoDirectory
(defun my-howm-set-directory (dir &optional keyfile)
  `(lambda ()
     (interactive)
     ;; kill current keyword buffer first to avoid the error
     ;; "howm-get-buffer-for-file: Buffer name ` *howm-keys:*' is in use"
     (kill-buffer (howm-keyword-buffer))
     (setq howm-directory ,dir)
     (when ,keyfile
       (setq howm-keyword-file ,keyfile))
     (setq howm-menu-next-expiry-time (current-time))
     (message "%s" ,dir)))

;; 切り替えてメニューを呼ぶ
(defun my-howm-switch-directory (dir &optional keyfile)
  (funcall (my-howm-set-directory dir keyfile))
  (howm-menu))

;;; 切り替えをするメモ束の設定
(setq my-howm-directory-alist
	  '((public  ("~/Documents/memo/public"  "~/.howm-keys-public"))
		(private ("~/Documents/memo/private" "~/.howm-keys-private"))))

;;; メモ束 1 への切り替え
(global-set-key "\C-x,1" (my-howm-set-directory
						  (first (cadr (assoc 'public my-howm-directory-alist)))
						  (second (cadr (assoc 'public my-howm-directory-alist)))))

;;; メモ束 2 への切り替え
(global-set-key "\C-x,2" (my-howm-set-directory
						  (first (cadr (assoc 'private my-howm-directory-alist)))
						  (second (cadr (assoc 'private my-howm-directory-alist)))))

;;; メニューからメモ束切り替えコマンドを実行するための Wrapper
(defun my-howm-switch-dir (key)
  (my-howm-switch-directory
   (first (cadr (assoc key my-howm-directory-alist)))
   (second (cadr (assoc key my-howm-directory-alist)))))


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
			 
;;; howm-mode のプレフィクスキー C-c が org-mode のプレフィクスキーと被るので howm-mode の
;;; プレフィクスキーを C-x に変更
(global-unset-key (kbd "C-x ,"))
(setq howm-prefix (kbd "C-x ,"))
(eval-after-load "howm-mode"
  '(progn
    (define-key howm-mode-map (kbd "C-c C-c") nil)))
(global-set-key "\C-x,," 'howm-menu)
(global-set-key "\C-x,c" 'howm-create)
(global-set-key "\C-x,t" 'howm-insert-dtime)
(global-set-key "\C-x,d" 'howm-insert-date)


;;;; ripgrep との連携の設定
;;; https://extra-vision.blogspot.com/2016/10/ripgrep-howm.html
(setq howm-view-use-grep t)
(setq howm-view-grep-command "rg")
(setq howm-view-grep-option "-nH --no-heading --color never")
(setq howm-view-grep-extended-option nil)
(setq howm-view-grep-fixed-option "-F")
(setq howm-view-grep-expr-option nil)
(setq howm-view-grep-file-stdin-option nil)

;;;; howm-menu で -j1 オプションを使う
;;; https://extra-vision.blogspot.com/2016/12/howm-ripgrep.html
(defun howm-menu-with-j1 (orig-fun &rest args)
  (setq howm-view-grep-option "-nH --no-heading -j1 --color never")
  (apply orig-fun args)
  (setq howm-view-grep-option "-nH --no-heading --color never"))

(advice-add 'howm-menu-refresh :around #'howm-menu-with-j1)
