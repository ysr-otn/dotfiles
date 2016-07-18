;;; elmo-search-est.el --- Hyper Estraier support for elmo-search.

;; Copyright (C) 2005  Taiki SUGAWARA <buzz.taiki@jcom.home.ne.jp>

;; Author: Taiki SUGAWARA <buzz.taiki@jcom.home.ne.jp>
;; Keywords: mail, net news

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:

(require 'elmo-search)

(defcustom elmo-search-est-default-database
  (expand-file-name "~/.caskets/mail")
  "*Database path for hyper estraier."
  :type '(directory :tag "Database Path")
  :group 'elmo)

(defcustom elmo-search-est-db-alias-alist nil
  "*Alist of ALIAS and DB-PATH."
  :type '(repeat (cons (string :tag "Alias Name")
		       (directory :tag "Database Path")))
  :group 'elmo)

(defcustom elmo-search-est-default-master-url "http://localhost:1978/"
  "*Default url of node master."
  :type 'string
  :group 'elmo)

(defcustom elmo-search-est-default-node "mail"
  "*Default node name for hyper estraier."
  :type 'string
  :group 'elmo)

(defcustom elmo-search-est-attr-separator ?,
  "*Separator of attributes."
  :type 'character
  :group 'elmo)


(defun elmo-search-est-database (engine pattern)
  (let ((param (elmo-search-engine-param-internal engine)))
    (expand-file-name
     (cond
      ((cdr (assoc param elmo-search-est-db-alias-alist)))
      ((and param (> (length param) 0))
       param)
      (t
       elmo-search-est-default-database)))))

(defun elmo-search-est-node (engine pattern)
  (let ((param (elmo-search-engine-param-internal engine)))
    (cond ((and param (string-match "^http://" param))
	   param)
	  ((and param (> (length param) 0))
	   (concat elmo-search-est-default-master-url "node/" param))
	  (t
	   (concat elmo-search-est-default-master-url
		   "node/"
		   elmo-search-est-default-node)))))

(defun elmo-search-est-phrase (engine pattern)
  (let ((charset (elmo-search-engine-extprog-charset-internal engine))
	(phrase (car (elmo-parse-token
		      pattern
		      (char-to-string elmo-search-est-attr-separator)))))
    (if charset
	(encode-mime-charset-string phrase charset)
      phrase)))

(defun elmo-search-est-input-charset (engine pattern)
  (symbol-name
   (or (elmo-search-engine-extprog-charset-internal engine)
       (coding-system-to-mime-charset
	(cdr default-process-coding-system)))))

(defun elmo-search-est-attrs (engine pattern)
  (let* ((charset (elmo-search-engine-extprog-charset-internal engine))
	 (prefix elmo-search-est-attr-separator)
	 (seps (char-to-string elmo-search-est-attr-separator))
	 (rest (cdr (elmo-parse-token pattern seps)))
	 attrs)
    (while (> (length rest) 0)
      (let ((result (elmo-parse-prefixed-element prefix rest seps)))
	(setq attrs (cons "-attr"
			  (cons (if charset
				    (encode-mime-charset-string
				     (car result) charset)
				  (car result))
				attrs))
	      rest (cdr result))))
    attrs))

(defun elmo-search-est-parse-vu ()
  (let (locations)
    (goto-char (point-min))
    (while (re-search-forward "^[0-9]+\t\\(file:.+\\)" nil t)
      (setq locations (cons (match-string 1) locations)))
    (nreverse locations)))

(defun elmo-search-est-parse ()
  (let (locations boundary beg)
    (goto-char (point-min))
    (when (looking-at "^-+\\[[0-9A-Z]+\\]-+$")
      (setq boundary
	    (regexp-quote
	     (buffer-substring (match-beginning 0) (match-end 0))))
      (forward-line)
      (when (re-search-forward boundary nil t)
	(forward-line))
      (setq beg (point))
      (while (re-search-forward boundary nil t)
	(save-excursion
	  (goto-char beg)
	  (when (re-search-forward "^@uri=\\(.+\\)$"
				   (save-excursion
				     (re-search-forward
				      "^$" (match-beginning 0) t)
				     (point))
				   t)
	    (setq locations (cons (match-string 1) locations))))
	(forward-line)
	(setq beg (point)))
      (nreverse locations))))

(elmo-search-register-engine
 'estcmd 'local-file
 :prog "estcmd"
 :args '("search"
	 "-ic" elmo-search-est-input-charset
	 "-vu" "-sf"
	 elmo-search-est-attrs
	 "-ord" "@mdate NUMA"
	 "-max" "-1"
	 elmo-search-est-database elmo-search-est-phrase)
 :charset 'iso-2022-jp
 :parser 'elmo-search-est-parse-vu)

(elmo-search-register-engine
 'estcall 'local-file
 :prog "estcall"
 :args '("search"
	 "-sf"
	 elmo-search-est-attrs
	 "-ord" "@mdate NUMA"
	 "-max" "9999"			; estcall bug?
	 elmo-search-est-node elmo-search-est-phrase)
 :charset 'utf-8
 :parser 'elmo-search-est-parse)

(provide 'elmo-search-est)

;;; elmo-search-est.el ends here
