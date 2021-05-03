(require 'lsp)
(require 'lsp-ui)
(setq lsp-prefer-capf t)	; for company-capf
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)

(cond ((eq system-type 'windows-nt)
	   (setq lsp-clients-clangd-executable "C:/msys64/mingw64/bin/clangd"))
	  (t
	   (setq lsp-clients-clangd-executable "/usr/local/opt/llvm/bin/clangd")))
(setq lsp-prefer-flymake nil)


(use-package lsp-mode
  :config
  ;; `-background-index' requires clangd v8+!
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error"))

  ;; ..
  )

;;; compile_commands.json を用いた補完のための ccls の設定
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))
