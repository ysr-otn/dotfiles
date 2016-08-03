;;; iedit-toggle-key-default に設定されている C-; が ace-jump-char-mode とキーが被るので無効化
(setq iedit-toggle-key-default nil)

(autoload 'emr-show-refactor-menu "emr")
(load "emr-c")


(add-hook 'c-mode-hook 
		  '(lambda ()
			 (progn
			   (define-key c-mode-map (kbd "C-c e") 'emr-show-refactor-menu)
			   (emr-initialize))))

(add-hook 'c++-mode-hook 
		  '(lambda ()
			 (progn
			   (define-key c++-mode-map (kbd "C-c e") 'emr-show-refactor-menu)
			   (emr-initialize))))

