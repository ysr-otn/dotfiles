;;; init-org-mode.el --- Initialize settings for org-mode.

;; Copyright (C) 2020 Yoshihiro Ohtani

;; Author: Yoshihiro Ohtani

;; The functions org-taskjuggler-get-start, org-taskjuggler--build-task are modified from
;; the orignal functions these are implemented in ox-taskjuggler.el.
;; More details of the copyright and the license about ox-taskjuggler.el, see below.

	;;; ox-taskjuggler.el --- TaskJuggler Back-End for Org Export Engine
	;;
	;; Copyright (C) 2007-2020 Free Software Foundation, Inc.
	;;
	;; Emacs Lisp Archive Entry
	;; Filename: ox-taskjuggler.el
	;; Author: Christian Egli
	;;      Nicolas Goaziou <n dot goaziou at gmail dot com>
	;; Maintainer: Christian Egli
	;; Keywords: org, taskjuggler, project planning
	;; Description: Converts an Org mode buffer into a TaskJuggler project plan
	
	;; This file is not part of GNU Emacs.
	
	;; This program is free software: you can redistribute it and/or modify
	;; it under the terms of the GNU General Public License as published by
	;; the Free Software Foundation, either version 3 of the License, or
	;; (at your option) any later version.
	
	;; This program is distributed in the hope that it will be useful,
	;; but WITHOUT ANY WARRANTY; without even the implied warranty of
	;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	;; GNU General Public License for more details.
	
	;; You should have received a copy of the GNU General Public License
	;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.



;;; Code:
	

;;; コードブロックをそのモードと同じ色付けをする
(setq org-src-fontify-natively t)



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


;;; org-taskjuggler の task の :raw-value から，[x/y], [z%] の値から百分率の進捗数値に変換
(defun org-taskjuggler--raw-value-to-progress (raw-value-str)
  (cond ((string-match "\\[\\([0-9]*\\)/\\([0-9]*\\)\\][ \t]*$" raw-value-str)
		 (progn
		   (let ((molecule (string-to-number (match-string 1 raw-value-str)))
				 (denominator (string-to-number (match-string 2 raw-value-str))))
			 (/ (* 100 molecule) denominator))))
		((string-match "\\[\\([0-9]*\\)%\\]$" raw-value-str)
		 (string-to-number (match-string 1 raw-value-str)))
		(t 
		 nil)))


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

