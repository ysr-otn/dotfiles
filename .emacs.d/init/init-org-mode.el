;;; コードブロックをそのモードと同じ色付けをする
(setq org-src-fontify-natively t)

;;; org-babel で export 時にコードブロックを再評価する
;;; (nil にして再評価しないようにすると ditta の export が変になるので t としておく)
(setq org-export-use-babel t)

;;; for org-present

;(eval-after-load "org-present"
;  '(progn
;     (add-hook 'org-present-mode-hook
;               (lambda ()
;                 (org-present-big)
;                 (org-display-inline-images)
;                 (org-present-hide-cursor)
;                 (org-present-read-only)))
;     (add-hook 'org-present-mode-quit-hook
;               (lambda ()
;                 (org-present-small)
;                 (org-remove-inline-images)
;                 (org-present-show-cursor)
;                 (org-present-read-write)))
;     ;; 文字をどれだけ大きくするかを設定する
;     (setq org-present-text-scale 5)))


;;; for org-tree-slide-mode

;;; ヘッダの表示を無効化する
(setq org-tree-slide-header nil)

;;; 起動時に見出しを強調する
(setq org-tree-slide-heading-emphasis t)

;;; 起動時にヘッダを表示しないようにする
(setq org-tree-slide-slide-in-effect nil)

;;; スライド化するツリーのレベル(0 なら全てスライド化)
(setq org-tree-slide-skip-outline-level 0) 

;;; スライドインの開始位置を調節する（行数を指定）
(setq org-tree-slide-slide-in-brank-lines 10) 


;;; org-modeのHTMLエクスポート時にimgタグのalt属性をcaptionからつける
;;; http://misohena.jp/blog/2020-05-26-set-alt-attribute-from-caption-in-ox-html.html
(defun org-altcaption--get-caption (paragraph info)
  "段落に設定されているキャプション文字列を取得する。

org-html-paragraph関数内の「;; Standalone image.」の部分より。"
  (if paragraph
	  (let ((raw (org-export-data (org-export-get-caption paragraph) info)))
		(if (org-string-nw-p raw) raw nil))))

