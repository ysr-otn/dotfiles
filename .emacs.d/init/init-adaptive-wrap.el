;;; https://taipapamotohus.com/post/adaptive-wrap/#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%A8%E8%A8%AD%E5%AE%9A

(setq-default adaptive-wrap-extra-indent 1)
(add-hook 'visual-line-mode-hook #'adaptive-wrap-prefix-mode)
;;; 初期値は無効にしておく
(global-visual-line-mode 0)
(add-hook 'org-mode-hook 'visual-line-mode)  ;; For org macros
