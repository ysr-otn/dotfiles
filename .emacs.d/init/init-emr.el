(autoload 'emr-show-refactor-menu "emr")
(load "emr-c")

(define-key c-mode-map (kbd "C-c e") 'emr-show-refactor-menu)
(add-hook 'c-mode-hook 'emr-initialize)

(define-key c++-mode-map (kbd "C-c e") 'emr-show-refactor-menu)
(add-hook 'c++-mode-hook 'emr-initialize)
