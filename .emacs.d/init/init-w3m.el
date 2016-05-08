(autoload 'w3m "w3m" "*Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "*w3m interface function for local file." t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "*Search QUERY using SEARCH-ENGINE." t)
(autoload 'w3m-weather "w3m-weather" "*Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "*Report chenge of WEB sites." t)


(setq w3m-type 'w3m-mnc) ;;; mnc patch を使用した w3m を使用
(setq w3m-bookmark-file "~/.w3m/bookmark.html")
(setq w3m-weather-default-area "兵庫県・南部")
(setq w3m-search-default-engine "google-ja")
;(setq w3m-home-page "file:///home/ysr-otn/.mozilla/ysr-otn/41an8pij.slt/bookmarks.html")
(setq w3m-home-page "http://www.google.com")

(setq w3m-display-inline-image nil)
;(setq w3m-type 'w3m-mnc)
;(setq w3m-use-form t)
(setq w3m-antenna-sites 
	  '(("http://localhost/~ysr-otn/antenna" "Yshihiro's Antenna" antenna)))
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
		 (define-key w3m-mode-map [mouse-3]		'w3m-view-previous-page)
		 (define-key w3m-mode-map [S-mouse-3]	'w3m-view-next-page)
         ))

(setq w3m-use-cookies t)


;;; for shimbun
;(setq shimbun-encapsulate-images nil)
