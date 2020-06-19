;;; ripgrep-regexp に引数で "-E encode" を渡して文字コードを指定した検索を実行
(defun ripgrep-regexp-encode ()
  "Execute ripgrep-regexp with specify encode."
  (interactive)
	    ;;; 正規表現読み込み
  (let ((regexp (read-from-minibuffer "Ripgrep search for: " (thing-at-point 'symbol)))
		;; ディレクトリ読み込み
		(dir (read-directory-name "Directory: "))
		;; エンコード読み込み
		(encode (read-coding-system "Encode: " '("euc-jp" "shift-jis" "japanese-iso-8bit" "utf-8"))))
	;; encode を文字列にしてリストに格納し，ripgrep-regexp を実行
	(ripgrep-regexp regexp dir (list (concat "-E " (symbol-name encode))))))

;;; Emacsから外部プロセスを実行するときのコーディングシステムをカレントバッファに合わせる
(my-adapt-coding-system-with-current-buffer ripgrep-regexp)
