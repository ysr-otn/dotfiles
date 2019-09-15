
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
