(require 'company)

;;; 各種キー設定
(define-key company-active-map (kbd "C-i") 'company-select-next)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-M-h") 'company-show-doc-buffer)
(define-key company-search-map (kbd "C-i") 'company-select-next)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-M-h") 'company-show-doc-buffer)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;; 一部のキーマップを無効化
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-h") nil)  

;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
(delq 'company-files company-backends)
(add-to-list 'company-backends 'company-files)

;;; company-mode を有効化
(global-company-mode)

;;; company のヘルプを有効化
(company-quickhelp-mode)

;;; clang のパスを指定
(setq company-clang-executable "/usr/local/opt/llvm/bin/clang")
