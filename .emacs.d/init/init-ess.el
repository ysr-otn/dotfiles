(add-hook 'ess-load-hook
		  '(lambda () 
			 (progn
			   ;; インデントの幅を4にする（デフォルト2）
			   (setq ess-indent-level 4))))
