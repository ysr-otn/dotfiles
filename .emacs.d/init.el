;;; debug 設定
(setq debug-on-error t)

;;; PATH 設定
(setq load-path
      (append
       (list
		(substitute-in-file-name "$HOME/.emacs.d/init")
		(substitute-in-file-name "$HOME/.emacs.d/elisp/misc")
		)
       load-path))

;;; info ファイルの設定
(add-to-list 'Info-default-directory-list "~/.emacs.d/info")

;;; 各設定ファイルのモード指定
(setq auto-mode-alist
      (append
       '(("init$"				. emacs-lisp-mode)	; emacs 設定ファイル
		 ("init-private$"		. emacs-lisp-mode)	; emacs 個人用設定ファイル
		 ("\.src$"				. asm-mode)			; アセンブラファイル
		 )
       auto-mode-alist))

;;;;;;;;;;;;;;;;;;  基本的な設定 ;;;;;;;;;;;;;;;;;;;;;;;;
;;; tab 幅
(setq-default tab-width 4)
;;;標準の fill-column を 60 に設定
(setq-default fill-column 60)
;;; 検索のとき大文字と小文字を区別しない
(setq case-fold-search nil)
;;; 文末を表わす正規表現
(setq sentence-end "[.?!][]\"')}]*\\($\\| $\\|	\\|  \\)[ 	\n]*\\|[。．？！]")
;;; 日本語の dabbrev-expand 
(setq dabbrev-abbrev-char-regexp "\\w\\|\\s_")    
;;;ライン番号を表示 
(line-number-mode t)
;;; 列番号を表示
(column-number-mode t)
;;; 縦分割されたウィンドウは 200 より狭いウインドウなら行末を折り返えさない
(setq truncate-partial-width-windows 200)
;;; yes/no の代りに y/n で応える．
(fset 'yes-or-no-p 'y-or-n-p)
;; 長い行の折り返し表示をする．
(setq-default truncate-lines nil)


