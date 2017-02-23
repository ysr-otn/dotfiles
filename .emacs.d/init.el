;;; debug ����
(setq debug-on-error t)

;;; PATH ����
(setq load-path
      (append
       (list
		(substitute-in-file-name "$HOME/.emacs.d/init")
		(substitute-in-file-name "$HOME/.emacs.d/elisp/misc")
		)
       load-path))

;;; info �ե����������
(add-to-list 'Info-default-directory-list "~/.emacs.d/info")

;;; ������ե�����Υ⡼�ɻ���
(setq auto-mode-alist
      (append
       '(("init$"				. emacs-lisp-mode)	; emacs ����ե�����
		 ("init-private$"		. emacs-lisp-mode)	; emacs �Ŀ�������ե�����
		 ("\.src$"				. asm-mode)			; ������֥�ե�����
		 )
       auto-mode-alist))

;;;;;;;;;;;;;;;;;;  ����Ū������ ;;;;;;;;;;;;;;;;;;;;;;;;
;;; tab ��
(setq-default tab-width 4)
;;;ɸ��� fill-column �� 60 ������
(setq-default fill-column 60)
;;; �����ΤȤ���ʸ���Ⱦ�ʸ������̤��ʤ�
(setq case-fold-search nil)
;;; ʸ����ɽ�魯����ɽ��
(setq sentence-end "[.?!][]\"')}]*\\($\\| $\\|	\\|  \\)[ 	\n]*\\|[��������]")
;;; ���ܸ�� dabbrev-expand 
(setq dabbrev-abbrev-char-regexp "\\w\\|\\s_")    
;;;�饤���ֹ��ɽ�� 
(line-number-mode t)
;;; ���ֹ��ɽ��
(column-number-mode t)
;;; ��ʬ�䤵�줿������ɥ��� 200 ��궹��������ɥ��ʤ�������ޤ��֤����ʤ�
(setq truncate-partial-width-windows 200)
;;; yes/no ������ y/n �Ǳ����롥
(fset 'yes-or-no-p 'y-or-n-p)
;; Ĺ���Ԥ��ޤ��֤�ɽ���򤹤롥
(setq-default truncate-lines nil)


