;;; コードブロックをそのモードと同じ色付けをする
(setq org-src-fontify-natively t)



;;; for org-present

;(eval-after-load "org-present"
;  '(progn
;     (add-hook 'org-present-mode-hook
;               (lambda ()
;                 (org-present-big)
;                 (org-display-inline-images)
;                 (org-present-hide-cursor)
;                 (org-present-read-only)))
;     (add-hook 'org-present-mode-quit-hook
;               (lambda ()
;                 (org-present-small)
;                 (org-remove-inline-images)
;                 (org-present-show-cursor)
;                 (org-present-read-write)))
;     ;; 文字をどれだけ大きくするかを設定する
;     (setq org-present-text-scale 5)))




;;; for org-tree-slide-mode

;;; ヘッダの表示を無効化する
(setq org-tree-slide-header nil)

;;; 起動時に見出しを強調する
(setq org-tree-slide-heading-emphasis t)

;;; 起動時にヘッダを表示しないようにする
(setq org-tree-slide-slide-in-effect nil)

;;; スライド化するツリーのレベル(0 なら全てスライド化)
(setq org-tree-slide-skip-outline-level 0) 

;;; スライドインの開始位置を調節する（行数を指定）
(setq org-tree-slide-slide-in-brank-lines 10) 

(add-hook 'org-mode-hook
		  '(lambda ()
			 ;;; for org-tree-slide-move
			 (progn
			   (load "org-tree-slide")
			   
			   (define-key org-mode-map (kbd "C-c t") 'org-tree-slide-mode)
			   
			   (define-key org-tree-slide-mode-map (kbd "<right>") 'org-tree-slide-move-next-tree)
			   (define-key org-tree-slide-mode-map (kbd "n") 'org-tree-slide-move-next-tree)
			   (define-key org-tree-slide-mode-map (kbd "<left>") 'org-tree-slide-move-previous-tree)
			   (define-key org-tree-slide-mode-map (kbd "p") 'org-tree-slide-move-previous-tree)
			   
			   (setq org-tree-slide-mode-play-hook nil)
			   (setq org-tree-slide-mode-stop-hook nil)
			   
			   (add-hook 'org-tree-slide-mode-play-hook
						 '(lambda () 
							(text-scale-adjust 0)
							(text-scale-adjust 4)
							(org-display-inline-images)
							(read-only-mode 1)
							))
			   
			   (add-hook 'org-tree-slide-mode-stop-hook
						 '(lambda () 
							(text-scale-adjust 0)
							(org-remove-inline-images)
							(read-only-mode -1)
							))
			   )
		     ;;; for ox-reveal
			 (progn
			   (load-library "ox-reveal")
			   )
			 ))

;; 画像の幅を変更するときに必要っぽい
;; https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode
(setq org-image-actual-width t)