(defun org-altcaption--get-link-parent (link info)
  "linkの親要素を取得する。ただし、linkが最初のリンクでない場合はnil。

org-html-link関数内より。"
  ;; Extract caption from parent's paragraph.  HACK: Only
  ;; do this for the first link in parent (inner image link
  ;; for inline images).  This is needed as long as
  ;; attributes cannot be set on a per link basis.
  (let* ((parent (org-export-get-parent-element link))
		 (link (let ((container (org-export-get-parent link)))
				 (if (and (eq 'link (org-element-type container))
						  (org-html-inline-image-p link info))
					 container
				   link))))
	(and (eq link (org-element-map parent 'link #'identity info t))
		 parent)))

(defvar org-altcaption--link nil)

(defun org-altcaption--org-html-link (old-func link desc info)
  "org-html-linkに対するaround advice"
  ;; Pass link to org-altcaption--org-html--format-image function
  (let ((org-altcaption--link link))
	(funcall old-func link desc info)))

(defun org-altcaption--org-html--format-image (old-func source attributes info)
  "org-html--format-imageに対するaround advice"
  ;; Add alt attribute if link has caption
  (if (and org-altcaption--link (null (plist-get attributes :alt)))
	  (let ((caption (org-altcaption--get-caption (org-altcaption--get-link-parent org-altcaption--link info) info)))
		(when caption
		  (setq attributes (plist-put attributes :alt caption))
		  ;;(message "caption=%s" caption)
		  )))
  ;; Call original function
  (funcall old-func source attributes info))


(defun org-altcaption-activate ()
  (interactive)
  (advice-add #'org-html-link :around #'org-altcaption--org-html-link)
  (advice-add #'org-html--format-image :around #'org-altcaption--org-html--format-image))

(defun org-altcaption-deactivate ()
  (interactive)
  (advice-remove #'org-html-link #'org-altcaption--org-html-link)
  (advice-remove #'org-html--format-image #'org-altcaption--org-html--format-image))
  

;;; org-mode 読み込み時に実行する設定
(with-eval-after-load 'org
  ;; for org-babel
  ;; org-version 9.2 以上ならテンプレート機能のために org-tempo を読み込み
  (when (version<= "9.2" (org-version))
	(require 'org-tempo))
  
  ;; for org-babel-gnuplot
  ;; org-babel で shell, C, C++, ruby, python, lisp, dot, ditaa, gnuplot, R  が使えるようにする
  (org-babel-do-load-languages 'org-babel-load-languages
							   '((shell . t)
								 (C . t)
								 (ruby . t)
								 (python . t)
								 (lisp . t)
								 (dot . t)
								 (ditaa . t)
								 (gnuplot . t)
								 (R . t)
								 ))
			 
  ; org-babel のアウトプットに ANSI カラーエスケープが含まれている場合に色付けして結果を記述する
  ; https://emacs.stackexchange.com/questions/44664/apply-ansi-color-escape-sequences-for-org-babel-results
  (defun ek/babel-ansi ()
	(when-let ((beg (org-babel-where-is-src-block-result nil nil)))
	  (save-excursion
		(goto-char beg)
		(when (looking-at org-babel-result-regexp)
		  (let ((end (org-babel-result-end))
				(ansi-color-context-region nil))
			(ansi-color-apply-on-region beg end))))))
  (add-hook 'org-babel-after-execute-hook 'ek/babel-ansi)
  
  ;; for org-tree-slide-move
  (load "org-tree-slide")
			   
  (define-key org-mode-map (kbd "C-c t") 'org-tree-slide-mode)
			   
  (define-key org-tree-slide-mode-map (kbd "<right>") 'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "n") 'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "<left>") 'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "p") 'org-tree-slide-move-previous-tree)
			   
  (setq org-tree-slide-mode-play-hook nil)
  (setq org-tree-slide-mode-stop-hook nil)
			   
  (add-hook 'org-tree-slide-mode-play-hook
			'(lambda () 
			   (text-scale-adjust 0)
			   (text-scale-adjust 4)
			   (org-display-inline-images)
			   (read-only-mode 1)
			   ))
			   
  (add-hook 'org-tree-slide-mode-stop-hook
			'(lambda () 
			   (text-scale-adjust 0)
			   (org-remove-inline-images)
			   (read-only-mode -1)
			   ))
  
  ;;; for ox-reveal
  (load-library "ox-reveal")
			 
  ;; org-reveal-export-to-html で出力されるファイル名が org-html-export-to-html と同じ
  ;; hoge.html なので org-export-to-file を advice-add で再定義し reveal から実行された
  ;; 場合は hoge_presen.html のようにサフィックスで分類できるようにする
  (defvar org-reveal-export-file-suffix "_presen")
  (defun my-org-export-to-file (orig-func backend file &optional async subtreep visible-only body-only ext-plist post-process)
	(if (eq backend 'reveal)
		(funcall orig-func backend (s-replace ".html" (concat org-reveal-export-file-suffix".html") file) 
				 async subtreep visible-only body-only ext-plist post-process)
		(funcall orig-func backend file async subtreep visible-only body-only ext-plist post-process)))

  (advice-add 'org-export-to-file :around 'my-org-export-to-file)

  ;;; for ox-latex
  ;; LaTeX へのコンバートでスペースを自動的にタブにされないようにタブを無効化
  ;; (コードブロックを LaTeX へ変換した時にタブにされると LaTeX でコンパイル
  ;;  した時に ^^I になるのを防ぐため)
  (setq indent-tabs-mode nil)
  (add-hook 'org-export-before-processing-hook
			'(lambda (&optional _mode)
			   (setq indent-tabs-mode nil)
			   ))
               
  (add-to-list 'org-latex-classes
			   '("jsarticle"
				 "\\documentclass[dvipdfmx,10pt]{jsarticle}"
				 ("\\section{%s}" . "\\section*{%s}")
				 ("\\subsection{%s}" . "\\subsection*{%s}")
				 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
				 ("\\paragraph{%s}" . "\\paragraph*{%s}")
				 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
				 )
			   )
  (setq org-latex-default-class "jsarticle")
  (setq org-latex-pdf-process
		'("platex -shell-escape %f"	; minted のために -shell-escape を追加
		  "platex -shell-escape %f"
		  "pbibtex %b"
		  "platex -shell-escape %f"
		  "platex -shell-escape %f"
		  "dvipdfmx %b.dvi"))
  (setq org-export-latex-listings t)
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
		'(("frame" "lines")			; 上下にラインを出力
		  ("framesep=2mm")
		  ("baselinestretch=1.2")
		  ("fontsize=\\scriptsize")	; フォントをスクリプトサイズに縮小
		  ("breaklines")				; 行末で改行
		  ))

  ;;; MS-Office ファイルは外部プロセスで開く
  (add-to-list 'org-file-apps '("\\.\\(xls\\|xlsx\\|xlsm\\)" . default))
  (add-to-list 'org-file-apps '("\\.\\(ppt\\|pptx\\)" . default))
  (add-to-list 'org-file-apps '("\\.\\(doc\\|docx\\)" . default))

  ;;; for ox-taskjuggler-mod
  (load-library "ox-taskjuggler-mod")

  ;;; org-modeのHTMLエクスポート時にimgタグのalt属性をcaptionからつける
  (org-altcaption-activate)
			 
			 
  ;;; checkbox を変更した TODO の状態を自動的に更新
  ;;; https://christiantietze.de/posts/2021/02/emacs-org-todo-doing-done-checkbox-cycling/
  (defun ct/org-summary-todo-cookie (n-done n-not-done)
	"Switch header state to DONE when all subentries are DONE, to TODO when none are DONE, and to DOING otherwise"
	(let (org-log-done org-log-states)   ; turn off logging
	  (org-todo (cond ((= n-done 0)
					   "TODO")
					  ((= n-not-done 0)
					   "DONE")
					  (t
					   "DOING")))))
  (add-hook 'org-after-todo-statistics-hook #'ct/org-summary-todo-cookie)

  (defun org-todo-if-needed (state)
	"Change header state to STATE unless the current item is in STATE already."
	(unless (string-equal (org-get-todo-state) state)
	  (org-todo state)))

  (defun ct/org-summary-todo-cookie (n-done n-not-done)
	"Switch header state to DONE when all subentries are DONE, to TODO when none are DONE, and to DOING otherwise"
	(let (org-log-done org-log-states)   ; turn off logging
	  (org-todo-if-needed (cond ((= n-done 0)
								 "TODO")
								((= n-not-done 0)
								 "DONE")
								(t
								 "DOING")))))
  (add-hook 'org-after-todo-statistics-hook #'ct/org-summary-todo-cookie)

  (defun ct/org-summary-checkbox-cookie ()
	"Switch header state to DONE when all checkboxes are ticked, to TODO when none are ticked, and to DOING otherwise"
	(let (beg end)
	  (unless (not (org-get-todo-state))
		(save-excursion
		  (org-back-to-heading t)
		  (setq beg (point))
		  (end-of-line)
		  (setq end (point))
		  (goto-char beg)
		  ;; Regex group 1: %-based cookie
		  ;; Regex group 2 and 3: x/y cookie
		  (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]"
								 end t)
			  (if (match-end 1)
				  ;; [xx%] cookie support
				  (cond ((equal (match-string 1) "100%")
						 (org-todo-if-needed "DONE"))
						((equal (match-string 1) "0%")
						 (org-todo-if-needed "TODO"))
						(t
						 (org-todo-if-needed "DOING")))
				;; [x/y] cookie support
				(if (> (match-end 2) (match-beginning 2)) ; = if not empty
					(cond ((equal (match-string 2) (match-string 3))
						   (org-todo-if-needed "DONE"))
						  ((or (equal (string-trim (match-string 2)) "")
							   (equal (match-string 2) "0"))
						   (org-todo-if-needed "TODO"))
						  (t
						   (org-todo-if-needed "DOING")))
				  (org-todo-if-needed "DOING"))))))))
  
  (add-hook 'org-checkbox-statistics-hook #'ct/org-summary-checkbox-cookie)
  )

