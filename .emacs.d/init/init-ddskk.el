;;;;;;;;;;;;;;;;;;;; for skk ;;;;;;;;;;;;;;;;;;;;;;;;

(setq skk-user-directory "~/.emacs.d/ddskk/") ; ディレクトリ指定
(when (require 'skk-autoloads nil t)
  ;; C-x C-j で skk モードを起動
  (define-key global-map (kbd "C-x C-j") 'skk-mode)
  ;; .skk を自動的にバイトコンパイル
  (setq skk-byte-compile-init-file t))

;;; 送り仮名の自動認識
;(setq skk-auto-okuri-process nil)
;(setq skk-process-okuri-early nil)
