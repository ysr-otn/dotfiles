(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)

(setq ac-use-menu-map t)
(setq ac-delay 0.1) ; auto-completeまでの時間
(setq ac-auto-show-menu 0.2) ; メニューが表示されるまで
(setq ac-use-fuzzy t) ; 曖昧検索
(global-set-key "\M-/" 'ac-start)

(require 'ac-helm)
(define-key ac-complete-mode-map (kbd "C-c a") 'ac-complete-with-helm)
