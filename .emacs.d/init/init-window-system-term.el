;;; 見易いカラーテーマを設定
(load-theme 'wilson t)

;;; 背景色と文字色を設定
(set-foreground-color "white")
(set-background-color "black")

(setq default-frame-alist
					(append (list
							 '(foreground-color . "white")
							 '(background-color . "black")
							 )))
(setq initial-frame-alist 
					(append (list
							 '(foreground-color . "white")
							 '(background-color . "black")
							 )))

;;; カーソル行をハイライト
(custom-set-faces '(hl-line ((t (:background "#000088")))))
(global-hl-line-mode t)
