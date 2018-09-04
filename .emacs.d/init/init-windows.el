(setq load-path
      (append
       (list
		(substitute-in-file-name "$HOME/.emacs.d/elisp/windows")
		)
       load-path))

;;(setq win:quick-selection nil)

;(define-key global-map "\C-cw1" 'win-switch-to-window)
(setq win:configuration-file (substitute-in-file-name "$HOME/.emacs.d/windows/windows-private.el"))
(require 'windows)
(define-key global-map "\C-xC" 'see-you-again)
(win:startup-with-window)
(setq win:auto-position nil)
;(setq win:use-frame nil)	; 新規にフレームを作らない



(setq win:switch-prefix [esc])
(define-key global-map win:switch-prefix nil)
(define-key esc-map "1" 'win-switch-to-window)
(define-key esc-map "2" 'win-switch-to-window)
(define-key esc-map "3" 'win-switch-to-window)
(define-key esc-map "4" 'win-switch-to-window)
(define-key esc-map "5" 'win-switch-to-window)
(define-key esc-map "6" 'win-switch-to-window)
(define-key esc-map "7" 'win-switch-to-window)
(define-key esc-map "8" 'win-switch-to-window)
(define-key esc-map "9" 'win-switch-to-window)
(define-key esc-map "0" 'win-toggle-window)
(define-key esc-map "-" 'win-switch-menu)
