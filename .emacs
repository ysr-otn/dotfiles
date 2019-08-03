
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-search-threshold 1024)
 '(anzu-use-migemo nil)
 '(helm-command-prefix-key "C-c h")
 '(helm-mini-default-sources
   (quote
	(helm-source-buffers-list helm-source-recentf helm-source-files-in-current-dir helm-source-emacs-commands-history helm-source-emacs-commands)))
 '(package-selected-packages
   (quote
	(buffer-expose adaptive-wrap yatex wgrep-ag wanderlust w3m volatile-highlights vline undohist sublime-themes srefactor smooth-scroll smartrep session search-web popwin point-undo perspeen ox-reveal org-tree-slide org-present neotree navi2ch multiple-cursors minimap minibuf-isearch migemo mew markdown-mode japanese-holidays image-dired+ image+ htmlize howm highlight-symbol helm-swoop helm-projectile helm-gtags helm-c-yasnippet helm-ag google-translate god-mode ggtags fuzzy flycheck evil erlang emr elscreen e2wm ddskk cp5022x color-theme-sanityinc-tomorrow browse-kill-ring bongo auto-complete-clang-async auto-compile anzu ag ace-window ace-pinyin ace-isearch ac-helm)))
 '(projectile-enable-caching t)
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "dark slate gray")))))
