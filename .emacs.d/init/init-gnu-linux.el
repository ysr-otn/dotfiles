(setq exec-path
	  (append
	   (list
		(substitute-in-file-name "$HOME/homebrew/opt/llvm/bin")
		"/usr/local/bin"
		)
	   exec-path))

(setenv "PATH"
		(concat (substitute-in-file-name "$HOME/Tools/$HOSTTYPE/bin:")
				(substitute-in-file-name "/usr/local/bin:")
				;;; for llvm
				(substitute-in-file-name "$HOME/homebrew/opt/llvm/bin:")
				(getenv "PATH")))

;;; for llvm
(setenv "DYLD_LIBRARY_PATH"
		(concat "$HOME/homebrew/opt/llvm/lib:"
				(getenv "DYLD_LIBRARY_PATH")))
(setenv "LDFLAGS" "-L$HOME/homebrew/opt/llvm/lib")
(setenv "CPPFLAGS" "-I$HOME/homebrew/opt/llvm/include")
