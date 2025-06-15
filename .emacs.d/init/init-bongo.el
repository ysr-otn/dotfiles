;;; bongo が使用するプレーヤとファイルの設定
(cond ((eq system-type 'darwin)					; Mac の場合は afplay
	   (progn
		 (setq bongo-custom-backend-matchers
			   '((afplay local-file "mp3")
				 (afplay local-file "m4a")
				 (timidity local-file "mid")
				 (timidity local-file "midi")))
		 (setq bongo-timidity-extra-arguments "-Od")	; Timidity 再生のために -Od オプションが必要
		 )))
