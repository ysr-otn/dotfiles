(autoload 'navi2ch "navi2ch" nil t)

;;; *bbstable の URL
(setq navi2ch-list-bbstable-url "http://azlucky.s25.xrea.com/2chboard/bbsmenu.html")
;(setq navi2ch-list-bbstable-url "http://www6.ocn.ne.jp/~mirv/bbstable.html")
;(autoload 'navi2ch-browse-url "navi2ch" nil t)
;(setq navi2ch-browse-url-browser-function 'w3m-browse-url)
;(setq browse-url-browser-function 'navi2ch-browse-url)



(add-hook 'navi2ch-list-mode-hook
		  '(lambda ()
			 (define-key navi2ch-list-mode-map "\C-o" 'navi2ch-goto-url)
			 ))
			
(add-hook 'navi2ch-board-mode-hook
		  '(lambda ()
			 (define-key navi2ch-board-mode-map "\;" 'other-window)
			 (define-key navi2ch-board-mode-map "\'" 'delete-other-windows)
			 (define-key navi2ch-board-mode-map "\C-o" 'navi2ch-goto-url)
			 ))

(add-hook 'navi2ch-popup-article-mode-hook
		  '(lambda ()
			 (define-key navi2ch-popup-article-mode-map [mouse-3] 'navi2ch-popup-article-exit)
			 (define-key navi2ch-popup-article-mode-map "o" 'navi2ch-popup-article-exit)
			 ))

(add-hook 'navi2ch-article-mode-hook
		  '(lambda ()
			 (define-key navi2ch-article-mode-map "B" 'navi2ch-article-backward-buffer)
			 (define-key navi2ch-article-mode-map "F" 'navi2ch-article-forward-buffer)
			 (define-key navi2ch-article-mode-map "b" 'navi2ch-article-scroll-down)
			 (define-key navi2ch-article-mode-map "j" 'scroll-one-line-up)
			 (define-key navi2ch-article-mode-map "k" 'scroll-one-line-down)
			 (define-key navi2ch-article-mode-map "l" 'accel-forward-char)
			 (define-key navi2ch-article-mode-map "h" 'accel-backward-char)
			 (define-key navi2ch-article-mode-map "o" 'navi2ch-article-pop-point)
			 (define-key navi2ch-article-mode-map "\;" 'other-window)
			 (define-key navi2ch-article-mode-map "i" 'navi2ch-article-select-current-link)
			 (define-key navi2ch-article-mode-map "H" 'navi2ch-article-toggle-hide)
			 (define-key navi2ch-article-mode-map "\C-o" 'navi2ch-goto-url)
			 (define-key navi2ch-article-mode-map [mouse-3] 'navi2ch-article-pop-point)
			 (define-key navi2ch-article-mode-map [mouse-5] 'navi2ch-article-next-message)
			 (define-key navi2ch-article-mode-map [mouse-4] 'navi2ch-article-previous-message)
			 (define-key navi2ch-article-mode-map [M-mouse-4] 'down-slightly)
			 (define-key navi2ch-article-mode-map [M-mouse-5] 'up-slightly)
			 ))



(cond 
 ;;; emacs-21 以降のときは navi2ch で mona フォントを使用する
 ;;; http://navi2ch.sourceforge.net/doc/navi2ch/How-to-Use-Mona-Font.html
 ((>= (string-to-number emacs-version) 21)
  (require 'navi2ch-mona)
  (add-hook 'navi2ch-article-arrange-message-hook
			'navi2ch-mona-arrange-message)
  (setq navi2ch-mona-enable t)
  (setq navi2ch-mona-disable-board-list '("unix" "linux" "network"))
  ;;; navi2ch 1.7.5 は OK だったけど 20070423 で以下のコードでエラーが出たので解除
  ;(navi2ch-add-replace-html-tag (navi2ch-string-as-multibyte "\372D") "v")
  ;(navi2ch-add-replace-html-tag (navi2ch-string-as-multibyte "\372ｱ") "崎") 
  ))


(setq navi2ch-history-max-line nil) ; 履歴の表示行制限無し



;(setq navi2ch-board-enable-readcgi nil
;      navi2ch-board-use-subback-html nil)
;(setq navi2ch-board-enable-readcgi nil
;      navi2ch-board-use-subback-html t)
;(setq navi2ch-board-enable-readcgi t)

;(setq navi2ch-enable-readcgi nil)
;(setq navi2ch-enable-readcgi t)
