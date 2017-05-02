(load "elscreen")

;; elscreen 開始
(elscreen-start)

;; for elscreen-w3m
(load "elscreen-w3m")
;; for elscreen-howm
(load "elscreen-howm")
;; for elscreen-wl
(load "elscreen-wl")
;; for elscreen-dired
(load "elscreen-dired")

(elscreen-set-prefix-key "\C-]")
(define-key elscreen-map "\C-]" 'elscreen-toggle)

;; elscreen のタブ化(emacs21 以降でないと face 関係でエラーがでるので，とりあえず中止)
;; (load "elscreen-tab")

;; elscreen: From Emacs 24.3: Symbol's value as variable is void: last-command-char
;; http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=705436
;; のパッチから GNU Emacs 用の対処方法を取り出して advice に変更。
(defadvice elscreen-jump (around elscreen-last-command-char-event activate)
  (let ((last-command-char last-command-event))
	ad-do-it))