;;;;;;;;;;;;;;;;;;;; キー設定 ;;;;;;;;;;;;;;;;;;;;;;;;
;;; 基本操作
(global-set-key "\C-x\C-c" nil) ; 誤って終了しないように
(global-set-key "\C-x\C-c\C-c" 'save-buffers-kill-emacs)
;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-H" 'backward-delete-char)
(global-set-key "\M-h" 'backward-kill-word)
(define-key esc-map "\C-h" 'backward-kill-word)
(global-set-key "\M-?" 'help-for-help)
(global-set-key "\M-g" 'goto-line)
;; C-z (Emacs をアイコン化)を無効化
(global-unset-key "\C-z")
;;; コンパイル関係
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-cp" 'previous-error)
(global-set-key "\C-cg" 'compile-goto-error)
(global-set-key "\C-cm" 'manual-entry)
;;; 略語展開関係
(global-set-key "\C-o" 'dabbrev-expand)
(global-set-key "\M-o" 'expand-abbrev)
;;; カーソルの下に空行を入れる (C-o の代り)
(define-key esc-map "\J" 'open-line)
;;; 画面の横スクロール
(global-set-key [M-left] 'scroll-right)
(global-set-key [M-right] 'scroll-left)
(global-set-key [(control >)] 'scroll-left)
(global-set-key [(control <)] 'scroll-right)
;;; fill 関連
(global-set-key "\C-xP" 'fill-paragraph)
(global-set-key "\C-xF" 'fill-region)
;;; M-q (fill-column) を変更
(global-set-key "\C-xS" 'set-fill-column)
(global-set-key "\C-xR" 'fill-region-as-paragraph)
;;; 次のウインドウに移動
(global-set-key "\C-q" 'other-window)
;;; C-q の代わり
(global-set-key "\C-xQ" 'quoted-insert)
;;; C-m を C-j と同じにする
(global-set-key "\C-m" 'newline-and-indent)
;;; shell-mode
(global-set-key "\C-c\C-s" 'shell)
;;; ispell
(global-set-key "\C-c\C-i" 'ispell-complete-word)
;;; isearch-mode で M-y を isearch-yank-pop に設定
(define-key isearch-mode-map "\M-y" 'isearch-yank-pop)
;;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
(set-face-background 'show-paren-match-face "#F0F")
;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; ミニバッファの履歴の保存数を増やす
(setq history-length 4096)


;;; view-mode
(add-hook
 'view-mode-hook
 '(lambda ()
    (define-key view-mode-map "k" 'View-scroll-line-backward)
    (define-key view-mode-map "j" 'View-scroll-line-forward)
    (define-key view-mode-map "\K" 'View-scroll-half-page-backward)
    (define-key view-mode-map "\J" 'View-scroll-half-page-forward)
    (define-key view-mode-map "p" 'View-scroll-half-page-backward)
    (define-key view-mode-map "n" 'View-scroll-half-page-forward)
    (define-key view-mode-map "b" 'View-scroll-page-backward)
    (define-key view-mode-map " " 'View-scroll-page-forward)
	(define-key view-mode-map "u" 'View-quit)
    (define-key view-mode-map "\E" 'view-mode-exit-with-skk)
	(define-key view-mode-map "\;" 'other-window)
	(define-key view-mode-map "q" 'View-quit)))
(define-key esc-map "V" 'view-mode)
(global-set-key "\C-t" 'transpose-chars)

;;; dired-mode
(add-hook
 'dired-mode-hook
 '(lambda ()
	(global-set-key "\C-x\C-j" 'skk-mode)
	(local-set-key "q" (defun quit-window-with-kill () (interactive)
						 (quit-window t nil)))
	(local-set-key "u" 'dired-up-directory)
	(local-set-key "U" 'dired-unmark)
	(local-set-key "j" 'dired-view-file)
	(local-set-key "r" 'wdired-change-to-wdired-mode)
	(define-key dired-mode-map "i" 'dired-view-file)))

;;; help-mode
(add-hook
 'help-mode-hook
 '(lambda ()
	(local-set-key "q"	'help-quit)))

;; dired-xを使う。
(setq dired-load-hook '(lambda () (load "dired-x")))

;; ! のdefaultの設定
(setq dired-guess-shell-alist-user
	  '(("\\.tar\\.gz$" "tar ztvf")
		("\\.\\(g\\|\\)z" "zcat")
		("\\.\\(html\\|HTML\\|htm\\|HTM\\)" "w3m")
		("\\.ps\\.gz$" "gunzip -c | gv")
		("\\.dvi" "xdvi")
		("\\.pdf" "acroread")
		("\\.\\(gif\\|GIF\\|jpg\\|jpeg\\|JPG\\|JPEG\\|tif\\|xpm\\|xbm\\|bmp\\|BMP\\)$" "xv")))


;;; for Info-mode
(add-hook
 'Info-mode-hook
 (lambda ()
   (local-set-key [mouse-3] 'Info-up)
   (local-set-key "k" 'previous-line)
   (local-set-key "j" 'next-line)
   (local-set-key "h" 'backward-char)
   (local-set-key "l" 'forward-char)
   (local-set-key "L" 'Info-last)
   (local-set-key "?" 'Info-help)
   (local-set-key "i" 'Info-scroll-up)
   (local-set-key "I" 'Info-index)
   (local-set-key " " 'scroll-up)
   (local-set-key "b" 'scroll-down)
   (local-set-key "n" 'Info-next-reference)
   (local-set-key "p" 'Info-prev-reference)
   (local-set-key "q" 'Info-up)
   (local-set-key "Q" 'Info-exit)
   (local-set-key "N" 'Info-next)
   (local-set-key "P" 'Info-prev)
   ))


;;; buffer の選択
(global-set-key	"\C-x\C-b" 'buffer-menu)
(define-key Buffer-menu-mode-map " " 'Buffer-menu-this-window)
(define-key Buffer-menu-mode-map "k" 'previous-line)
(define-key Buffer-menu-mode-map "j" 'next-line)
(define-key Buffer-menu-mode-map "\C-n" 'next-line)
(define-key Buffer-menu-mode-map "\C-p" 'previous-line)

;;; register
(global-set-key "\M-j"	nil)
(global-set-key "\M-j " 'point-to-register)
(global-set-key "\M-jj" 'jump-to-register)
(global-set-key "\M-jn"	'number-to-register)
(global-set-key "\M-jm" 'bookmark-set)
(global-set-key "\M-jb" 'bookmark-jump)
(global-set-key "\M-jl" 'bookmark-bmenu-list)
(global-set-key "\M-ji" 'insert-register)
(global-set-key "\M-jr" 'copy-rectangle-to-register)
(global-set-key "\M-jt" 'string-rectangle)
(global-set-key "\M-jx" 'copy-to-register)
(global-set-key "\M-jc" 'clear-rectangle)
(global-set-key "\M-jk" 'kill-rectangle)
(global-set-key "\M-jd" 'delete-rectangle)
(global-set-key "\M-jy" 'yank-rectangle)
(global-set-key "\M-jo" 'open-rectangle)
(global-set-key "\M-jw" 'window-configuration-to-register)
(global-set-key "\M-jf" 'frame-configuration-to-register)


;;; 略語補完
;; 静的略語補完設定ファイル
(setq abbrev-file-name (substitute-in-file-name "$HOME/.emacs.d/abbrev_defs.el"))
;; ファイルを開く時に静的略語補完モードが自動で ON されるのを防ぐ
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))
;; 漢字・平仮名を含む単語を対象とする動的略称展開を使いやすくするため設定
;; http://www.sodan.org/~knagano/emacs/dabbrev-20.html
(or (boundp 'MULE)			; Mule2 と
    (featurep 'xemacs)			; XEmacs は設定不要
    (let (current-load-list)
      (defadvice dabbrev-expand
		(around modify-regexp-for-japanese activate compile)
		"Modify `dabbrev-abbrev-char-regexp' dynamically for Japanese words."
		(if (bobp)
			ad-do-it
		  (let ((dabbrev-abbrev-char-regexp
				 (let ((c (char-category-set (char-before))))
				   (cond
					((aref c ?a) "[-_A-Za-z0-9]") ; ASCII
					((aref c ?j)	; Japanese
					 (cond
					  ((aref c ?K) "\\cK") ; katakana
					  ((aref c ?A) "\\cA") ; 2byte alphanumeric
					  ((aref c ?H) "\\cH") ; hiragana
					  ((aref c ?C) "\\cC") ; kanji
					  (t "\\cj")))
					((aref c ?k) "\\ck") ; hankaku-kana
					((aref c ?r) "\\cr") ; Japanese roman ?
					(t dabbrev-abbrev-char-regexp)))))
			ad-do-it)))))

;;; バックアップファイルの指定
(setq backup-by-copying t) 
(fset 'make-backup-file-name
      '(lambda (file)
		 (concat (substitute-in-file-name "$HOME/.emacs.d/backup/")
				 (file-name-nondirectory file))))
(setq auto-save-list-file-prefix  (substitute-in-file-name "$HOME/.emacs.d/auto-save/auto-save"))

;;; buffer-name 表示
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;;; 現在の関数名をモードラインに表示
(which-function-mode t)

;;; 対応する括弧を光らせる
(show-paren-mode t)

;;; sticky key map
(defvar sticky-key ";")
(defvar sticky-list
  '(("a" . "A")("b" . "B")("c" . "C")("d" . "D")("e" . "E")("f" . "F")("g" . "G")
    ("h" . "H")("i" . "I")("j" . "J")("k" . "K")("l" . "L")("m" . "M")("n" . "N")
    ("o" . "O")("p" . "P")("q" . "Q")("r" . "R")("s" . "S")("t" . "T")("u" . "U")
    ("v" . "V")("w" . "W")("x" . "X")("y" . "Y")("z" . "Z")
    ("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")("6" . "^")("7" . "&")
    ("8" . "*")("9" . "(")("0" . ")")
    ("`" . "~")("[" . "{")("]" . "}")("-" . "_")("=" . "+")("," . "<")("." . ">")
    ("/" . "?")(";" . ":")("'" . "\"")("\\" . "|")
    ))

(defvar sticky-map (make-sparse-keymap))
(define-key global-map sticky-key sticky-map)
(mapcar (lambda (pair)
          (define-key sticky-map (car pair)
            `(lambda()(interactive)
               (setq unread-command-events
                     (cons ,(string-to-char (cdr pair)) unread-command-events)))))
        sticky-list)
(define-key sticky-map sticky-key '(lambda ()(interactive)(insert sticky-key)))

;; SKK 読み込み後に sticky-map を設定
;; (eval-after-load を使う場合だと何故か上手く行かなかったので add-hook を使うように変更
(add-hook 'skk-mode-hook
          (lambda ()
            (progn
              (define-key skk-j-mode-map sticky-key sticky-map)
              (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
              (define-key skk-abbrev-mode-map sticky-key sticky-map)
              )
            ))
;(eval-after-load "skk"
;  '(progn
;     (define-key skk-j-mode-map sticky-key sticky-map)
;     (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
;     (define-key skk-abbrev-mode-map sticky-key sticky-map)))

;; skk-isearch のときの sticky-map の設定だが，エラーが出るし特に問題無いので
;; コメントアウト(eval-after-load を使ってると上と同様に上手くいかないかもしれないが…)
;(eval-after-load "skk-isearch"
;				'(define-key skk-isearch-mode-map sticky-key sticky-map))


;;; 時計表示
;; 時計更新タイミング 1 秒
(setq display-time-interval 1)
;; 時計フォーマット変更
(setq display-time-string-forms
	  '((format " %s/%s/%s(%s)%s:%s:%s"
				year month day dayname
				24-hours minutes seconds
				)))
;; 時計表示 ON
(display-time)

;; スタートアップ非表示
(setq inhibit-startup-screen t)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;;; ediffを1ウィンドウで実行
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; emacsclient の為のサーバを起動
(require 'server)
(unless (server-running-p)
  (server-start))

;;; load init file for each version emacs
(load (concat (substitute-in-file-name "$HOME/.emacs.d/init-")
			  (number-to-string emacs-major-version)
			  ".el"))

;;; load init file for each systems
(cond ((eq system-type 'darwin)
	   (load "init-darwin.el"))
	  ((eq system-type 'windows-nt)
	   (load "init-windows-nt.el"))
	  )

;;; load init file for window systems
(cond ((eq window-system 'mac)
	   (load "init-window-system-mac.el"))
	  ((eq window-system 'ns)	;; Emacs frame on a GNUstep or Macintosh Cocoa display,
	   (load "init-window-system-ns.el"))
	  )


;;;;;;;;;;;;;;;;;;; package 設定 ;;;;;;;;;;;;;;;;;;;
;;; http://emacs-jp.github.io/packages/package-management/package-el.html
(require 'package)
;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Marmaladeを追加(見付からないので無効化)
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
;; www.e6h.orgを追加(見付からないので無効化)
;;(add-to-list 'package-archives	'("e6h" . "http://www.e6h.org/packages/") t)
;; 初期化
(package-initialize)

;;; 各種パッケージ情報の更新
(package-refresh-contents)

;;; インストールするパッケージのリスト
(defvar my/favorite-packages
    '(
	  ;; helm
	  helm ac-helm helm-ag helm-c-yasnippet helm-gtags helm-projectile helm-swoop
	  
	  ;; ace-jump
	  ace-jump-mode	ace-pinyin	ace-window
	  
	  ;; search tools
	  ag google-translate migemo wgrep wgrep-ag 
	  
	  ;; buffer/window control tools
	  elscreen minibuf-isearch minimap point-undo popup popwin session highlight-symbol
	  
	  ;; misc
	  anzu god-mode multiple-cursors undo-tree undohist
	  
	  ;; auto-complete
	  auto-complete auto-complete-clang-async
	  
	  ;; skk
	  ddskk
	  
	  ;; howm
	  howm
	  
	  ;; web tools
	  mew navi2ch search-web semi w3m wanderlust
	  
	  ;; developmemt tools
	  e2wm emr flycheck ggtags projectile yasnippet
	  
	  ;;  proglaming language tools
	  erlang
	  ))

;; インストールされていないパッケージがあればインストール
(dolist (package my/favorite-packages)
    (unless (package-installed-p package)
	      (package-install package)))


;;;; 各種ライブラリの設定

;;; for mylisp
(load "mylisp.el")

;;; for text-adjust
(load "text-adjust.el")

;;; for dmacro
(load "init-dmacro.el")

;;; for elscreen
(load "init-elscreen.el")

;;; for w3m
(load "init-w3m.el")

;;; for ddskk
(load "init-ddskk.el")

;;; for migemo(Windos 環境は未だ動作しないので無効化)
(if (null (eq system-type 'windows-nt))
	(load "init-migemo.el"))

;;; for navi2ch
(load "init-navi2ch.el")

;;; for session
(load "init-session.el")

;;; for minibuf-isearch
;; 検索関係は helm の方に統合するので無効化(2015/02/23)
;; (load "init-minibuf-isearch.el")

;;; for mew
(load "init-mew.el")

;;; for wanderlust
(load "init-wanderlust.el")

;;; for auto-install
;; 使ってないので無効化(2015/02/23)
;(load "init-auto-install.el")

;;; for windows
(load "init-windows.el")

;;; for howm
(load "init-howm.el")

;;; for mpg123
(load "init-mpg123.el")

;;; for browse-kill-ring
;;; (helm-show-kill-ring が session との相性でエラーが発生するので 
;;;  代りに browse-kill-ring を使用する) → 解消したので browse-kill-ring を無効化
;(load "init-browse-kill-ring.el")

;;; for helm
(load "init-helm.el")

;;; for helm-swoop
(load "init-helm-swoop.el")

;;; for helm-gtags
(load "init-helm-gtags.el")

;;; for ag
(load "init-ag.el")

;;; for smooth-scroll
; C-v, M-v によるスクロールが遅すぎるので無効化
;(load "init-smooth-scroll.el")

;;; for popwin
(load "init-popwin.el")

;;; for search-web
(load "init-search-web.el")

;;; for ace-jump
(load "init-ace-jump.el")

;;; for auto-complete
(load "init-auto-complete.el")

;;; for yasnippet
(load "init-yasnippet.el")

;;; for cc-mode
(load "init-cc-mode.el")

;;; for auto-complete-clang-async
(load "init-auto-complete-clang-async.el")

;;; for ggtags
(load "init-ggtags.el")

;;; for VC
(load "init-vc.el")

;;; for flycheck(Windos 環境は未だ動作しないので無効化)
(if (null (eq system-type 'windows-nt))
	(load "init-flycheck.el"))

;;; for undo-tree
(load "init-undo-tree.el")

;;; for undohist
(load "init-undohist.el")

;;; for point-undo
(load "init-point-undo.el")

;;; for volatile-highlights
(load "init-volatile-highlights.el")

;;; for projectile
(load "init-projectile.el")

;;; for wgrep
(load "init-wgrep.el")

;;; for anzu
(load "init-anzu.el")

;;; for multiple-cursors
(load "init-multiple-cursors.el")

;;; for e2wm
(load "init-e2wm.el")

;;; for god-mode
;;; うざいので無効化
;(load "init-god-mode.el")

;;; for emacs-refactor
(load "init-emr.el")

;;; for minimap
(load "init-minimap.el")

;;; for srefactor
;;; helm-imenu が誤動作するので無効化
;(load "srefactor.el")

;;; for erlang-mode
(load "init-erlang.el")

;;; for google-translate
(load "init-google-translate.el")

;;; for highlight-symbol
(load "init-highlight-symbol.el")

;;; for org-mode
(load "init-org-mode.el")

;;; mode-line setting
;; 何故か elscreen の設定より先に実行するとエラーがでるのでその後ろに移動
(setq-default mode-line-format
              '("-"
                mode-line-mule-info
                mode-line-modified
                mode-line-frame-identification
                mode-line-buffer-identification
                ""
                (line-number-mode "L%l-")
                (column-number-mode "C%c-")
                (-3 . "%p")
				" "
                global-mode-string
                " %[("
                mode-name
                mode-line-process
                minor-mode-alist
                "%n" ")%]-"
                (which-func-mode ("" which-func-format "-"))
                "-%-")
              )
