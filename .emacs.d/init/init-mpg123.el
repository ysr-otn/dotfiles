(if (executable-find "mpg123")
	(progn
	  (setq load-path
			(cons
			 (substitute-in-file-name "$HOME/.emacs.d/elisp/mpg123")
			 load-path))
	  (load "mpg123")))


