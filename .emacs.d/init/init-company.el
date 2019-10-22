(require 'company)

;;; TAB での補完を効率化
;;; https://qiita.com/sune2/items/b73037f9e85962f5afb7
(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
	(setq candidate (substring-no-properties candidate))
	(if (eq (company-call-backend 'ignore-case) 'keep-prefix)
		(insert (company-strip-prefix candidate))
	  (if (equal company-prefix candidate)
		  (company-select-next)
		(delete-region (- (point) (length company-prefix)) (point))
		(insert candidate))
	  )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
	(if (and (not (cdr company-candidates))
			 (equal company-common (car company-candidates)))
		(company-complete-selection)
	  (company--insert-candidate2 company-common))))

(define-key company-active-map [tab] 'company-complete-common2)
(define-key company-active-map [backtab] 'company-select-previous) ; おまけ
  
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
