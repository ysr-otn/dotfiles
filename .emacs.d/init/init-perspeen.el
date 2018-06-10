;; perspeen
(setq perspeen-use-tab t)
(perspeen-mode)

;; プレフィクスキー
(setq perspeen-keymap-prefix nil)

;; 一応，プレフィクスキーを上のように設定するが，C-] はそのままではプレフィクスキーとして
;; 有効化されないので，明示的に C-] をプレフィクスキーとするキーマップを定義し，
;; その中で perspeen の前機能をキーに登録する

(defvar my-perspeen-map (make-sparse-keymap)
  "My perspeen keymap binded to C-].")
(defalias 'my-perspeen-prefix my-perspeen-map)
(define-key global-map (kbd "C-]") 'my-perspeen-prefix)

(define-key my-perspeen-map (kbd "C") 'perspeen-create-ws)
(define-key my-perspeen-map (kbd "N") 'perspeen-next-ws)
(define-key my-perspeen-map (kbd "P") 'perspeen-previous-ws)
(define-key my-perspeen-map (kbd "C-]") 'perspeen-goto-last-ws)
(define-key my-perspeen-map (kbd "K") 'perspeen-delete-ws)
(define-key my-perspeen-map (kbd "R") 'perspeen-rename-ws)
(define-key my-perspeen-map (kbd "e") 'perspeen-ws-eshell)
(define-key my-perspeen-map (kbd "d") 'perspeen-change-root-dir)
(define-key my-perspeen-map (kbd "c") 'perspeen-tab-create-tab)
(define-key my-perspeen-map (kbd "1") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "2") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "3") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "4") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "5") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "6") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "7") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "8") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "9") 'perspeen-ws-jump)
(define-key my-perspeen-map (kbd "s") 'perspeen-goto-ws)
(define-key my-perspeen-map (kbd "p") 'perspeen-tab-prev)
(define-key my-perspeen-map (kbd "n") 'perspeen-tab-next)
(define-key my-perspeen-map (kbd "k") 'perspeen-tab-del)
