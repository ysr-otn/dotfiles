(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-options '("-q" "--emacs"))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
)

(setq migemo-command "/usr/local/bin/cmigemo")

(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

;;; migemo を C-q で無効化
(define-key isearch-mode-map "\C-q" 'migemo-toggle-isearch-enable)
