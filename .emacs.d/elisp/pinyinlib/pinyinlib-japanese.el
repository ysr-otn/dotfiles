;;; 文字コード別の変換テーブルをロード
(load "pinyinlib-japanese-euc-jp")
(load "pinyinlib-japanese-utf-8")
(load "pinyinlib-japanese-sjis")

;;; オリジナルの ace-pinyin の pinyinlib-build-regexp-char を日本語変換用に置き換え
(defun pinyinlib-build-regexp-char
    (char &optional no-punc-p tranditional-p only-chinese-p)
  (let ((diff (- char ?a))
        regexp)
    (if (or (>= diff 26) (< diff 0))
        (or (and (not no-punc-p)
                 (assoc-default
                  char
                  pinyinlib--punctuation-alist))
            (regexp-quote (string char)))
      (setq regexp
            (nth diff
                 ;;; カレントバッファの文字コードに応じて変換テーブルを切り替え
				 (case buffer-file-coding-system
				   ((utf-8 utf-8-unix utf-8-mac utf-8-dos)
					pinyinlib--japanese-char-table-utf-8)
				   ((japanese-iso-8bit japanese-iso-8bit-unix japanese-iso-8bit-mac japanese-iso-8bit-dos
					 euc-jp euc-jp-unix euc-jp-mac euc-jp-dos)
					pinyinlib--japanese-char-table-euc-jp)
				   ((japanese-shift-jis japanese-shift-jis-unix japanese-shift-jis-mac japanese-shift-jis-dos)
					pinyinlib--japanese-char-table-sjis))))
	  (if only-chinese-p
          (if (string= regexp "")
              regexp
            (format "[%s]" regexp))
        (format "[%c%s]" char
                regexp)))))
