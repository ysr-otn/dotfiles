(buffer-expose-mode 1)

(define-key buffer-expose-mode-map (kbd "C-c b e") 'buffer-expose)
(define-key buffer-expose-mode-map (kbd "C-c b n") 'buffer-expose-no-stars)
(define-key buffer-expose-mode-map (kbd "C-c b c") 'buffer-expose-current-mode)
(define-key buffer-expose-mode-map (kbd "C-c b m") 'buffer-expose-major-mode)
(define-key buffer-expose-mode-map (kbd "C-c b d") 'buffer-expose-dired-buffers)
(define-key buffer-expose-mode-map (kbd "C-c b *") 'buffer-expose-stars)
