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
