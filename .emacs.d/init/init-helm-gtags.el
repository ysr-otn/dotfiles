(require 'helm-gtags)

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)

; key bindings
(add-hook 'helm-gtags-mode-hook
		  '(lambda ()
			 ;; helm-gtags-select だけ使いたい
;			 (define-key helm-command-map (kbd "s") 'helm-gtags-select)
			 (local-set-key (kbd "C-M-_") 'helm-gtags-select)
			 ;; 他は ggtags を使うので無効化
			 ;; (heml-gtags-mode だと検索結果の表示がタグジャンプをすると消えるので，
			 ;;  これらのコマンドは消えずに保持される ggtags の方が使い勝手が良いため)
;			 (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
;			 (local-set-key (kbd "M-'") 'helm-gtags-find-rtag)
;			 (local-set-key (kbd "M-,") 'helm-gtags-find-symbol)
;			 (local-set-key (kbd "\C-[ *") 'helm-gtags-pop-stack)
			 ))
