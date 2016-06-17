;; vc で ediff を使用
(require 'vc)
(require 'vc-dir)
(eval-after-load "vc-hooks"
  '(progn
	 (define-key vc-prefix-map "E" 'vc-ediff)
	 (define-key vc-dir-mode-map "E" 'vc-ediff)
	 (define-key vc-dir-mode-map "H" 'vc-dir-hide-state)
	 ))

