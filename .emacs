(cond 
 ((>= (string-to-number emacs-version) 24)	   
  (load-library (substitute-in-file-name "$HOME/.emacs.d/init.el")))
 ((>= (string-to-number emacs-version) 20)	   
  (load-library (substitute-in-file-name "$EMACS_STARTUP/.emacs.el")))
 ((< (string-to-int emacs-version) 19)
  (load-library (substitute-in-file-name "$EMACS_STARTUP/.mule.el")))
 ((and window-system (string-match "XEmacs" emacs-version))
  (load-library "$EMACS_STARTUP/.xemacs.el"))
 )

;;; ��μ��Ϥ����񤯤��Ȥ��
;;(load-library (if (string-match "^20" emacs-version)
;;				  "~/emacs/startup/.emacs-20.el"
;;				"~/emacs/startup/.mule.el"))


;(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-clang-cflags (quote ("-I./")))
 '(anzu-search-threshold 1024)
 '(anzu-use-migemo nil)
 '(helm-command-prefix-key "C-c h")
 '(helm-mini-default-sources
   (quote
	(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(projectile-enable-caching t)
 '(search-web-default-browser (quote eww-browse-url))
 '(search-web-in-emacs-browser (quote w3m-browse-url))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "dark slate gray")))))
