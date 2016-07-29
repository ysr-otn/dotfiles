(autoload 'browse-kill-ring "browse-kill-ring" "interactively insert items from kill-ring" t)
(global-set-key (kbd "C-M-y") 'browse-kill-ring)

;;; browse-kill-ring 時の表示を 1 行に纏める
; (setq browse-kill-ring-display-style 'one-line)


