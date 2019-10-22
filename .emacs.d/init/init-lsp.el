(require 'lsp)
(require 'lsp-clients)
(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
