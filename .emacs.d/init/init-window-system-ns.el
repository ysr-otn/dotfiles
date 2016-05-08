;; ���ܸ�������UTF-8��
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; ���ܸ�IM�Ѥ������inline_patch �����ƤƤ��뤳�Ȥ�����
(setq default-input-method "MacOSX")


;;; ���֡����Ѷ��򡤲��Ԥ����ˤ��륹�ڡ�������ӥ��֤�Ĵɽ��
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

;;; default-frame-alist �ȡ��ʲ���ξ�����ꤷ�Ƥ���ɬ�פ����롥
(set-foreground-color "white")
(set-background-color "black")
(set-cursor-color "turquoise3")


;;;����¾�ο�������
(set-mouse-color "black")
(set-border-color "red")
(set-face-background 'highlight "Navy")
(set-face-background 'region "Navy")
(set-face-background 'secondary-selection "white")

;;; �ե���Ȥ�����
;;; �����ե���Ȥˤ���
;;; http://macemacsjp.sourceforge.jp/index.php?CocoaEmacs#j9873729
(set-default-font
 "-*-Osaka-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")


;;; ���ǤϤ��뤬�����ե���Ȥ����꤬���ޤ������ʤ��ä��Τ�̵����
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
;  ;; Unicode �ե����
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'mule-unicode-0100-24ff
;   '("monaco" . "iso10646-1"))
;  ;; ����롤���ꥷ��ʸ������
;  ;; ��ա� ������������Ǥϸ��奮�ꥷ��ʸ�������ץ�ʸ����ɽ���Ǥ��ʤ�
;  ;; http://socrates.berkeley.edu/~pinax/greekkeys/NAUdownload.html ��ɬ��
;  ;; �����ʸ��
;  (set-fontset-font
;   (frame-parameter nil 'font)
;   'cyrillic-iso8859-5
;   '("monaco" . "iso10646-1"))
;  ;; ���ꥷ��ʸ��
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

;;; �ʲ�������ϱѻ��������ˤʤ�ʤ����������л��Ѳ�ǽ
; ;;; �ե���Ȥ�����(���ܸ쥤����å��Τ�ɽ������ʤ��к�)
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
; ;; Ⱦ�ѥ��ʤ�ҥ饮�γѥ�ProN�ˤ���
; (set-fontset-font "fontset-default"
; 				  'katakana-jisx0201
; 				  '("Hiragino Maru Gothic ProN"))

;;; �ե졼�������
(setq default-frame-alist
					(append (list
							 '(height	. 60)
							 '(width	. 100)
							 '(top		. 0)
							 '(left		. 0)
							 '(foreground-color . "white")
							 '(background-color . "black")
							 '(cursor-color . "turquoise3")
							 )))
