(setq exec-path
	  (append
	   (list
		"/opt/homebrew/opt/llvm/bin"
		"/opt/homebrew/bin"		
		"/usr/local/bin"
		)
	   exec-path))

(setenv "HOSTTYPE" "i386")

(setenv "LANG" "ja_JP.UTF-8")

(setenv "PATH"
		(concat (substitute-in-file-name "$HOME/Tools/$HOSTTYPE/bin:")
				;; for pyenv
				(concat (getenv "HOME") "/.pyenv/shims:")
				(concat (getenv "HOME") "/.pyenv/bin:")
				
				(substitute-in-file-name "/opt/homebrew/bin:")
				
				(substitute-in-file-name "/usr/local/bin:")
				
				;;; for llvm
				(substitute-in-file-name "/usr/local/opt/llvm/bin:")
				
				;;; for node
				(concat (getenv "HOME") "/.nodebrew/current/bin:")
				
				(getenv "PATH")))

;;; for llvm
(setenv "DYLD_LIBRARY_PATH"
		(concat "/opt/homebrew/opt/llvm/lib:"
				(getenv "DYLD_LIBRARY_PATH")))

(setenv "LDFLAGS" "-L/opt/homebrew/opt/llvm/lib")
(setenv "CPPFLAGS" "-I/opt/homebrew/opt/llvm/include")

;; for pyenv
(setenv "PYENV_ROOT" (concat (getenv "HOME") "/.pyenv"))
(setenv "PYENV_SHELL" "zsh")

;;; command キー(システム側で option キーになっている)をメタキーにする
(setq mac-option-modifier 'meta)


;;; dired で ! によるプログラムの起動に open を用いる
(add-to-list 'dired-guess-shell-alist-user '("\\..*$" "open"))
