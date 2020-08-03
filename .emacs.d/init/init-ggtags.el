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
;;; http://philos0.blog94.fc2.com/blog-entry-38.html をベースに修正
(defvar parent-project "" "current project parent directory" )

(defun my-project nil "setup my project"
	   (interactive)
	   (setq parent-project (expand-file-name (read-file-name "project parent directory : ")))
	   (setq gtags-rootdir parent-project))

(add-hook 'c-mode-hook 'c-init-for-gtags)

(defun c-init-for-gtags nil
  " C mode specific setup for GTAGS. "
  (cond (parent-project nil) (t (my-project)))
  (ggtags-mode 1))


;;; Emacsから外部プロセスを実行するときのコーディングシステムをカレントバッファに合わせる
(my-adapt-coding-system-with-current-buffer gtags-find-tag)
(my-adapt-coding-system-with-current-buffer gtags-find-with-idutils)
(my-adapt-coding-system-with-current-buffer gtags-find-with-grep)
(my-adapt-coding-system-with-current-buffer ggtags-find-tag-dwim)
(my-adapt-coding-system-with-current-buffer ggtags-find-reference)
(my-adapt-coding-system-with-current-buffer ggtags-find-other-symbol)
(my-adapt-coding-system-with-current-buffer ggtags-show-definition)

