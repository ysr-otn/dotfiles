;;;(一部)自作の Lisp 

;;; 一行ずつの下スクロール
(defun scroll-one-line-up ()
  " 一行ずつの下スクロール"
  (interactive)
  (scroll-up 1))
(global-set-key "\M-z" 'scroll-one-line-up)

;;; 一行ずつの上スクロール
(defun scroll-one-line-down ()
  " 一行ずつの上スクロール"
  (interactive)
  (scroll-up -1))
(global-set-key "\M-Z" 'scroll-one-line-down)

;;; 一つ次の window に移動するか，window が 1 つなら window を横に 2 分割する
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-vertically))
  (other-window 1))
(global-set-key "\C-q" 'other-window-or-split)

;;; 一つ前の window に移動する
(defun pre-window ()
  " 一つ前の window に移動する"
  (interactive)
  (other-window -1))
(global-set-key "\M-q" 'pre-window)


(defun next-line-more ()
  "より下く上に移動"  
  (interactive)
  (next-line 4))
(global-set-key "\M-n" 'next-line-more)
(defun previous-line-more ()
  "より大く上に移動"
  (interactive)
  (previous-line 4))
(global-set-key "\M-p" 'previous-line-more)


;;; load-library で .emacs を読み込む
(defun load-emacs ()
  " load-library で .emacs を読み込む"
  (interactive)
  (load-library "~/.emacs"))
(global-set-key "\C-c\E" 'load-emacs)

;;; view.el を読みこむ
(defun load-view ()
  "view.el を読みこむ"
  (interactive)
  (load-library "/home/ohtani/Tools/FreeBSD/share/emacs/20.3/lisp/view.el"))
(global-set-key "\C-c\V" 'load-view)


;;; dir-ftp の接続先を決めておく
(defconst dir-ftp-usr-name
  "接続先のユーザ名"  "who")
(defconst dir-ftp-macine-name
  "接続先のマシン名"  "hogehoge")
(defconst dir-ftp-domain-name
  "接続先のネットワーク名"  "hoge.or.jp")
(defconst dir-ftp-remorthost-directory
  "接続先のディレクトリ" "/")
(defun dir-ftp ()
  " set-dir-ftpで指定した接続先に ange-ftp で継ぐ"
  (interactive )
  (setq dir-ftp-var
	(concat "/" dir-ftp-usr-name "@" dir-ftp-macine-name
		"." dir-ftp-domain-name
		":" dir-ftp-remorthost-directory))
  (dired dir-ftp-var))
(global-set-key "\C-cd" 'dir-ftp)

(defun set-dir-ftp ()
  " dir-ftp の各種設定"
  (interactive)
  (setq dir-ftp-usr-name
	(read-string "usr-name: " dir-ftp-usr-name))
  (setq dir-ftp-macine-name
	(read-string "macine-name: " dir-ftp-macine-name))
  (setq dir-ftp-domain-name
	(read-string "domain-name: " dir-ftp-domain-name))
  (setq dir-ftp-remorthost-directory
	(read-string "remorthost-directory: " dir-ftp-remorthost-directory))
  (dir-ftp))
(global-set-key "\C-cs" 'set-dir-ftp)  



;;; mew で返信をしたときに fill-column を相手のメールの折り返しに
;;; の長さに合せる．
(defconst mew-header-end-string "----"
  "mew のヘッダの終了を表わす文字列")
(defconst replay-insert-line 0
  "replay のときにメイルの先頭に挿入される文字列の行数")
(defconst max-fill-column 70
  "最大の fill-column 数")
(defconst min-fill-column 35
  "最小の fill-column 数")
(defun set-mew-draft-fill-column ()
" mew の replay で相手のメイルの行の長さによって, fill-column を
変更するようにする. 
 ただし, 長すぎたり短かすぎる場はデファルトの値としてそれぞれ
max-fill-column, min-fill-column を利用する"
  (interactive)
  (setq end (point))
  (beginning-of-buffer)
  (search-forward mew-header-end-string nil t nil)
  (forward-line replay-insert-line)  
  (setq mew-draft-fill-column min-fill-column)
  (while (> end (point))
    (end-of-line)
    (my-set-fill-prefix)
    (setq tmp-fill-column (string-width my-fill-prefix))
    (if (> tmp-fill-column mew-draft-fill-column)
	(setq mew-draft-fill-column tmp-fill-column)
      t)
    (forward-line 1))
  (beginning-of-buffer)
  (search-forward "----" nil t nil)
  (next-line 4)
  ;; 相手のメイルが短かすぎる場合は fill-column は
  ;; max-fill-column を下限とする
  (if (< mew-draft-fill-column min-fill-column)
      (setq fill-column min-fill-column)
    ;; 相手のメイルが長過ぎる場合は fill-column は
    ;; min-fill-column を上限とする
    (if (> mew-draft-fill-column max-fill-column) 
	(setq fill-column max-fill-column)
      (setq fill-column mew-draft-fill-column))))

(defun my-set-fill-prefix ()
  "set-mew-draft-fill-column を利用するための関数"
  (interactive)
  (setq my-fill-prefix (buffer-substring
			(save-excursion (beginning-of-line) (point))
			(point))))

(defun mew-summary-auto-set-fill-column-replay ()
  "実際に set-mew-draft-fill-column を利用する関数"
  (interactive)
  (mew-summary-reply-with-citation)
  (set-mew-draft-fill-column)
  (other-window -1)
  (delete-window)
  (enlarge-window 9))

  



;;; リージョンの先頭に文字列を挿入する
(defvar quoting-marker "> ")
(defun cite-region ()
  "リージョンの先頭に文字列を挿入する"
  (interactive)
  (setq quoting-marker
	(read-string "Quoting marker: " quoting-marker))
  (save-excursion
    (let ((e (max (region-end) (region-beginning)))
	  (b (min (region-end) (region-beginning)))
	  (len (length quoting-marker)))
      (goto-char b)
      (while (<= (+ (point) 1) e)
	(insert-string quoting-marker)
	(setq e (+ e len))
	(forward-line 1)))))
;(global-set-key "\C-c\y" 'cite-region)



;;;cyclic buffer change
(defun get-last-buffer()
" バッファをサイクリックに切り変えることができるようにする"
  (setq lastbuf nil)
  (setq blist (buffer-list))
  (while blist
	(setq name (buffer-name (car blist)))
	(if (string-match "^ " name)
		t              ;;skip minibuffer
	  (setq lastbuf name))
	(setq blist (cdr blist))
	)
  lastbuf)

(defun switch-to-last-buffer-cyclic()
  "Popup last buffer from buffer list, and show it"
  (interactive)
  (switch-to-buffer (get-last-buffer)))
(global-set-key [M-down] 'switch-to-last-buffer-cyclic)
(global-set-key "\C-xn" 'switch-to-last-buffer-cyclic)


(defun get-first-buffer()
  (setq firstbuf nil)
  (setq blist (buffer-list))
  (while blist
	(setq name (buffer-name (car blist)))
	(if (string-match "^ " name)
		(setq blist (cdr blist))
	  (setq firstbuf name)
	  (setq blist nil))
	)
  firstbuf)

(defun switch-to-next-buffer-cyclic()
  "Bury current buffer at bottom of list, and show next one."
  (interactive)
  (bury-buffer (buffer-name))
  (switch-to-buffer (get-first-buffer)))
(global-set-key [M-up] 'switch-to-next-buffer-cyclic)
(global-set-key "\C-xp" 'switch-to-next-buffer-cyclic)




;;; カーソルの左側の単語を大文字にする
(defun upcase-backward-word ()
  "カーソルの左側の単語を大文字にする"
  (interactive)
  (push-mark)
  (backward-sexp)
  (exchange-point-and-mark)
  (upcase-region (point) (mark))
  (pop-mark))
(define-key esc-map "U" 'upcase-backward-word)

;;; カーソルの左側の単語を子文字にする
(defun downcase-backward-word ()
  "カーソルの左側の単語を子文字にする"
  (interactive)
  (push-mark)
  (backward-sexp)
  (exchange-point-and-mark)
  (downcase-region (point) (mark))
  (pop-mark))
(define-key esc-map "u" 'downcase-backward-word)



;;; インデントを行いつつ次の行に移動
(defun indent-and-next-line ()
  (interactive)
  (indent-according-to-mode)
  (next-line 1))
(define-key esc-map "N" 'indent-and-next-line)
;;; インデントを行いつつ前の行に移動
(defun indent-and-previous-line ()
  (interactive)
  (indent-according-to-mode)
  (previous-line 1))
(define-key esc-map "P" 'indent-and-previous-line)
		  



(defun view-mode-exit-with-skk ()
  "view-mode から抜けて編集モードになるとき skk を一緒に起動する"
  (interactive)
  (View-exit-and-edit)
  (skk-mode))



(defun end-of-window-line ()
  "改行がある場合はカーソルのあるラインのウインドの最後に移動"
  (interactive)
  (progn
	(let ((ww (window-width))
		  (cc (current-column))
		  (wc (% (current-column) (1- (window-width)))))
		(let ((window-line-end-diff (- ww wc 2)))
		  (move-to-column (+ cc window-line-end-diff))))))
;(global-set-key "\C-e" 'end-of-window-line)

(defun begin-of-window-line ()
  "改行がある場合はカーソルのあるラインのウインドの先頭に移動"
  (interactive)
  (progn
	(let ((cc (current-column))
		  (wc (% (current-column) (1- (window-width)))))
	  (let ((window-line-begin-diff wc))
		(move-to-column (- cc window-line-begin-diff))))))
;(global-set-key "\C-a" 'begin-of-window-line)

						 
  

(defun move-to-window-prev-line (arg)
  "move window previous line"
  (interactive "p")
  (progn
	(if (equal arg nil)
		(setq arg 1))
	(while (< 0 arg)
	  (let ((cc (current-column))
			(ww (window-width))
			(lw nil)
			(wc (% (current-column) (1- (window-width)))))
		(setq arg (1- arg))
		(if (>= cc (1- ww))
			(move-to-column (1+ (- cc ww)))
		  (progn
			(previous-line 1)
			(end-of-line 1)
			(setq lw (current-column))
			(if (>= lw ww)
				(move-to-column (+ (* (/ lw (1- ww)) (1- ww)) wc))
			  (move-to-column wc))))))))

(defun my-next-line (arg)
  (interactive "p")
  (if (fboundp 'line-move)
	  (line-move arg)
	(if (fboundp 'next-line-internal)
		(next-line-internal arg)
	  (next-line arg))))

(defun move-to-window-next-line (arg)
  "move window next line"
  (interactive "p")
  (progn
	(if (equal arg nil)
		(setq arg 1))
	(while (< 0 arg)
	  (let ((cc (current-column))
			(ww (window-width))
			(lw nil)
			(wc (% (current-column) (1- (window-width)))))
		(setq arg (1- arg))
		(end-of-line 1)
		(setq lw (current-column))
		(if (< (+ cc (1- ww)) lw)
			(move-to-column (+ cc (1- ww)))
		  (progn
			(my-next-line 1)
			(move-to-column (% cc (1- ww)))))))))


;;; Emacs-22 以前は上下カーソル移動が論理行なので物理行移動の対応をしておく
(if (<= (string-to-number emacs-version) 22)
	(progn
	  (define-key global-map "\C-p" 'move-to-window-prev-line)
	  (define-key global-map "\C-n" 'move-to-window-next-line)))
;(define-key global-map [up] 'move-to-window-prev-line)
;(define-key global-map [down] 'move-to-window-next-line)

(defun insert-previous-line-and-indent (arg)
  ""
  (interactive "p")
  (progn
	(if (null arg)
		(setq arg 1))
	(while (< 0 arg)
	  (beginning-of-line 1)
	  (split-line)
	  (setq arg (1- arg)))))
(define-key esc-map "\C-o" 'insert-previous-line-and-indent)


(defun insert-next-line-and-indent (arg)
  ""
  (interactive "P")      
  (progn	
	(if (null arg)
		(setq arg 1))
	(next-line 1)
	(split-line-and-indent arg)))
	  

  




;;;;;;; 対応するかっこに飛んでくれる ;;;;;;; 
(progn
  (defvar com-point nil
	"Remember com point as a marker. \(buffer specific\)")
  (set-default 'com-point (make-marker))
  (defun getcom (arg)
	"Get com part of prefix-argument ARG."
	(cond ((null arg) nil)
		  ((consp arg) (cdr arg))
		  (t nil)))
  (defun paren-match (arg)
	"Go to the matching parenthesis."
	(interactive "P")
	(let ((com (getcom arg)))
	  (if (numberp arg)
		  (if (or (> arg 99) (< arg 1))
			  (error "Prefix must be between 1 and 99.")
			(goto-char
			 (if (> (point-max) 80000)
				 (* (/ (point-max) 100) arg)
			   (/ (* (point-max) arg) 100)))
			(back-to-indentation))
		(cond ((looking-at "[\(\[{]")
			   (if com (move-marker com-point (point)))
			   (forward-sexp 1)
			   (if com
				   (paren-match nil com)
				 (backward-char)))
			  ((looking-at "[])}]")
			   (forward-char)
			   (if com (move-marker com-point (point)))
			   (backward-sexp 1)
			   (if com (paren-match nil com)))
			  (t (error ""))))))
  (define-key ctl-x-map "%" 'paren-match))


;;; 改行するときに行末のスペースを削除しない. 
(defun newline-and-indent-not-delete-space ()
  "newline-and-indent と同じだが, 
改行の際行末の space を削除しない. "
  (interactive "*")
  (newline)
  (indent-according-to-mode))
(global-set-key "\C-m" 'newline-and-indent-not-delete-space)
(global-set-key "\r" 'newline-and-indent-not-delete-space)



;;; 大文字のみを対象にした移動, 削除
(defun forward-word-large-char (arg)
  "次の大文字へ移動"
  (interactive "P")
  (progn
	(if (null arg)
		(setq arg 1))
	(setq case-fold-search nil)
	(re-search-forward "[A-Z]\\(\\>\\)?[a-z1-9]+\\|[A-Z]+\\>" nil t arg)
	(setq case-fold-search t)))
(define-key esc-map "F" 'forward-word-large-char)

(defun backward-word-large-char (arg)
  "前の大文字へ移動"
  (interactive "P")
  (progn
	(if (null arg)
		(setq arg 1))
	(setq case-fold-search nil)
	(re-search-backward "[A-Z]\\(\\<\\)?[a-z1-9]\\|\\<[A-Z]+" nil t arg)
	(setq case-fold-search t)))
(define-key esc-map "B" 'backward-word-large-char)


(defun kill-word-large-char (arg)
  "次の大文字と前の大文字までを削除"
  (interactive "p")
  (kill-region (progn (forward-word-large-char arg) (point))
			   (progn (backward-word-large-char arg) (point))))
(define-key esc-map "D" 'kill-word-large-char)


(defun backward-kill-word-large-char (arg)
  "前の大文字と次の大文字までを削除"
  (interactive "p")
  (kill-region (progn (backward-word-large-char arg) (point))
			   (progn (forward-word-large-char arg) (point))))
(define-key esc-map "H" 'backward-kill-word-large-char)



;;; スペース, 改行, タブを対象にした移動, 削除
(defun forward-space (arg)
  "次のスペース, 改行, タブが無いところへ移動"
  (interactive "p")
  (progn
	(if (null arg)
		(setq arg 1))
	(re-search-forward "[ \n\t]+" nil t arg)))
(global-set-key "\M-l" 'forward-space)


(defun backward-space (arg)
  "前のスペース, 改行, タブが無いところへ移動"
  (interactive "p")
    (progn
	  (if (null arg)
		  (setq arg 1))
	  (re-search-backward "[^ \n\t][ \n\t]+" nil t arg)
	  (forward-char 1)))
(global-set-key "\M-h" 'backward-space)

(defun kill-space (arg)
  "前に向かってスペース, 改行, タブを削除して改行を入れる"
  (interactive "p")
  (if (null arg)
	  (setq arg 1))
  (while (< 0 arg)
	(kill-region (progn (forward-space 1) (point))
				 (progn (backward-space 1) (point)))
	(setq arg (1- arg))))
(global-set-key "\C-x\M-d" 'kill-space)



(defun backward-kill-space (arg)
  "後に向かってスペース, 改行, タブを削除する"
  (interactive "p")
  (if (null arg)
	  (setq arg 1))
  (while (< 0 arg)
	(kill-region (progn (backward-space 1) (point))
				 (progn (forward-space 1) (point)))
	(setq arg (1- arg))))
(global-set-key "\C-x\C-\M-h" 'backward-kill-space)
(global-set-key "\C-x\M-h" 'backward-kill-space)

(defun delete-head-space (arg)
"行の先頭のスペースを削除する. "
  (interactive "p")
  (if (null arg)
	  (setq arg 1))
  (while (< 0 arg)
	(kill-region (progn (begin-of-window-line) (point))
				 (progn (re-search-forward "[ \t]*[^ \t]" nil t 1)
						(backward-char 1)
						(point)))
	(if (< 0 arg)
		(next-line 1)
	  (next-line -1))
	(setq arg (1- arg))))
(global-set-key "\C-x\C-h" 'delete-head-space)





;;; for windows.el
(global-set-key "\e1"
		 (defun win-1 ()
		   (interactive)
		   (win-switch-to-window 1 1)))
(global-set-key "\e2"
		 (defun win-2 ()
		   (interactive)
		   (win-switch-to-window 1 2)))
(global-set-key "\e3"
		 (defun win-3 ()
		   (interactive)
		   (win-switch-to-window 1 3)))
(global-set-key "\e4"
		 (defun win-4 ()
		   (interactive)
		   (win-switch-to-window 1 4)))
(global-set-key "\e5"
		 (defun win-5 ()
		   (interactive)
		   (win-switch-to-window 1 5)))
(global-set-key "\e6"
		 (defun win-6 ()
		   (interactive)
		   (win-switch-to-window 1 6)))
(global-set-key "\e7"
		 (defun win-7 ()
		   (interactive)
		   (win-switch-to-window 1 7)))
(global-set-key "\e8"
		 (defun win-8 ()
		   (interactive)
		   (win-switch-to-window 1 8)))
(global-set-key "\e9"
		 (defun win-9 ()
		   (interactive)
		   (win-switch-to-window 1 9)))
(global-set-key "\e0" 'win-switch-menu)





;;; Buffer-menu-mode でのバッファの一括削除
(defun Buffer-menu-delete-grep (str)
  "dired-mode で，STR に一致した buffer に削除マークを付ける"
  (interactive "sregexp:")
  (goto-char (point-min))
  (let (lines)
    (setq lines (buffer-substring (point-min) (point)))
    (while (re-search-forward str nil t)
	  (Buffer-menu-delete))))
(define-key Buffer-menu-mode-map "G" 'Buffer-menu-delete-grep)




;;;; いつでもどこでも簡単モナーを入れられる
(defvar default-msg "おまえモナー")
(defvar mona
  '("　∧＿∧　　 ／￣￣￣￣￣￣￣￣\n"
    "（ ´∀｀）＜　" mona-msg "\n"
    "（　　　 ）　＼＿＿＿＿＿＿＿＿\n"
    " ｜ ｜　｜\n"
    "（_＿）＿）\n"))
(defun mona (msg)
  "どこでもモナー。
  mew とかで メール見てるときにやると面白いかも."
  (interactive "smessage: ")
  (let ((list mona)
		 (mona-msg default-msg)
		 rect tmp)
	 (unless (string= msg "")
	   (setq mona-msg msg))
	 (while list
	   (setq tmp (concat tmp (eval (car list))))
	   (if (string-match "\\(.*\\)\n" tmp)
		   (progn
			 (setq rect (cons (match-string 1 tmp) rect))
			 (setq tmp nil)))
	   (setq list (cdr list)))
	 (setq rect (reverse rect))
	 (let ((buffer-read-only nil))
	   (insert-rectangle rect)))) 


;;; TV, AV, SV, BV 計算
(defun TV (T)
  (log (/ 1.0 T)
	   2))

(defun AV (A)
  (log (expt A 2)
	   2))

(defun SV (S)
  (log (* 0.3 S)
	   2))

(defun EV (T A)
  (+ (TV T)
	 (AV A)))

(defun BV (T A S)
  (+ (TV T)
	 (AV A)
	 (- (SV S))))


;;; *scratch の保存
(defun save-scratch-data ()
  (let ((str (progn
               (set-buffer (get-buffer "*scratch*"))
               (buffer-substring-no-properties
                (point-min) (point-max))))
        (file (concat (substitute-in-file-name "$HOME/.emacs.d/scratch/") 
					  "scratch" (format-time-string "-%Y-%m-%d"))))
    (if (get-file-buffer (expand-file-name file))
        (setq buf (get-file-buffer (expand-file-name file)))
      (setq buf (find-file-noselect file)))
    (set-buffer buf)
    (erase-buffer)
    (insert str)
    (save-buffer)))

(defadvice save-buffers-kill-emacs
  (before save-scratch-buffer activate)
  (save-scratch-data))


(defun read-scratch-data ()
  (let* ((file (concat (substitute-in-file-name "$HOME/.emacs.d/scratch/") 
					   "scratch" (format-time-string "-%Y-%m-%d"))))
	(when (file-exists-p file)
      (set-buffer (get-buffer "*scratch*"))
      (erase-buffer)
      (insert-file-contents file))
    ))

(read-scratch-data)

            


;(add-hook 'find-tag-hook
;		   '(lambda ()
;			 (setq find-tag-marker-ring (etags-window:find-tag-marker-ring-on-this-window))))





;;; 連番
;;; http://d.hatena.ne.jp/rubikitch/20110221/seq
(eval-when-compile (require 'cl))
(setq aaa 0)
(setq bbb 0)
(setq ccc 0)
(defun number-rectangle (point-start point-end string-format number-from number-by)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) ; 短形リージョン先頭位置
		 (region-end)		; 短形リージョン狩猟位置
		 (read-string "Number rectangle: " "%d")	; 連番開始位置
		 (read-number "From: " 0)	; 連番終了位置
		 (read-number "By: " 1)		; 繰り返し回数
		 ))
  (save-excursion
	(goto-char point-start)
	(setq point-start (point-marker))
	(goto-char point-end)
	(setq point-end (point-marker))
	(delete-rectangle point-start point-end)
	(goto-char point-start)
	(let ((column (current-column))
		  (number-to (- (+ number-from (* (count-lines point-start point-end) number-by)) number-by)))
	  (cond ((> number-by 0)
			 (progn 
			   (loop for i from number-from upto number-to by number-by do
					 (insert (format string-format i))
					 (forward-line 1)
					 (move-to-column column))))
			(t
			 (progn
			   (loop for i from number-from downto number-to by (- number-by) do
					 (insert (format string-format i))
					 (forward-line 1)
					 (move-to-column column)))))))
  (goto-char point-start))

(global-set-key "\C-xrN" 'number-rectangle)
(global-set-key "\M-jN" 'number-rectangle)