(add-hook 'org-mode-hook
		  '(lambda ()
			 ;; for org-babel
			 (progn
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
			   )
			 
			 ;;; for org-tree-slide-move
			 (progn
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
			   )
		     ;;; for ox-reveal
			 (progn
			   (load-library "ox-reveal")
			   )
			 
			 ;;; for ox-latex
			 (progn
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
			   )

			 ;; MS-Office ファイルは外部プロセスで開く
			 (progn
			   (add-to-list 'org-file-apps '("\\.\\(xls\\|xlsx\\|xlsm\\)" . default))
			   (add-to-list 'org-file-apps '("\\.\\(ppt\\|pptx\\)" . default))
			   (add-to-list 'org-file-apps '("\\.\\(doc\\|docx\\)" . default)))

			 
			 ;; org-version 9.3.6 以降で org-taskjuggler-get-start, org-taskjuggler--build-task を上書き．
			 ;; (# でコメント部が オリジナルからの変更部分)
			 ;; Overwrite org-taskjuggler-get-start, org-taskjuggler--build-task, if org-version is 9.3.6 or higher.
			 ;; (Comments written with # are modified from the original version.)
			 (if (string> org-version "9.3.5")
				 (progn
				   (require 'ox-taskjuggler)
				   ;; org-taskjuggler-get-start で :scheduled に 時:分 の指定がある場合に対応
				   (defun org-taskjuggler-get-start (item)
"Return start date for task or resource ITEM.
ITEM is a headline.  Return value is a string or nil if ITEM
doesn't have any start date defined."
					 (let* ((scheduled (org-element-property :scheduled item))
							(hour-start (org-element-property :hour-start scheduled))		; # :scheduled の hour-start のプロパティ
							(minute-start (org-element-property :minute-start scheduled)))	; # :scheduled の minute-start のプロパティ
					   (or
						(and scheduled hour-start minute-start (org-timestamp-format scheduled "%Y-%02m-%02d-%02H:%02M"))	; # 時:分の指定がある場合
						(and scheduled (org-timestamp-format scheduled "%Y-%02m-%02d"))
						(and (memq 'start org-taskjuggler-valid-task-attributes)
							 (org-element-property :START item)))))				   
				   
				   ;; org-taskjuggler--build-task でプロパティ :start: が無くとも :SCHEDULED の値で
				   ;; TaskJuggleru の start 要素を設定できるように org-taskjuggler--build-task を上書き
				   (defun org-taskjuggler--build-task (task info)
"Return a task declaration.

TASK is a headline.  INFO is a plist used as a communication
channel.

All valid attributes from TASK are inserted.  If TASK defines
a property \"task_id\" it will be used as the id for this task.
Otherwise it will use the ID property.  If neither is defined
a unique id will be associated to it."
					 (let* ((allocate (org-element-property :ALLOCATE task))
							(complete													; # begin
							 (let ((progress	(org-taskjuggler--raw-value-to-progress (org-element-property :raw-value task)))	; # [x/y], [z%] の進捗
								   (done		(eq (org-element-property :todo-type task) 'done))	; # DONE になっているか？
								   (complete	(org-element-property :COMPLETE task)))				; # :COMPLETE の値
							   (cond (progress		progress)							; # [x/y], [z%] の進捗
									 (done			"100")								; # DONE になってれば complete は 100
									 (complete		complete)							; # :COMPLETE の値があれば complete の値として使用
									 (t "0")))											; # 進捗の記載が無ければ complete は 0
							 )															; # end 
							(depends (org-taskjuggler-resolve-dependencies task info))
							(effort (let ((property
										   (intern (concat ":" (upcase org-effort-property)))))
									  (org-element-property property task)))
							(milestone
							 (or (org-element-property :MILESTONE task)
								 (not (or (org-element-map (org-element-contents task) 'headline
											'identity info t)  ; Has task any child?
										  effort
										  (org-element-property :LENGTH task)
										  (org-element-property :DURATION task)
										  (and (org-taskjuggler-get-start task)
											   (org-taskjuggler-get-end task))
										  (org-element-property :PERIOD task)))))
							(start (org-taskjuggler-get-start task))	; # :SCHEDULED から start を取得
							(priority
							 (let ((pri (org-element-property :priority task)))
							   (and pri
									(max 1 (/ (* 1000 (- org-lowest-priority pri))
											  (- org-lowest-priority org-highest-priority)))))))
					   (concat
						;; Opening task.
						(format "task %s \"%s\" {\n"
								(org-taskjuggler-get-id task info)
								(org-taskjuggler-get-name task))
						;; Add default attributes.
						(and depends
							 (format "  depends %s\n"
									 (org-taskjuggler-format-dependencies depends task info)))
						(and allocate
							 (format "  purge %s\n  allocate %s\n"
									 ;; Compatibility for previous TaskJuggler versions.
									 (if (>= org-taskjuggler-target-version 3.0) "allocate"
									   "allocations")
									 allocate))
						(and complete (format "  complete %s\n" complete))
						(and effort (format "  effort %s\n" effort))
						(and priority (format "  priority %s\n" priority))
						(and milestone "  milestone\n")
						(and start (format "  start %s\n" start))	;; # start を追加(:start: と :SCHEDULED が同時あると 2 個 start が付くので必要に応じて修正)
						;; Add other valid attributes.
						(org-taskjuggler--indent-string
						 (org-taskjuggler--build-attributes
						  task 
						  (if start																				; # start が既に設定されていれば
							  (remove-if '(lambda (x) (eq x 'start)) org-taskjuggler-valid-task-attributes)		; # org-taskjuggler-valid-task-attributes から start を除去してその他の設定を追加
							org-taskjuggler-valid-task-attributes)))											; # start 有りの org-taskjuggler-valid-task-attributes でその他の設定を追加
						;; Add inner tasks.
						(org-taskjuggler--indent-string
						 (mapconcat 'identity
									(org-element-map (org-element-contents task) 'headline
									  (lambda (hl) (org-taskjuggler--build-task hl info))
									  info nil 'headline)
									""))
						;; Closing task.
						"}\n")))
			   ))
			 ))

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
	   (setq org-ditaa-jar-path (substitute-in-file-name "$HOME/Development/github/ysr-otn/jditaa/jditaa.jar"))))

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
	  '((agenda . "%2i %-12:c%-12t%14 s %-32(org-entry-get (point) \"allocate\")) %8e ")
		(properties . "%12 s")
		(timeline . "%12 s")
		(todo . "%2i %-12:c")
		(tags . "%2i %-12:c")
		(search . "%2i %-12:c")))

;;; TODO の設定
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "REMIND(r)" "|" "DONE(d)" "SOMEDAY(s)")))

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
(setq org-taskjuggler-default-project-duration 365)

