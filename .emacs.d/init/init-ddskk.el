;;;;;;;;;;;;;;;;;;;; for skk ;;;;;;;;;;;;;;;;;;;;;;;;

(setq skk-user-directory "~/.emacs.d/ddskk/") ; �ǥ��쥯�ȥ����
(when (require 'skk-autoloads nil t)
  ;; C-x C-j �� skk �⡼�ɤ�ư
  (define-key global-map (kbd "C-x C-j") 'skk-mode)
  ;; .skk ��ưŪ�˥Х��ȥ���ѥ���
  (setq skk-byte-compile-init-file t))

;; dired-x �ǻ��Ѥ��Ƥ��� C-x C-j �� skk �ǻ��Ѥ���褦�˾��
(when (require 'dired-x nil t)
  (global-set-key "\C-x\C-j" 'skk-mode))

;;; ���겾̾�μ�ưǧ��
;(setq skk-auto-okuri-process nil)
;(setq skk-process-okuri-early nil)
