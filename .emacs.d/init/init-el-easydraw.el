(setq load-path
      (append
       (list
		(substitute-in-file-name "$HOME/.emacs.d/elisp/el-easydraw")
		)
       load-path))

(with-eval-after-load 'org
  (require 'edraw-org)
  (edraw-org-setup-default))

;; When using the org-export-in-background option (when using the
;; asynchronous export function), the following settings are
;; required. This is because Emacs started in a separate process does
;; not load org.el but only ox.el.
(with-eval-after-load "ox"
  (require 'edraw-org)
  (edraw-org-setup-exporter))
