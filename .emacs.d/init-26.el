;;; for timer(used from tooltip, navi2ch)
(load "timer.el")

;;; カーソルを点滅しない
(blink-cursor-mode 0)

;;; スペースでも補完できるようにする
(if (boundp 'minibuffer-local-filename-completion-map)
    (define-key minibuffer-local-filename-completion-map
                " " 'minibuffer-complete-word))
(if (boundp 'minibuffer-local-must-match-filename-map)
    (define-key minibuffer-local-must-match-filename-map
                " " 'minibuffer-complete-word)) 

;;; ツールバーを消す(ウィンドウシステムの時のみ)
(if window-system
	(tool-bar-mode 0))

;;; default-* が Emacs-26 系から消えているので package が参照している変数を定義
;;; http://suzuki.tdiary.net/20161226.html
(setq default-truncate-lines (default-value 'truncate-lines))

