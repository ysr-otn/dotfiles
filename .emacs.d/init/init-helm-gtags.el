(require 'helm-gtags)

(add-hook 'c-mode-hook 'helm-gtags-mode)

; key bindings
(add-hook 'helm-gtags-mode-hook
		  '(lambda ()
			 ;; helm-gtags-select だけ使いたい
;			 (define-key helm-command-map (kbd "s") 'helm-gtags-select)
			 (local-set-key (kbd "C-M-_") 'helm-gtags-select)
			 ;; 他は ggtags を使うので無効化
;			 (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
;			 (local-set-key (kbd "M-'") 'helm-gtags-find-rtag)
;			 (local-set-key (kbd "M-,") 'helm-gtags-find-symbol)
;			 (local-set-key (kbd "\C-[ *") 'helm-gtags-pop-stack)
			 ))
