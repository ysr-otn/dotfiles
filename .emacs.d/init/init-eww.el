;;; eww の設定
;;; http://futurismo.biz/archives/2950

;;; キー設定
(setq eww-mode-hook
      '(lambda () 
		 (define-key eww-mode-map "j" 'next-line)
		 (define-key eww-mode-map "k" 'previous-line)
		 (define-key eww-mode-map "h" 'backward-char)
		 (define-key eww-mode-map "l" 'forward-char)
		 (define-key eww-mode-map "u" 'eww-back-url)
		 (define-key eww-mode-map "q" 'eww-back-url)
		 (define-key eww-mode-map "B" 'eww-back-url)
		 (define-key eww-mode-map "y" 'eww-forward-url)
		 (define-key eww-mode-map "F" 'eww-forward-url)
		 (define-key eww-mode-map "n" 'shr-next-link)
		 (define-key eww-mode-map "p" 'shr-previous-link)
		 (define-key eww-mode-map "o" 'eww-open-file)
		 (define-key eww-mode-map "\C-o" 'eww)
		 (define-key eww-mode-map "Q" 'quit-window)))


;;; default の検索エンジンを Google に変更
(setq eww-search-prefix "http://www.google.co.jp/search?q=")


;;;  google の検索結果が白みがかるのを修正
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))


;;; 画像を表示させない
(defun eww-disable-images ()
  "eww で画像表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-images ()
  "eww で画像表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))
;; はじめから非表示
(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))

(add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)


;;; browse-url で eww で開く
; (defun browse-url-with-eww ()
;   (interactive)
;   (let ((url-region (bounds-of-thing-at-point 'url)))
;     ;; url
;     (if url-region
;       (eww-browse-url (buffer-substring-no-properties (car url-region)
; 						      (cdr url-region))))
;     ;; org-link
;     (setq browse-url-browser-function 'eww-browse-url)
;     (org-open-at-point-global)))
; (global-set-key (kbd "C-x j") 'browse-url-with-eww)


;;;  サクッと Google 検索をしたいので, 検索機能を強化
; (defun eww-search (term)
;   (interactive "sSearch terms: ")
;   (setq eww-hl-search-word term)
;   (eww-browse-url (concat eww-search-prefix term)))
; 
; (add-hook 'eww-after-render-hook (lambda ()
; 				   (highlight-regexp eww-hl-search-word)
; 				   (setq eww-hl-search-word nil)))
