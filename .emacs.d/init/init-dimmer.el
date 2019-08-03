;;; https://qiita.com/takaxp/items/6ec37f9717e362bef35f
(setq dimmer-fraction 0.25)
(setq dimmer-exclusion-regexp "^\\*helm\\|^ \\*Minibuf\\|^\\*Calendar") 
(dimmer-mode 1)
(with-eval-after-load "dimmer"
  (defun dimmer-off ()
    (dimmer-mode -1)
    (dimmer-process-all))
  (defun dimmer-on ()
    (dimmer-mode 1)
    (dimmer-process-all))
  (add-hook 'focus-out-hook #'dimmer-off)
  (add-hook 'focus-in-hook #'dimmer-on))
