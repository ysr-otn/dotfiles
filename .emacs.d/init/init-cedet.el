;;; https://www.emacswiki.org/emacs/CEDET_Quickstart

(load-library "cedet")
;(semantic-load-enable-code-helpers)

(semantic-mode)

;; Semantic
(global-semantic-idle-completions-mode t)
(global-semantic-decoration-mode t)
(global-semantic-highlight-func-mode t)
(global-semantic-show-unmatched-syntax-mode t)

;; CC-mode
(add-hook 'c-mode-hook '(lambda ()
        (setq ac-sources (append '(ac-source-semantic) ac-sources))
        (local-set-key (kbd "RET") 'newline-and-indent)
        (linum-mode t)
        (semantic-mode t)))

;; Autocomplete
(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories (expand-file-name
;             "~/.emacs.d/elpa/auto-complete-1.4.20110207/dict"))
;(setq ac-comphist-file (expand-file-name
;             "~/.emacs.d/ac-comphist.dat"))
(ac-config-default)

(global-ede-mode 1)
;(semantic-load-enable-excessive-code-helpers)      ; Enable prototype help and smart completion 
(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; Semantic
(global-semantic-idle-scheduler-mode)
(global-semantic-idle-completions-mode)
(global-semantic-decoration-mode)
(global-semantic-highlight-func-mode)
(global-semantic-show-unmatched-syntax-mode)

;; CC-mode
(add-hook 'c-mode-common-hook '(lambda ()
        (setq ac-sources (append '(ac-source-semantic) ac-sources))
))
