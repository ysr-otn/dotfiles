;;; for timer(used from tooltip, navi2ch)
(load "timer.el")

;;; ������������Ǥ��ʤ�
(blink-cursor-mode 0)

;;; ���ڡ����Ǥ��䴰�Ǥ���褦�ˤ���
(if (boundp 'minibuffer-local-filename-completion-map)
    (define-key minibuffer-local-filename-completion-map
                " " 'minibuffer-complete-word))
(if (boundp 'minibuffer-local-must-match-filename-map)
    (define-key minibuffer-local-must-match-filename-map
                " " 'minibuffer-complete-word)) 

;;; �ġ���С���ä�
(tool-bar-mode 0)
