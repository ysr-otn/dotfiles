(require 'popwin)

;;; Emacs-26 系から dired と popwin を組合せた時に，リンクを開くと
;;; 常に新しいウインドウを立ち上げるように挙動が変ったので修正
;;; https://blog.shibayu36.org/entry/2018/12/25/193000
(cond ((>= (string-to-number emacs-version) 26)
	   (progn
		 (popwin-mode 1)
		 (setq pop-up-windows nil) 
		 ))
	  (t
	   (progn
		 (setq display-buffer-function 'popwin:display-buffer)
		 ))
	  )

(setq popwin:popup-window-position 'bottom)
