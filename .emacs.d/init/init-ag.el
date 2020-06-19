(require 'ag)
(require 'wgrep-ag)
(require 'helm-ag)

;;; Emacsから外部プロセスを実行するときのコーディングシステムをカレントバッファに合わせる
(my-adapt-coding-system-with-current-buffer ag)
