(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-options '("-q" "--emacs"))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (load-library "migemo")
  
  ;;; 環境毎の設定
  (cond ((string= (getenv "HOSTTYPE") "linux")
		 (progn
		   (setq migemo-command (substitute-in-file-name "$HOME/homebrew/bin/cmigemo"))
		   (setq migemo-dictionary (substitute-in-file-name "$HOME/homebrew/Cellar/cmigemo/20110227/share/migemo/utf-8/migemo-dict"))
		   (setq migemo-coding-system 'utf-8-unix)
		   ))
		((string= (getenv "HOSTTYPE") "windows")
		 (progn
		   (setq migemo-command (substitute-in-file-name "c:/cygwin64/opt/cmigemo-default-win64/cmigemo"))
		   (setq migemo-dictionary (substitute-in-file-name "c:/cygwin64/opt/cmigemo-default-win64/dict/utf-8/migemo-dict"))
		   (setq migemo-coding-system 'utf-8-dos)
		   ))
		(t
		 (progn
		   (setq migemo-command "/usr/local/bin/cmigemo")
		   (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
		   (setq migemo-coding-system 'utf-8-unix)
		   )))

  (migemo-init)
  
  ;;; migemo を C-q で無効化
  (define-key isearch-mode-map "\C-q" 'migemo-toggle-isearch-enable)

  ;;; isearch-mode が C-y が 'migemo-isearch-yank-line に設定されるので元に戻す
  (defun my-migemo-register-isearch-keybinding ()
	(define-key isearch-mode-map "\C-d" 'migemo-isearch-yank-char)
	(define-key isearch-mode-map "\C-w" 'migemo-isearch-yank-word)
	(define-key isearch-mode-map "\C-y" 'isearch-yank-pop)
	(define-key isearch-mode-map "\M-m" 'migemo-isearch-toggle-migemo))
  (setq migemo-register-isearch-keybinding-function 'my-migemo-register-isearch-keybinding)
)
