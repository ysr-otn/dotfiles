(setq load-path
      (cons
	   (substitute-in-file-name "$HOME/.emacs.d/elisp/howm")
	   load-path))

(setq howm-directory "~/Documents/memo")
(setq howm-menu-lang 'ja)
(setq howm-menu-file "~/.howm-menu")
(require 'howm-mode)
;(howm-setup-changelog)
