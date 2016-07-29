(require 'srefactor)
(require 'srefactor-lisp)

;; OPTIONAL: ADD IT ONLY IF YOU USE C/C++. 
(semantic-mode 1) ;; -> this is optional for Lisp

(global-set-key (kbd "C-c r") nil)
(global-set-key (kbd "C-c r o") 'srefactor-lisp-one-line)
(global-set-key (kbd "C-c r m") 'srefactor-lisp-format-sexp)
(global-set-key (kbd "C-c r d") 'srefactor-lisp-format-defun)
(global-set-key (kbd "C-c r b") 'srefactor-lisp-format-buffer)

(add-hook 'c-mode-hook 
		  '(lambda ()
			 (progn
			   (define-key c-mode-map (kbd "C-c r") 'srefactor-refactor-at-point))))

(add-hook 'c-mode-hook 
		  '(lambda ()
			 (progn
			   (define-key c++-mode-map (kbd "C-c r") 'srefactor-refactor-at-point))))
