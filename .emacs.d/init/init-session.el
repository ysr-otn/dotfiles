(add-hook 'after-init-hook 'session-initialize)
(setq session-globals-include 
	  '((kill-ring 0)	;; kill-ring を保存をすると次回ロード時にエラーが出る事があるので保存しない
		(session-file-alist 1000 t)
		(file-name-history 1000)))
(setq session-globals-max-size 1000000)

(setq session-globals-max-string 100000000) ;; これがないと file-name-history に500個保存する前に max-string に達する
(add-hook 'after-init-hook 'session-initialize)
(setq session-save-file 
	  (concat (substitute-in-file-name "$HOME/.emacs.d/session/session-")
			  (number-to-string emacs-major-version)
			  ".el"))

;;; この設定をしておかないと helm-show-kill-ring でエラーが発生する
;;; https://github.com/emacs-helm/helm/issues/94
(setq session-save-print-spec '(t nil 40000))

(require 'session nil t)
