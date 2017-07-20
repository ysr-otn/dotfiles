

;;; font
; 「msgochic」という名前で新たなフォントセットを定義
; 英字フォントとしてＭＳ ゴシック、12ポイントを使用
(create-fontset-from-ascii-font
 "-outline-ＭＳ ゴシック-normal-r-normal-normal-12-*-*-*-*-*-iso8859-1"
 nil "msgochic")

; myfont-msgochicの日本語フォントとしてメイリオを使用
(set-fontset-font "fontset-msgochic"
                  'japanese-jisx0208
				  '("ＭＳ ゴシック" . "jisx0208-sjis"))

; myfont-msgochicのカタカナフォントとしてメイリオを使用
(set-fontset-font "fontset-msgochic"
                  'katakana-jisx0201
                  '("ＭＳ ゴシック" . "jisx0201-katakana"))

; 定義したフォントセットを登録
(add-to-list 'default-frame-alist
			 '(font . "fontset-msgochic"))



;;; プログラミング向けフォント Migu 2M を使用
;;; http://mix-mplus-ipa.osdn.jp/migu/
;(set-default-font "Migu 2M-10")

;;; frame
(setq default-frame-alist
      (append (list
				'(width . 124)
				'(height . 92)
				'(top		. 0)
				'(left		. 0)
;;; 色はカラーテーマに任せる
;				'(foreground-color . "white")
;				'(background-color . "black")
;				'(cursor-color . "turquoise3")
				'(font . "fontset-msgochic")    ; 通常のフォント
;				'(ime-font . (w32-logfont; 変換待ち中のフォント設定
;							  "ms-gothic9"
;							  0 -12 400 0 nil nil nil
;							  128 1 3 49))
				
				)))

(setq initial-frame-alist
      (append (list
				'(width . 124)
				'(height . 92)
				'(top		. 0)
				'(left		. 0)
;;; 色はカラーテーマに任せる
;				'(foreground-color . "white")
;				'(background-color . "black")
;				'(cursor-color . "turquoise3")
				'(font . "fontset-msgochic")    ; 通常のフォント
;				'(ime-font . (w32-logfont; 変換待ち中のフォント設定
;							  "ms-gothic9"
;							  0 -12 400 0 nil nil nil
;							  128 1 3 49))
				
				)))
