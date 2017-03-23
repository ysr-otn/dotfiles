;; 日本語の設定（UTF-8）
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; 日本語IM用の設定（inline_patch を当てていることが条件）
(setq default-input-method "MacOSX")


;;; タブ，全角空白，改行の前にあるスペースおよびタブを強調表示
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

;;; default-frame-alist と，以下は両方設定しておく必要がある．
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "turquoise3")


;;;その他の色の設定
(set-mouse-color "black")
(set-border-color "red")
(set-face-background 'highlight "Navy")
(set-face-background 'region "Navy")
(set-face-background 'secondary-selection "white")

;;; フォントの設定

;;; 等幅フォントにする
;;; http://macemacsjp.sourceforge.jp/index.php?CocoaEmacs#j9873729
;;; 注: Osaka等幅フォントになるように，アプリケーション→Font Book→Osakaレギュラー
;;;     を選択し右クリックで「使用停止」して“切”で使う必要がある
;;;     https://www.yokoweb.net/2017/01/23/emacs-fontsize-screensize/
(set-default-font
 "-*-Osaka-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
;; 新しいフレームを作ったときに同じフォントを使う
(setq frame-inherited-parameters '(font tool-bar-lines))

;; サイズは大きいが等幅フォントで使える
;; http://d.hatena.ne.jp/kazu-yamamoto/20140625/1403674172
;;
;; 以下が Mac 用のフォント設定
; (when (memq window-system '(mac ns))
;   (global-set-key [s-mouse-1] 'browse-url-at-mouse)
;   (let* ((size 14)
; 	 (jpfont "Hiragino Maru Gothic ProN")
; 	 (asciifont "Monaco")
; 	 (h (* size 10)))
;     (set-face-attribute 'default nil :family asciifont :height h)
;     (set-fontset-font t 'katakana-jisx0201 jpfont)
;     (set-fontset-font t 'japanese-jisx0208 jpfont)
;     (set-fontset-font t 'japanese-jisx0212 jpfont)
;     (set-fontset-font t 'japanese-jisx0213-1 jpfont)
;     (set-fontset-font t 'japanese-jisx0213-2 jpfont)
;     (set-fontset-font t '(#x0080 . #x024F) asciifont))
;   (setq face-font-rescale-alist
; 	'(("^-apple-hiragino.*" . 1.2)
; 	  (".*-Hiragino Maru Gothic ProN-.*" . 1.2)
; 	  (".*osaka-bold.*" . 1.2)
; 	  (".*osaka-medium.*" . 1.2)
; 	  (".*courier-bold-.*-mac-roman" . 1.0)
; 	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
; 	  (".*monaco-bold-.*-mac-roman" . 0.9)
; 	  ("-cdac$" . 1.3)))
;   ;; C-x 5 2 で新しいフレームを作ったときに同じフォントを使う
;   (setq frame-inherited-parameters '(font tool-bar-lines)))


;;; 綺麗ではあるが等幅フォントの設定がうまくいかなかったので無効化
;(when (>= emacs-major-version 23)
;  (setq fixed-width-use-QuickDraw-for-ascii t)
;  (setq mac-allow-anti-aliasing t)
;  (set-face-attribute 'default nil
;					  :family "monaco"
;					  :height 120)
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'japanese-jisx0208
;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'japanese-jisx0212
;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'katakana-jisx0201
;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;  ;; Unicode フォント
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'mule-unicode-0100-24ff
;   '("monaco" . "iso10646-1"))
;  ;; キリル，ギリシア文字設定
;  ;; 注意： この設定だけでは古代ギリシア文字、コプト文字は表示できない
;  ;; http://socrates.berkeley.edu/~pinax/greekkeys/NAUdownload.html が必要
;  ;; キリル文字
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'cyrillic-iso8859-5
;   '("monaco" . "iso10646-1"))
;  ;; ギリシア文字
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'greek-iso8859-7
;   '("monaco" . "iso10646-1"))
;  (setq face-font-rescale-alist
;		'(("^-apple-hiragino.*" . 1.2)
;		  (".*osaka-bold.*" . 1.2)
;		  (".*osaka-medium.*" . 1.2)
;		  (".*courier-bold-.*-mac-roman" . 1.0)
;		  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;		  (".*monaco-bold-.*-mac-roman" . 0.9)
;		  ("-cdac$" . 1.3))))

;;; 以下の設定は英字が等幅にならない問題を除けば使用可能
; ;;; フォントの設定(日本語イタリック体が表示されない対策)
; ;;; http://mugijiru.seesaa.net/article/273281731.html
; (let* ((size 12)
;          (asciifont "Menlo")
;          (jpfont "Hiragino Maru Gothic ProN")
;          (h (* size 10))
;          (fontspec)
;          (jp-fontspec))
; 	(set-face-attribute 'default nil :family asciifont :height h)
;     (setq fontspec (font-spec :family asciifont))
;     (setq jp-fontspec (font-spec :family jpfont))
;     (set-fontset-font nil 'japanese-jisx0208 jp-fontspec)
;     (set-fontset-font nil 'japanese-jisx0212 jp-fontspec)
;     (set-fontset-font nil 'japanese-jisx0213-1 jp-fontspec)
;     (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
;     (set-fontset-font nil '(#x0080 . #x024F) fontspec)
;     (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
;  
; ;; 半角カナをヒラギノ角ゴProNにする
; (set-fontset-font "fontset-default"
; 				  'katakana-jisx0201
; 				  '("Hiragino Maru Gothic ProN"))

;;; フレームの設定
;;; (何故か初期化時のフレームの位置がずれるので，default-frame-alist と
;;;  initial-frame-alist でフレーム位置を微調整)
(setq default-frame-alist
					(append (list
							 '(height	. 59)
							 '(width	. 99)
							 '(top		. 0)
							 '(left		. 0)
;;; 色はカラーテーマに任せる
;							 '(foreground-color . "white")
;							 '(background-color . "black")
;							 '(cursor-color . "turquoise3")
							 )))
(setq initial-frame-alist 
					(append (list
							 '(height	. 58)
							 '(width	. 99)
							 '(top		. 29)
							 '(left		. 4)
;;; 色はカラーテーマに任せる
;							 '(foreground-color . "white")
;							 '(background-color . "black")
;							 '(cursor-color . "turquoise3")
							 )))
