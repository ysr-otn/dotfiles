(setq exec-path
	  (append
	   (list
		"/usr/local/bin"
		"/Applications/CarbonEmacs.app/Contents/MacOS/bin/"
		)
	   exec-path))

(setenv "HOSTTYPE" "i386")

(setenv "PATH"
		(concat (substitute-in-file-name "$HOME/Tools/$HOSTTYPE/bin:")
				(substitute-in-file-name "/usr/local/bin:")
				(getenv "PATH")))

;;; for llvm
(setenv "DYLD_LIBRARY_PATH"
		(concat "/usr/local/Cellar/llvm/3.5.0/lib:"
				(getenv "DYLD_LIBRARY_PATH")))
