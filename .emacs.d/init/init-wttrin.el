;;; 天気予報取得サービス wttr.in を用いてコマンドラインで天気を取得する機能を
;;; 用いて Emacs 上から天気予報を取得
;;; https://github.com/bcbcarl/emacs-wttrin

;;; デフォルトの都市を設定
(setq wttrin-default-cities '("Osaka"))

;;; 日本語の設定
(setq wttrin-default-accept-language '("Accept-Language" . "ja"))

(eval-after-load "wttrin"
  '(progn
	 ;; Emacs の日本語環境下で全角でで表示される記号を半角の文字で置き換えるように
	 ;; wttrin-fetch-raw-string を上書き
	 (defun wttrin-fetch-raw-string (query)
	   "Get the weather information based on your QUERY."
	   (let ((url-user-agent "curl"))  
		 (add-to-list 'url-request-extra-headers wttrin-default-accept-language)
		 (s-replace-all '(("─" . "-") 
						  ("│" . "|")
						  ("┌" . "+")
						  ("┐" . "+")
						  ("┘" . "+")
						  ("└" . "+")
						  ("├" . "+")
						  ("┬" . "+")
						  ("┤" . "+")
						  ("┴" . "+")
						  ("┼" . "+")
						  ("―" . "-")
						  ("‘" . "`")
						  ("’" . "'")
						  ("°C" . "℃")
						  ("↓" . "v")
						  ("↙" . ",")
						  ("←" . "<")
						  ("↖" . "`")
						  ("↑" . "^")
						  ("↗" . "/")
						  ("→" . ">")
						  ("↘" . "\\"))
						(with-current-buffer
							(url-retrieve-synchronously
							 (concat "http://wttr.in/" query)
							 (lambda (status) (switch-to-buffer (current-buffer))))
						  (decode-coding-string (buffer-string) 'utf-8)))))))
