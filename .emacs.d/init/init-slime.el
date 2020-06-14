;;; https://qiita.com/bori_so1/items/38182e4171fad82c7ff0

;; SBCLをデフォルトのCommon Lisp処理系に設定
(setq inferior-lisp-program "sbcl")
;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner)) 

;;; slime-mode で上書きされるキー設定を元に戻す
(define-key slime-mode-map (kbd "M-?") 'help-for-help)
(define-key slime-mode-map (kbd "M-p") 'previous-line-more)
(define-key slime-mode-map (kbd "M-n") 'next-line-more)