;;;;;;;;;;;;;;;;;;;; �������� ;;;;;;;;;;;;;;;;;;;;;;;;
;;; �������
(global-set-key "\C-x\C-c" nil) ; ��äƽ�λ���ʤ��褦��
(global-set-key "\C-x\C-c\C-c" 'save-buffers-kill-emacs)
;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-H" 'backward-delete-char)
(global-set-key "\M-h" 'backward-kill-word)
(define-key esc-map "\C-h" 'backward-kill-word)
(global-set-key "\M-?" 'help-for-help)
(global-set-key "\M-g" 'goto-line)
;; C-z (Emacs �򥢥�����)��̵����
(global-unset-key "\C-z")
;;; ����ѥ���ط�
(global-set-key "\C-cc" 'compile)
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-cp" 'previous-error)
(global-set-key "\C-cg" 'compile-goto-error)
(global-set-key "\C-cm" 'manual-entry)
;;; ά��Ÿ���ط�
(global-set-key "\C-o" 'dabbrev-expand)
(global-set-key "\M-o" 'expand-abbrev)
;;; ��������β��˶��Ԥ������ (C-o �����)
(define-key esc-map "\J" 'open-line)
;;; ���̤β���������
(global-set-key [M-left] 'scroll-right)
(global-set-key [M-right] 'scroll-left)
(global-set-key [(control >)] 'scroll-left)
(global-set-key [(control <)] 'scroll-right)
;;; fill ��Ϣ
(global-set-key "\C-xP" 'fill-paragraph)
(global-set-key "\C-xF" 'fill-region)
;;; M-q (fill-column) ���ѹ�
(global-set-key "\C-xS" 'set-fill-column)
(global-set-key "\C-xR" 'fill-region-as-paragraph)
;;; ���Υ�����ɥ��˰�ư
(global-set-key "\C-q" 'other-window)
;;; C-q ������
(global-set-key "\C-xQ" 'quoted-insert)
;;; C-m �� C-j ��Ʊ���ˤ���
(global-set-key "\C-m" 'newline-and-indent)
;;; shell-mode
(global-set-key "\C-c\C-s" 'shell)
;;; ispell
(global-set-key "\C-c\C-i" 'ispell-complete-word)
;;; isearch-mode �� M-y �� isearch-yank-pop ������
(define-key isearch-mode-map "\M-y" 'isearch-yank-pop)
;;; ��̤��ϰ����Ĵɽ��
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
(set-face-background 'show-paren-match-face "#F0F")
;; �ߥ˥Хåե����������¸����
(savehist-mode 1)
;; �ߥ˥Хåե����������¸�������䤹
(setq history-length 4096)


;;; view-mode
(add-hook
 'view-mode-hook
 '(lambda ()
    (define-key view-mode-map "k" 'View-scroll-line-backward)
    (define-key view-mode-map "j" 'View-scroll-line-forward)
    (define-key view-mode-map "\K" 'View-scroll-half-page-backward)
    (define-key view-mode-map "\J" 'View-scroll-half-page-forward)
    (define-key view-mode-map "p" 'View-scroll-half-page-backward)
    (define-key view-mode-map "n" 'View-scroll-half-page-forward)
    (define-key view-mode-map "b" 'View-scroll-page-backward)
    (define-key view-mode-map " " 'View-scroll-page-forward)
	(define-key view-mode-map "u" 'View-quit)
    (define-key view-mode-map "\E" 'view-mode-exit-with-skk)
	(define-key view-mode-map "\;" 'other-window)
	(define-key view-mode-map "q" 'View-quit)))
(define-key esc-map "V" 'view-mode)
(global-set-key "\C-t" 'transpose-chars)

;;; dired-mode
(add-hook
 'dired-mode-hook
 '(lambda ()
	(global-set-key "\C-x\C-j" 'skk-mode)
	(local-set-key "q" (defun quit-window-with-kill () (interactive)
						 (quit-window t nil)))
	(local-set-key "u" 'dired-up-directory)
	(local-set-key "U" 'dired-unmark)
	(local-set-key "j" 'dired-view-file)
	(local-set-key "r" 'wdired-change-to-wdired-mode)
	(define-key dired-mode-map "i" 'dired-view-file)))

;;; help-mode
(add-hook
 'help-mode-hook
 '(lambda ()
	(local-set-key "q"	'help-quit)))

;; dired-x��Ȥ���
(setq dired-load-hook '(lambda () (load "dired-x")))

;; ! ��default������
(setq dired-guess-shell-alist-user
	  '(("\\.tar\\.gz$" "tar ztvf")
		("\\.\\(g\\|\\)z" "zcat")
		("\\.\\(html\\|HTML\\|htm\\|HTM\\)" "w3m")
		("\\.ps\\.gz$" "gunzip -c | gv")
		("\\.dvi" "xdvi")
		("\\.pdf" "acroread")
		("\\.\\(gif\\|GIF\\|jpg\\|jpeg\\|JPG\\|JPEG\\|tif\\|xpm\\|xbm\\|bmp\\|BMP\\)$" "xv")))


;;; for Info-mode
(add-hook
 'Info-mode-hook
 (lambda ()
   (local-set-key [mouse-3] 'Info-up)
   (local-set-key "k" 'previous-line)
   (local-set-key "j" 'next-line)
   (local-set-key "h" 'backward-char)
   (local-set-key "l" 'forward-char)
   (local-set-key "L" 'Info-last)
   (local-set-key "?" 'Info-help)
   (local-set-key "i" 'Info-scroll-up)
   (local-set-key "I" 'Info-index)
   (local-set-key " " 'scroll-up)
   (local-set-key "b" 'scroll-down)
   (local-set-key "n" 'Info-next-reference)
   (local-set-key "p" 'Info-prev-reference)
   (local-set-key "q" 'Info-up)
   (local-set-key "Q" 'Info-exit)
   (local-set-key "N" 'Info-next)
   (local-set-key "P" 'Info-prev)
   ))


;;; buffer ������
(global-set-key	"\C-x\C-b" 'buffer-menu)
(define-key Buffer-menu-mode-map " " 'Buffer-menu-this-window)
(define-key Buffer-menu-mode-map "k" 'previous-line)
(define-key Buffer-menu-mode-map "j" 'next-line)
(define-key Buffer-menu-mode-map "\C-n" 'next-line)
(define-key Buffer-menu-mode-map "\C-p" 'previous-line)

;;; register
(global-set-key "\M-j"	nil)
(global-set-key "\M-j " 'point-to-register)
(global-set-key "\M-jj" 'jump-to-register)
(global-set-key "\M-jn"	'number-to-register)
(global-set-key "\M-jm" 'bookmark-set)
(global-set-key "\M-jb" 'bookmark-jump)
(global-set-key "\M-jl" 'bookmark-bmenu-list)
(global-set-key "\M-ji" 'insert-register)
(global-set-key "\M-jr" 'copy-rectangle-to-register)
(global-set-key "\M-jt" 'string-rectangle)
(global-set-key "\M-jx" 'copy-to-register)
(global-set-key "\M-jc" 'clear-rectangle)
(global-set-key "\M-jk" 'kill-rectangle)
(global-set-key "\M-jd" 'delete-rectangle)
(global-set-key "\M-jy" 'yank-rectangle)
(global-set-key "\M-jo" 'open-rectangle)
(global-set-key "\M-jw" 'window-configuration-to-register)
(global-set-key "\M-jf" 'frame-configuration-to-register)


;;; ά���䴰
;; ��Ūά���䴰����ե�����
(setq abbrev-file-name (substitute-in-file-name "$HOME/.emacs.d/abbrev_defs.el"))
;; �ե�����򳫤�������Ūά���䴰�⡼�ɤ���ư�� ON �����Τ��ɤ�
(add-hook 'pre-command-hook
          (lambda ()
            (setq abbrev-mode nil)))
;; ������ʿ��̾��ޤ�ñ����оݤȤ���ưŪά��Ÿ����Ȥ��䤹�����뤿������
;; http://www.sodan.org/~knagano/emacs/dabbrev-20.html
(or (boundp 'MULE)			; Mule2 ��
    (featurep 'xemacs)			; XEmacs ����������
    (let (current-load-list)
      (defadvice dabbrev-expand
		(around modify-regexp-for-japanese activate compile)
		"Modify `dabbrev-abbrev-char-regexp' dynamically for Japanese words."
		(if (bobp)
			ad-do-it
		  (let ((dabbrev-abbrev-char-regexp
				 (let ((c (char-category-set (char-before))))
				   (cond
					((aref c ?a) "[-_A-Za-z0-9]") ; ASCII
					((aref c ?j)	; Japanese
					 (cond
					  ((aref c ?K) "\\cK") ; katakana
					  ((aref c ?A) "\\cA") ; 2byte alphanumeric
					  ((aref c ?H) "\\cH") ; hiragana
					  ((aref c ?C) "\\cC") ; kanji
					  (t "\\cj")))
					((aref c ?k) "\\ck") ; hankaku-kana
					((aref c ?r) "\\cr") ; Japanese roman ?
					(t dabbrev-abbrev-char-regexp)))))
			ad-do-it)))))

;;; �Хå����åץե�����λ���
(setq backup-by-copying t) 
(fset 'make-backup-file-name
      '(lambda (file)
		 (concat (substitute-in-file-name "$HOME/.emacs.d/backup/")
				 (file-name-nondirectory file))))
(setq auto-save-list-file-prefix  (substitute-in-file-name "$HOME/.emacs.d/auto-save/auto-save"))

;;; buffer-name ɽ��
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;;; ���ߤδؿ�̾��⡼�ɥ饤���ɽ��
(which-function-mode t)

;;; �б������̤���餻��
(show-paren-mode t)

;;; sticky key map
(defvar sticky-key ";")
(defvar sticky-list
  '(("a" . "A")("b" . "B")("c" . "C")("d" . "D")("e" . "E")("f" . "F")("g" . "G")
    ("h" . "H")("i" . "I")("j" . "J")("k" . "K")("l" . "L")("m" . "M")("n" . "N")
    ("o" . "O")("p" . "P")("q" . "Q")("r" . "R")("s" . "S")("t" . "T")("u" . "U")
    ("v" . "V")("w" . "W")("x" . "X")("y" . "Y")("z" . "Z")
    ("1" . "!")("2" . "@")("3" . "#")("4" . "$")("5" . "%")("6" . "^")("7" . "&")
    ("8" . "*")("9" . "(")("0" . ")")
    ("`" . "~")("[" . "{")("]" . "}")("-" . "_")("=" . "+")("," . "<")("." . ">")
    ("/" . "?")(";" . ":")("'" . "\"")("\\" . "|")
    ))

(defvar sticky-map (make-sparse-keymap))
(define-key global-map sticky-key sticky-map)
(mapcar (lambda (pair)
          (define-key sticky-map (car pair)
            `(lambda()(interactive)
               (setq unread-command-events
                     (cons ,(string-to-char (cdr pair)) unread-command-events)))))
        sticky-list)
(define-key sticky-map sticky-key '(lambda ()(interactive)(insert sticky-key)))

;; SKK �ɤ߹��߸�� sticky-map ������
;; (eval-after-load ��Ȥ������Ȳ��Τ���꤯�Ԥ��ʤ��ä��Τ� add-hook ��Ȥ��褦���ѹ�
(add-hook 'skk-mode-hook
          (lambda ()
            (progn
              (define-key skk-j-mode-map sticky-key sticky-map)
              (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
              (define-key skk-abbrev-mode-map sticky-key sticky-map)
              )
            ))
;(eval-after-load "skk"
;  '(progn
;     (define-key skk-j-mode-map sticky-key sticky-map)
;     (define-key skk-jisx0208-latin-mode-map sticky-key sticky-map)
;     (define-key skk-abbrev-mode-map sticky-key sticky-map)))

;; skk-isearch �ΤȤ��� sticky-map ��������������顼���Ф뤷�ä�����̵���Τ�
;; �����ȥ�����(eval-after-load ��ȤäƤ�Ⱦ��Ʊ�ͤ˾�꤯�����ʤ����⤷��ʤ�����)
;(eval-after-load "skk-isearch"
;				'(define-key skk-isearch-mode-map sticky-key sticky-map))


;;; ����ɽ��
;; ���׹��������ߥ� 1 ��
(setq display-time-interval 1)
;; ���ץե����ޥå��ѹ�
(setq display-time-string-forms
	  '((format " %s/%s/%s(%s)%s:%s:%s"
				year month day dayname
				24-hours minutes seconds
				)))
;; ����ɽ�� ON
(display-time)

;; �������ȥ��å���ɽ��
(setq inhibit-startup-screen t)

;; scratch�ν����å������õ�
(setq initial-scratch-message "")

;;; ediff��1������ɥ��Ǽ¹�
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; emacsclient �ΰ٤Υ����Ф�ư
(require 'server)
(unless (server-running-p)
  (server-start))

;;; load init file for each version emacs
(load (concat (substitute-in-file-name "$HOME/.emacs.d/init-")
			  (number-to-string emacs-major-version)
			  ".el"))

;;; load init file for each systems
(cond ((eq system-type 'darwin)
	   (load "init-darwin.el"))
	  ((eq system-type 'windows-nt)
	   (load "init-windows-nt.el"))
	  )

;;; load init file for window systems
(cond ((eq window-system 'mac)
	   (load "init-window-system-mac.el"))
	  ((eq window-system 'ns)	;; Emacs frame on a GNUstep or Macintosh Cocoa display,
	   (load "init-window-system-ns.el"))
	  )


;;;;;;;;;;;;;;;;;;; package ���� ;;;;;;;;;;;;;;;;;;;
;;; http://emacs-jp.github.io/packages/package-management/package-el.html
(require 'package)
;; MELPA���ɲ�
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Marmalade���ɲ�(���դ���ʤ��Τ�̵����)
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
;; www.e6h.org���ɲ�(���դ���ʤ��Τ�̵����)
;;(add-to-list 'package-archives	'("e6h" . "http://www.e6h.org/packages/") t)
;; �����
(package-initialize)

;;; �Ƽ�ѥå���������ι���
(package-refresh-contents)

;;; ���󥹥ȡ��뤹��ѥå������Υꥹ��
(defvar my/favorite-packages
    '(
	  ;; helm
	  helm ac-helm helm-ag helm-c-yasnippet helm-gtags helm-projectile helm-swoop
	  
	  ;; ace-jump
	  ace-jump-mode	ace-pinyin	ace-window
	  
	  ;; search tools
	  ag google-translate migemo wgrep wgrep-ag 
	  
	  ;; buffer/window control tools
	  elscreen minibuf-isearch minimap point-undo popup popwin session highlight-symbol
	  
	  ;; misc
	  anzu god-mode multiple-cursors undo-tree undohist
	  
	  ;; auto-complete
	  auto-complete auto-complete-clang-async
	  
	  ;; skk
	  ddskk
	  
	  ;; howm
	  howm
	  
	  ;; web tools
	  mew navi2ch search-web semi w3m wanderlust
	  
	  ;; developmemt tools
	  e2wm emr flycheck ggtags projectile yasnippet
	  
	  ;;  proglaming language tools
	  erlang
	  ))

;; ���󥹥ȡ��뤵��Ƥ��ʤ��ѥå�����������Х��󥹥ȡ���
(dolist (package my/favorite-packages)
    (unless (package-installed-p package)
	      (package-install package)))


;;;; �Ƽ�饤�֥�������

;;; for mylisp
(load "mylisp.el")

;;; for text-adjust
(load "text-adjust.el")

;;; for dmacro
(load "init-dmacro.el")

;;; for elscreen
(load "init-elscreen.el")

;;; for w3m
(load "init-w3m.el")

;;; for ddskk
(load "init-ddskk.el")

;;; for migemo(Windos �Ķ���̤��ư��ʤ��Τ�̵����)
(if (null (eq system-type 'windows-nt))
	(load "init-migemo.el"))

;;; for navi2ch
(load "init-navi2ch.el")

;;; for session
(load "init-session.el")

;;; for minibuf-isearch
;; �����ط��� helm ���������礹��Τ�̵����(2015/02/23)
;; (load "init-minibuf-isearch.el")

;;; for mew
(load "init-mew.el")

;;; for wanderlust
(load "init-wanderlust.el")

;;; for auto-install
;; �ȤäƤʤ��Τ�̵����(2015/02/23)
;(load "init-auto-install.el")

;;; for windows
(load "init-windows.el")

;;; for howm
(load "init-howm.el")

;;; for mpg123
(load "init-mpg123.el")

;;; for browse-kill-ring
;;; (helm-show-kill-ring �� session �Ȥ������ǥ��顼��ȯ������Τ� 
;;;  ���� browse-kill-ring ����Ѥ���) �� ��ä����Τ� browse-kill-ring ��̵����
;(load "init-browse-kill-ring.el")

;;; for helm
(load "init-helm.el")

;;; for helm-swoop
(load "init-helm-swoop.el")

;;; for helm-gtags
(load "init-helm-gtags.el")

;;; for ag
(load "init-ag.el")

;;; for smooth-scroll
; C-v, M-v �ˤ�륹�����뤬�٤�����Τ�̵����
;(load "init-smooth-scroll.el")

;;; for popwin
(load "init-popwin.el")

;;; for search-web
(load "init-search-web.el")

;;; for ace-jump
(load "init-ace-jump.el")

;;; for auto-complete
(load "init-auto-complete.el")

;;; for yasnippet
(load "init-yasnippet.el")

;;; for cc-mode
(load "init-cc-mode.el")

;;; for auto-complete-clang-async
(load "init-auto-complete-clang-async.el")

;;; for ggtags
(load "init-ggtags.el")

;;; for VC
(load "init-vc.el")

;;; for flycheck(Windos �Ķ���̤��ư��ʤ��Τ�̵����)
(if (null (eq system-type 'windows-nt))
	(load "init-flycheck.el"))

;;; for undo-tree
(load "init-undo-tree.el")

;;; for undohist
(load "init-undohist.el")

;;; for point-undo
(load "init-point-undo.el")

;;; for volatile-highlights
(load "init-volatile-highlights.el")

;;; for projectile
(load "init-projectile.el")

;;; for wgrep
(load "init-wgrep.el")

;;; for anzu
(load "init-anzu.el")

;;; for multiple-cursors
(load "init-multiple-cursors.el")

;;; for e2wm
(load "init-e2wm.el")

;;; for god-mode
;;; �������Τ�̵����
;(load "init-god-mode.el")

;;; for emacs-refactor
(load "init-emr.el")

;;; for minimap
(load "init-minimap.el")

;;; for srefactor
;;; helm-imenu ����ư���Τ�̵����
;(load "srefactor.el")

;;; for erlang-mode
(load "init-erlang.el")

;;; for google-translate
(load "init-google-translate.el")

;;; for highlight-symbol
(load "init-highlight-symbol.el")

;;; for org-mode
(load "init-org-mode.el")

;;; mode-line setting
;; ���Τ� elscreen ����������˼¹Ԥ���ȥ��顼���Ǥ�ΤǤ��θ��˰�ư
(setq-default mode-line-format
              '("-"
                mode-line-mule-info
                mode-line-modified
                mode-line-frame-identification
                mode-line-buffer-identification
                ""
                (line-number-mode "L%l-")
                (column-number-mode "C%c-")
                (-3 . "%p")
				" "
                global-mode-string
                " %[("
                mode-name
                mode-line-process
                minor-mode-alist
                "%n" ")%]-"
                (which-func-mode ("" which-func-format "-"))
                "-%-")
              )
