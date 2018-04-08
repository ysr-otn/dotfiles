;;; https://pxaka.tokyo/wiki/emacs#bongo_%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B
;;; bongo が使用するプレーヤとファイルの設定
(cond ((eq system-type 'darwin)					; Mac の場合は afplay
	   (progn
		 (setq bongo-custom-backend-matchers
			   '((afplay local-file "mp3")
				 (afplay local-file "m4a")))))
		 )
