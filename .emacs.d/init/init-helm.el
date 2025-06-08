;;; helm
;; (package-install 'helm)
;(require 'helm)

;; https://monolog.linkode.co.jp/articles/kotoh/Emacs%E3%81%A7helm%E3%82%92%E4%BD%BF%E3%81%86
(require 'helm)
(helm-mode 1)

(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(defvar helm-source-emacs-commands
  (helm-build-sync-source "Emacs commands"
    :candidates (lambda ()
                  (let ((cmds))
                    (mapatoms
                     (lambda (elt) (when (commandp elt) (push elt cmds))))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "A simple helm source for Emacs commands.")

(defvar helm-source-emacs-commands-history
  (helm-build-sync-source "Emacs commands history"
    :candidates (lambda ()
                  (let ((cmds))
                    (dolist (elem extended-command-history)
                      (push (intern elem) cmds))
                    cmds))
    :coerce #'intern-soft
    :action #'command-execute)
  "Emacs commands history")

(custom-set-variables
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-recentf
                               helm-source-files-in-current-dir
                               helm-source-emacs-commands-history
                               helm-source-emacs-commands
                               )))


;; set helm-command-prefix-key to "C-c h"
(progn
  (require 'helm)
  (global-unset-key (kbd "C-c h"))
  (custom-set-variables
   '(helm-command-prefix-key "C-c h")))

;; key settings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-X" ) 'execute-extended-command)
; session.el との組合せで 'helm-show-kill-ring のエラーが発生するので無効化
(global-set-key (kbd "C-M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(define-key helm-command-map (kbd "m") 'helm-mini)
(define-key helm-command-map (kbd "d") 'helm-descbinds)
(define-key helm-command-map (kbd "i") 'helm-imenu)
(define-key helm-command-map (kbd "g") 'helm-ag)
(define-key helm-command-map (kbd "o") 'helm-occur)
(define-key helm-command-map (kbd "y") 'yas/insert-snippet)
(define-key helm-command-map (kbd "M-/") 'helm-dabbrev)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(eval-after-load "helm-files"
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
     (define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)
	 (define-key helm-find-files-map (kbd "C-o") 'dabbrev-expand)
	 ))

;; helm-find-files 中にコピー等がしにくいので find-file を別のキーにアサインして残しておく
(global-set-key (kbd "C-x f") 'find-file)

(with-eval-after-load 'company
  (require 'helm-company)
  (define-key company-mode-map (kbd "C-c H") 'helm-company)
  (define-key company-active-map (kbd "C-c H") 'helm-company))

;;; for helm-migemo(Windos 環境は未だ動作しないので無効化)
(if (null (eq system-type 'windows-nt))
	(helm-migemo-mode 1))

;;; 過去に開いたファイルを参照する recentf のための最大保存ファイル数設定
(setq recentf-max-saved-items 4096)



;;; for helm-ispell(ispell での単語の絞り込みを helm インタフェースで実施)
(require 'helm-ispell)
(global-set-key "\C-ci" 'helm-ispell)


;;; rg(ripgrep) が存在すれば helm-ag のインタフェースとして rg を使用
(if (executable-find "rg")
	(setq helm-ag-base-command "rg --vimgrep --no-heading"))



;;; dired 時に helm を無向にするための dired 関連コマンド
(defvar helm-dired-command-list
  '(dired dired-do-copy dired-do-copy-regexp dired-do-rename dired-do-rename-regexp dired-do-delete))

;;; helm を dired 時に無効化
(defun helm-completing-disable-dired ()
  "Disable helm in dired"
  (interactive)
  (let ((disable-cmd-alist (mapcar (lambda (cmd) (cons cmd nil))
								   helm-dired-command-list)))
	(setq helm-completing-read-handlers-alist (append disable-cmd-alist helm-completing-read-handlers-alist))
	(minibuffer-message "Helm is disabled in dired")))

;;; helm を dired 時に有効化
(defun helm-completing-enable-dired ()
  "Disable helm in dired"
  (interactive)
  (labels ((delete-keys-from-alist (keys alist)
								   (let ((key (car keys)))
									 (cond ((null key)
											alist)
										   (t
											(let ((deleted-alist (delete (assoc key alist) alist)))
											  (delete-keys-from-alist (cdr keys) deleted-alist)))))))
	(setq helm-completing-read-handlers-alist (delete-keys-from-alist helm-dired-command-list helm-completing-read-handlers-alist))
	(minibuffer-message "Helm is enabled in dired")))

;;; ange-ftp 時に helm が動作すると Emacs が死ぬので ange-ftp の hook に helm の無効化処理を追加
(add-hook 'internal-ange-ftp-mode-hook '(lambda () (helm-completing-disable-dired)))

; ;; customize
; (progn
; ;  (require 'helm-ls-git)
;   (custom-set-variables
;    '(helm-truncate-lines t)
;    '(helm-buffer-max-length 35)
;    '(helm-delete-minibuffer-contents-from-point t)
;    '(helm-ff-skip-boring-files t)
;    '(helm-boring-file-regexp-list '("~$" "\\.elc$"))
;    '(helm-ls-git-show-abs-or-relative 'relative)
;    '(helm-mini-default-sources '(helm-source-buffers-list
;                                  helm-source-ls-git
;                                  helm-source-recentf
;                                  helm-source-buffer-not-found))))
; 
; ;; set helm-command-prefix-key to "C-z"
; (progn
;   (require 'helm-config)
;   (global-unset-key (kbd "C-z"))
;   (custom-set-variables
;    '(helm-command-prefix-key "C-z")))
; 
; ;; key settings
; (global-set-key (kbd "C-q") 'helm-mini)
; (global-set-key (kbd "M-x") 'helm-M-x)
; (global-set-key (kbd "M-y") 'helm-show-kill-ring)
; (global-set-key (kbd "C-x C-f") 'helm-find-files)
; (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
; (define-key helm-command-map (kbd "d") 'helm-descbinds)
; (define-key helm-command-map (kbd "g") 'helm-ag)
; (define-key helm-command-map (kbd "o") 'helm-occur)
; (define-key helm-command-map (kbd "y") 'yas/insert-snippet)
; (define-key helm-command-map (kbd "M-/") 'helm-dabbrev)
; 
; (define-key helm-map (kbd "C-h") 'delete-backward-char)
; (eval-after-load "helm-files"
;   '(progn
;      (define-key helm-find-files-map (kbd "C-h") 'helm-ff-backspace)
;      (define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)))


;;; helm から URL を開くブラウザを eww に変更
(eval-after-load "helm-net"
  '(progn
	 (defun helm-search-suggest-perform-additional-action (url query)
	   "Perform the search via URL using QUERY as input."
	   (eww (format url (url-hexify-string query))))))
