;;; helm
;; (package-install 'helm)
;(require 'helm)

;; https://monolog.linkode.co.jp/articles/kotoh/Emacs%E3%81%A7helm%E3%82%92%E4%BD%BF%E3%81%86
(require 'helm-config)
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
  (require 'helm-config)
  (global-unset-key (kbd "C-c h"))
  (custom-set-variables
   '(helm-command-prefix-key "C-c h")))

;; key settings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-X" ) 'execute-extended-command)
; session.el との組合せで 'helm-show-kill-ring のエラーが発生するので無効化
;(global-set-key (kbd "M-y") 'helm-show-kill-ring)
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


;;; for helm-migemo
(helm-migemo-mode 1)

;;; 過去に開いたファイルを参照する recentf のための最大保存ファイル数設定
(setq recentf-max-saved-items 4096)


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
