;;; abbrev_debs を読み込んだかどうか
(defvar loaded-abbrev-file nil)


;;; c-mode 関係全般の汎用的な設定
(add-hook 'c-mode-common-hook
	  '(lambda()
		 ;;; abbrev ファイルの読み込み
		 (if (null loaded-abbrev-file)
			 (progn
			   (read-abbrev-file abbrev-file-name)
			   (setq loaded-abbrev-file t)))
	     ;;; Linux では文字コードを euc-jp-unix に合せ込み→異なる文字コードのファイルを扱う事になったので廃止
; 		 (if (and (eq system-type 'gnu/linux)
; 				  (not (buffer-modified-p))
; 				  (not (eq save-buffer-coding-system 'euc-jp-unix)))
; 			 (progn
; 			   (setq save-buffer-coding-system 'euc-jp-unix)
; 			   (let ((coding-system-for-read 'euc-jp-unix)
; 					 (coding-system-for-write 'euc-jp-unix))
; 				 (revert-buffer nil t))))
		 ;; キー設定
		 (define-key c-mode-base-map [(control meta h)] 'backward-kill-word)
		 (define-key c-mode-base-map [(meta h)] 'c-mark-function)  
		 ))

;;; for java-mode 
(setq java-mode-hook nil)	; 余計な hook をされないために一端 nil でクリア
(add-hook  
 'java-mode-hook
 '(lambda ()  
    (make-local-variable 'compile-command)
    (setq compile-command  
	  (concat "javac "  
		  (file-name-nondirectory buffer-file-name)))
    (c-set-style "java")
	;; タブ設定
    (setq c-basic-offset 4)
	;;; hilit-java の読み込み
	;;	(if (null loaded-hilit-java)
	;;		(progn
	;;		  (load "hilit-java")
	;;		  (setq loaded-hilit-java t)))
	))

;;; for c-mode
(setq c-mode-hook nil)		; 余計な hook をされないために一端 nil でクリア
(add-hook  
 'c-mode-hook
 '(lambda ()
    ;; コンパイルコマンドの設定
    (make-local-variable 'compile-command)  
    (set-compile-command-for-c)
    ;; コーディングスタイルの設定
	(c-set-style "k&r")
    ;; タブ設定
	(setq c-basic-offset 4)
	))

;;; for c++-mode
(setq c++-mode-hook nil)	; 余計な hook をされないために一端 nil でクリア
(add-hook  
 'c++-mode-hook
 '(lambda ()
    ;; コンパイルコマンドの設定  
    (make-local-variable 'compile-command)  
    ;; コーディングスタイルの設定
	(set-compile-command-for-c)
    (c-set-style "k&r")
    ;; タブ設定
	(setq c-basic-offset 4)
	))

;;; compile コマンド設定
(defun set-compile-command-for-c ()  
  (interactive)  
  ;; org-mode のソースコード内では buffer-file-name が nil なのでエラーが出ないように 
  ;; buffer-file-name が存在する時のみ以下の処理を実行
  (cond ((null (eq buffer-file-name nil))
		 (let* ((filename (file-name-nondirectory buffer-file-name))  
				(index (or (string-match "\\.c$" filename)
						   (string-match "\\.cc$" filename)
						   (string-match "\\.cxx$" filename)
						   (string-match "\\.cpp$" filename)))
				(filename-no-suffix (substring filename 0 index)))
		   (cond  
			;; Makefile があれば "gmake -k"  
			((or (file-exists-p "Makefile")  
				 (file-exists-p "makefile"))
			 ;; Dual CPU マシンの場合はコンパイルプロセスを複数同時に走らせる
			 ;; (ついでに LANG 設定を C にしてコンパイルメッセージを英語にしコンパイルエラー行に compile-goto-error で飛べるようにしておく)
			 (cond ((string-match "^\\(dsclinux...\\)\\(\\..+\\)*$"
								  system-name)
					(setq compile-command "LC_ALL=C make -k -j 4"))
				   (t 
					(setq compile-command "gmake -k"))))
			;; ヘッダファイルがあれば、オブジェクトファイルをつくる  
			((file-exists-p (concat filename-no-suffix ".h"))  
			 (setq compile-command  
				   (concat "gcc -ansi -Wall -g -c " filename)))  
			((or (string-match "\\.cc$" filename)
				 (string-match "\\.cxx$" filename)
				 (string-match "\\.cpp$" filename))
			 (setq compile-command  
				   (concat "g++ -ansi -Wall -g -lstdc++ -o "
						   filename-no-suffix " " filename)))
			;; それ以外ならファイル名の実行ファイルを作成
			(t 
			 (setq compile-command  
				   (concat "gcc -ansi -Wall -g -o "
						   filename-no-suffix " " filename))))))))

;;; for hideif-extension
;;; 注: hideif-extension.el は 
;;;     ~/Development/github/ysr-otn/dotfiles/.emacs.d/elisp/misc/hideif-extension.el に
;;;     ~/Development/github/ysr-otn/hideif-extension/hideif-extension.el へのシンボリックリンク
;;;     としており，.gitignore で git の管理対象外としている(Windows 環境との共存のため)
(require 'hideif-extension)
