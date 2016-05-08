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

;;; ツールバーを消す
(tool-bar-mode 0)
