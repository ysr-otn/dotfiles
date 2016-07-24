;; auto-complete-clang-async
(require 'auto-complete-clang-async)
(setq ac-clang-complete-executable (substitute-in-file-name "/usr/local/bin/clang-complete"))

(add-hook 'c++-mode-hook
          '(lambda()
			 (setq ac-sources '(ac-source-clang-async))
			 (ac-clang-launch-completion-process)))

(add-hook 'c-mode-hook
          '(lambda()
			 (setq ac-sources '(ac-source-clang-async))
			 (ac-clang-launch-completion-process)))
