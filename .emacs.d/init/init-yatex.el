;;; 環境毎の LaTeX コマンド，及びその PATH の設定
  (cond ((string= (getenv "HOSTTYPE") "linux")
		 (progn
		   
		   ))
		((string= (getenv "HOSTTYPE") "windows")
		 (progn
		   ))
		(t
		 (progn
		   (setq tex-command "platex")
		   (setenv "PATH"
				   (concat (substitute-in-file-name "/Library/TeX/texbin/:")
						   (getenv "PATH")))
		   )))

		
;;; yatex-mode の設定ファイルの置き場
;(setq YaTeX-user-completion-table (substitute-in-file-name "$HOME/.emacs.d/init/yatex/init"))


;;; yatex-mode/yahtml-mode の設定
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
				("\\.html$" . yahtml-mode)
				("\\.htm$" . yahtml-mode))
			  auto-mode-alist))

(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

;;;;;;;; Yahtml (another html-mode) ;;;;;;
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
; Write your favorite browser.  But netscape is advantageous.
;(setq yahtml-www-browser "mozilla")
; Write correspondence alist from ABSOLUTE unix path name to URL path.
;(setq yahtml-path-url-alist
;      '(("/home/yuuji/public_html" . "http://www.mynet/~yuuji")
;	("/home/staff/yuuji/html" . "http://www.othernet/~yuuji")))
