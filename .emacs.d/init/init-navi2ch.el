(autoload 'navi2ch "navi2ch" nil t)

;;; *bbstable の URL
(setq navi2ch-list-valid-host-regexp
	  (concat "\\("
			  (regexp-opt '(".2ch.net" ".5ch.net" ".bbspink.com" ".machibbs.com" ".machi.to"))
			  "\\)\\'"))
(setq navi2ch-list-bbstable-url "http://menu.5ch.net/bbsmenu.html")


;(autoload 'navi2ch-browse-url "navi2ch" nil t)
;(setq navi2ch-browse-url-browser-function 'w3m-browse-url)
;(setq browse-url-browser-function 'navi2ch-browse-url)


;;; dat アクセスのために 2chproxy.pl をプロキシに設定
;(setq navi2ch-net-http-proxy "127.0.0.1:8080")
(setq navi2ch-net-http-proxy "localhost:9080")

;;; ファイル受信に GZIP エンコーディングを使わない
(setq navi2ch-net-accept-gzip nil)

;;; HTTP/1.1 を使用する
(setq navi2ch-net-enable-http11 t)


;;; navi2ch 実行時に 2chproxy.pl の過去のプロセスとファイルを削除して 2chproxy.pl を実行
; (add-hook 'navi2ch-load-hook
; 		  '(lambda ()
; 			 (progn
; 			   (start-process "proxy2ch" "*proxy2ch*" (substitute-in-file-name "$HOME/Tools/share/bin/proxy2ch") "-s" "--chunked" "--api" "a6kwZ1FHfwlxIKJWCq4XQQnUTqiA1P:ZDzsNQ7PcOOGE2mXo145X6bt39WMz6" "--api-server" "api.5ch.net" "--api-auth-xua" "\"JaneStyle/4.23\"" "--api-dat-xua" "\"JaneStyle/4.23\"" "-a" "\"Monazilla/1.00 JaneStyle/4.23 Windows/10.0.22000\""))
; 			   ))

;;; navi2ch 終了時に proxy2ch を終了
; (add-hook 'navi2ch-exit-hook
; 		  '(lambda ()
; 			 (shell-command-to-string "kill -9 `ps aux | grep proxy2ch | grep -v grep | awk '{print $2}'`")))


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

 ;;; 書き込みは 2chproxy.pl 経由をせずに直接行う
(setq navi2ch-net-send-message-use-http-proxy nil)


;(setq navi2ch-board-enable-readcgi nil
;      navi2ch-board-use-subback-html nil)
;(setq navi2ch-board-enable-readcgi nil
;      navi2ch-board-use-subback-html t)
;(setq navi2ch-board-enable-readcgi t)

;(setq navi2ch-enable-readcgi nil)
;(setq navi2ch-enable-readcgi t)
