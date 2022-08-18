(require 'undo-tree)
(global-undo-tree-mode t)
;(global-set-key (kbd "M-/") 'undo-tree-redo)

;;; undo-tree のファイルを置くディレクトリ
(setq undo-tree-history-directory-alist `(("." . "~/.emacs.d/undohist")))
