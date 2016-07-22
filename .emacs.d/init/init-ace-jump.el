;;; キー設定
(define-key global-map (kbd "C-'") 'ace-jump-mode)
(define-key global-map (kbd "C-c RET") 'ace-jump-mode)


;;; 日本語対応のために ace-pinyin をロード
(require 'ace-pinyin)

;;; ace-pinyin 用の変換テーブルの設定
(setq load-path
      (append
        (list
		 (substitute-in-file-name "$HOME/.emacs.d/elisp/pinyinlib-japanese"))
		load-path))

;;; ace-pinyin はデフォルトで avy を使うので ace-jump を使うように設定
(setq ace-pinyin-use-avy nil)

;;; pinyinlib の漢字変換テーブルを日本語化するライブラリをロード
(load "pinyinlib-japanese")

;;; キー設定
(global-set-key (kbd "C-;") 'ace-jump-char-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-char-mode)
(ace-pinyin-global-mode 1)


;;; ace-window の設定
(global-set-key (kbd "C-x o") 'ace-window)
;; 1, 2, 3, ... の代りに a, s, d, ... を使用
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
