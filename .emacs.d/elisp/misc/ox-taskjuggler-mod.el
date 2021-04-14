;;; ox-taskjuggler-mod.el --- Reorganization of ox-taskjuggler.el.

;; Copyright (C) 2021 Yoshihiro Ohtani

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
