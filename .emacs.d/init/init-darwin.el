(setq exec-path
	  (append
	   (list
		"/usr/local/bin"
		"/Applications/CarbonEmacs.app/Contents/MacOS/bin/"
		)
	   exec-path))

(setenv "PATH"
		(concat (substitute-in-file-name "/usr/local/bin:")
				(getenv "PATH")))
