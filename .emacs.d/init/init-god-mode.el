(load "god-mode")

;;; キー設定
(global-set-key (kbd "C-M-l") 'god-mode)
;;; god-mode を千バッファで有効しておく
(setq god-global-mode t)

;;; god-mode を無効にするモードは無しにしておく
(setq god-exempt-major-modes nil)

;;; カーソルの形状と色を god-mode 時は変更
(defun my-update-color ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'bar
                      'box))
  (set-cursor-color (if (or god-local-mode buffer-read-only)
                        "firebrick1"
                      "LawnGreen"))
  (set-face-background 'mode-line (if (or god-local-mode buffer-read-only)
                        "red4"
                      "DarkCyan")))
(add-hook 'god-mode-enabled-hook 'my-update-color)
(add-hook 'god-mode-disabled-hook 'my-update-color)


;;; god-mode に入ったら skk の日本語入力を OFF にし復帰後に元に戻す
(defvar god-mode-skk nil)
(setq skk-latin-mode nil) ; skk ロード前なので各変数を nil で仮初期化
(setq skk-mode nil)
(add-hook 'god-mode-enabled-hook 
		  '(lambda ()
			 (progn
			   (if (eq skk-mode t)
				   (if (null skk-latin-mode)
					   (progn 
						 (skk-latin-mode t)
						 (setq god-mode-skk t))
					 (setq god-mode-skk nil))))))

(add-hook 'god-mode-disabled-hook
		  '(lambda ()
			 (progn
			   (if god-mode-skk
				   (skk-mode t)))))