;; 画像の幅を変更するときに必要っぽい
;; https://emacs.stackexchange.com/questions/26363/downscaling-inline-images-in-org-mode
(setq org-image-actual-width t)


;;; ソースコードの色付けのための htmlize の設定
(require 'htmlize)


;;; ob-mermaid の設定
(cond ((eq system-type 'darwin)
	   (setq ob-mermaid-cli-path "/usr/local/bin/mmdc")))


;;; ob-ditaa の設定
(cond ((eq system-type 'darwin)
	   (setq org-ditaa-jar-path (substitute-in-file-name "$HOME/Development/github/ysr-otn/jditaa/jditaa.jar")))
	  ((eq system-type 'windows-nt)
	   (progn
		(setq org-ditaa-jar-path (substitute-in-file-name "$HOME/Development/github/ysr-otn/jditaa/jditaa.jar"))
		(setq org-babel-default-header-args:ditaa
			  '((:results . "file")
				(:exports . "results")
				(:java . "-Dfile.encoding=SJIS")))	; 何故か UTF-8 だと文字化けするので SJIS に設定
		)))


;;;; org-agenda の設定
;;; org-agenda のキー設定
(global-set-key (kbd "C-c a") 'org-agenda)
;;; アジェンダ対象のファイルを置くディレクトリ
(setq org-agenda-files-dir "~/Documents/org/gtd/")
;;; アジェンダ対象のファイル
(setq org-agenda-files-suffix '("todo.org" "notes.org"))
;;; アジェンダ対象のファイル org-agenda-files を設定
(setq org-agenda-files (mapcar (lambda (f) (concat org-agenda-files-dir f))
                               org-agenda-files-suffix))
;;; アジェンダのフォーマット 
;;; (%-12(org-entry-get (point) \"allocate\") は Property の allocate を, %8e は Property の Effort を表示)
(setq org-agenda-prefix-format
	  '((agenda . "%2i %-12:c%-12t%14 s %-32(org-entry-get (point) \"allocate\") %8e ")
		(properties . "%12 s")
		(timeline . "%12 s")
		(todo . "%2i %-12:c")
		(tags . "%2i %-12:c")
		(search . "%2i %-12:c")))

;;; TODO の設定
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(i)" "WAIT(w)" "REMIND(r)" "|" "DONE(d)" "SOMEDAY(s)")))

;;; アジェンダを HTML で出力する際のスタイルの設定
;;; (等幅フォントで表示したいので "Courier New", Consolas, monospace の順に優先度を付けて指定)
(setq org-agenda-export-html-style
"<style>
    <!--
      body {
        color: #eaeaea;
        background-color: #000000;
		font-family: \"Courier New\", Consolas, monospace;
       }
      .org-agenda-calendar-event {
        /* org-agenda-calendar-event */
        color: #eaeaea;&#x61;
        background-color: #000000;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-current-time {
        /* org-agenda-current-time */
        color: #eedd82;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-date {
        /* org-agenda-date */
        color: #7aa6da;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-date-today {
        /* org-agenda-date-today */
        color: #7aa6da;
        font-weight: bold;
        font-style: italic;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-date-weekend {
        /* org-agenda-date-weekend */
        color: #7aa6da;
        font-weight: bold;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-diary {
        /* org-agenda-diary */
        color: #eaeaea;
        background-color: #000000;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-done {
        /* org-agenda-done */
        color: #b9ca4a;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-agenda-structure {
        /* org-agenda-structure */
        color: #c397d8;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-done {
        /* org-done */
        color: #b9ca4a;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-scheduled {
        /* org-scheduled */
        color: #b9ca4a;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-scheduled-previously {
        /* org-scheduled-previously */
        color: #70c0b1;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-scheduled-today {
        /* org-scheduled-today */
        color: #b9ca4a;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-time-grid {
        /* org-time-grid */
        color: #eedd82;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-todo {
        /* org-todo */
        color: #d54e53;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-upcoming-deadline {
        /* org-upcoming-deadline */
        color: #e78c45;
 		font-family: \"Courier New\", Consolas, monospace;
      }
      .org-warning {
        /* org-warning */
        color: #d54e53;
        font-weight: bold;
 		font-family: \"Courier New\", Consolas, monospace;
      }

      a {
        color: inherit;
        background-color: inherit;
 		font-family: \"Courier New\", Consolas, monospace;
         text-decoration: inherit;
      }
      a:hover {
        text-decoration: underline;
      }
    -->
</style>"
)


;;; tjp ファイルの textreport report "Plan" のフォーマットの設定
(setq org-taskjuggler-default-reports
  '("textreport report \"Plan\" {
  formats html
  header '== %title =='

  center -8<-
    [#Plan Plan] | [#Resource_Allocation Resource Allocation]
    ----
    === Plan ===
    <[report id=\"plan\"]>
    ----
    === Resource Allocation ===
    <[report id=\"resourceGraph\"]>
  ->8-
}

# A traditional Gantt chart with a project overview.
taskreport plan \"\" {
  headline \"Project Plan\"
  columns bsi, name, priority, resources{listitem \"<-query attribute='name'->\"}, start, end, effort, complete, chart {scale day width 1000}
  loadunit shortauto
  hideresource 1
}

# A graph showing resource allocation. It identifies whether each
# resource is under- or over-allocated for.
resourcereport resourceGraph \"\" {
  headline \"Resource Allocation Graph\"
  columns no, name, priority, effort, complete, daily {width 1000}
  loadunit shortauto
  hidetask ~(isleaf() & isleaf_())
  sorttasks plan.start.up
}"))

;;; TaskJuggler のデフォルトのプロジェクトの日程長
(setq org-taskjuggler-default-project-duration 10000)
