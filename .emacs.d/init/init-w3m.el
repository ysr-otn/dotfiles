(autoload 'w3m "w3m" "*Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "*w3m interface function for local file." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "*Search QUERY using SEARCH-ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "*Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "*Report chenge of WEB sites." t)


(setq w3m-type 'w3m-mnc) ;;; mnc patch を使用した w3m を使用
(setq w3m-bookmark-file "~/.w3m/bookmark.html")
(setq w3m-weather-default-area "大阪府")
(setq w3m-search-default-engine "duckduckgo")
;(setq w3m-home-page "file:///home/ysr-otn/.mozilla/ysr-otn/41an8pij.slt/bookmarks.html")
(setq w3m-home-page "https://duckduckgo.com/?t=hk")

(setq w3m-display-inline-image nil)
;(setq w3m-type 'w3m-mnc)
;(setq w3m-use-form t)
(setq w3m-antenna-sites 
	  '(("https://a.hatena.ne.jp/category?c=c" "はてなアンテナ > コンピュータ")
		("https://2chmatomeru.info/" "2ちゃんねる まとめるまとめ")
		("http://matome100.com/" "まとめアンテナ 100")))
;(setq w3m-icon-directory (substitute-in-file-name "$EMACS_SITE_LISP/w3m/icons"))

(setq w3m-mode-hook
      '(lambda () "w3mモードのデフォルト"
		 (define-key w3m-mode-map "i"	'w3m-view-this-url)
		 (define-key w3m-mode-map "v"	'w3m-view-image)
		 (define-key w3m-mode-map "V"	'w3m-bookmark-view)
		 (define-key w3m-mode-map "I"	'w3m-view-this-url-new-session)
         (define-key w3m-mode-map "n"	'w3m-next-anchor)
		 (define-key w3m-mode-map "p"	'w3m-previous-anchor)
		 (define-key w3m-mode-map "\;"	'w3m-history-restore-position)
		 (define-key w3m-mode-map "u"	'w3m-view-previous-page)
		 (define-key w3m-mode-map "q"	'w3m-view-previous-page)
		 (define-key w3m-mode-map "B"	'w3m-view-previous-page)
		 (define-key w3m-mode-map "y"	'w3m-view-next-page)
		 (define-key w3m-mode-map "F"	'w3m-view-next-page)
		 (define-key w3m-mode-map "\C-o" 'w3m-goto-url)
		 (define-key w3m-mode-map "o"	'w3m-find-file)
		 (define-key w3m-mode-map "U"	'w3m-print-this-url)
		 (define-key w3m-mode-map "l"	'forward-char)
		 (define-key w3m-mode-map "h"	'backward-char)
		 (define-key w3m-mode-map "j"	'next-line)
		 (define-key w3m-mode-map "k"	'previous-line)
		 (define-key w3m-mode-map [S-return]	'w3m-view-url-with-browse-url)
		 (define-key w3m-mode-map [mouse-3]		'w3m-view-previous-page)
		 (define-key w3m-mode-map [S-mouse-3]	'w3m-view-next-page)
		 ;;  emacs-w3m で DuckDuckGo が文字化けする対策
         ;; https://www.reddit.com/r/emacs/comments/vdmed9/charset_issue_with_emacsw3m/
		 (setq w3m-encoding-alist
			   (nconc w3m-encoding-alist
					  '(("br" . brotli))))
		 (setq w3m-decoder-alist
			   (nconc w3m-decoder-alist
					  '((brotli "brotli" ("-d")))))
         ))

;;; Wanderlust の mime-mode で w3m を使用する時のキー設定
(setq w3m-minor-mode-hook
      '(lambda () 
		 (define-key w3m-minor-mode-map [S-return]	'w3m-view-url-with-browse-url)
         ))

(setq w3m-use-cookies t)


;;; for shimbun
;(setq shimbun-encapsulate-images nil)
