(add-hook 'ess-load-hook
		  '(lambda () 
			 (progn
			   ;; インデントの幅を4にする（デフォルト2）
			   (setq ess-indent-level 4))))

;;; 使用するプログラムを R に設定
(setq-default inferior-R-program-name "R")
