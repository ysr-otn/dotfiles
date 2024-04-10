(require 'ag)
(require 'wgrep-ag)
(require 'helm-ag)

;;; Emacsから外部プロセスを実行するときのコーディングシステムをカレントバッファに合わせる
;;; (Windows は init-windows-nt.el でプロセス間コーディングの設定をしているので不要)
(if (not (eq system-type 'windows-nt))
	(my-adapt-coding-system-with-current-buffer ag))
