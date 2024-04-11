(require 'ggtags)

(add-hook 'c-mode-common-hook
		  (lambda ()
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
			  (ggtags-mode 1))))


(global-set-key "\M-." 'ggtags-find-tag-dwin)
(global-set-key "\M-'" 'ggtags-find-reference)
(global-set-key "\M-," 'ggtags-find-other-symbol)

(define-key ggtags-navigation-map "\C-cp" 'previous-error)
(define-key ggtags-navigation-map "\C-cn" 'next-error)
(define-key ggtags-navigation-map "\M-p" 'previous-line-more)
(define-key ggtags-navigation-map "\M-n" 'next-line-more)
(define-key ggtags-navigation-map "\M-{" 'backward-paragraph)
(define-key ggtags-navigation-map "\M-}" 'forward-paragraph)
(define-key ggtags-navigation-map "\M-<" 'beginning-of-buffer)
(define-key ggtags-navigation-map "\M->" 'end-of-buffer)


;;; 複数の GTAGS のプロジェクトを切り替えるための設定
(defun c-init-for-ggtags ()
  " C mode specific setup for GTAGS. "
  ;; "global -p" でプロジェクトのルートディレクトリが得られたら ggtags-project-root にそれを設定
  (let ((global-output (shell-command-to-string "global -p")))
	(if (string-match-p ".*GTAGS not found" global-output)
		(setq ggtags-project-root (shell-command-to-string "global -p"))))
  ;; ggtags-mode 有効化
  (ggtags-mode 1))

;;; c-mode, c++-mode に ggtags の設定を適用
(add-hook 'c-mode-hook 'c-init-for-ggtags)
(add-hook 'c++-mode-hook 'c-init-for-ggtags)


;;; Emacsから外部プロセスを実行するときのコーディングシステムをカレントバッファに合わせる
(my-adapt-coding-system-with-current-buffer gtags-find-tag)
(my-adapt-coding-system-with-current-buffer gtags-find-with-idutils)
(my-adapt-coding-system-with-current-buffer gtags-find-with-grep)
(my-adapt-coding-system-with-current-buffer ggtags-find-tag-dwim)
(my-adapt-coding-system-with-current-buffer ggtags-find-reference)
(my-adapt-coding-system-with-current-buffer ggtags-find-other-symbol)
(my-adapt-coding-system-with-current-buffer ggtags-show-definition)

