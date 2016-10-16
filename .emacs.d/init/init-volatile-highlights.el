(require 'volatile-highlights)
(volatile-highlights-mode t)

;;-----------------------------------------------------------------------------
;; Supporting undo-tree.
;;-----------------------------------------------------------------------------
(vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
(vhl/install-extension 'undo-tree)

;;; 色の設定
(set-face-attribute
          'vhl/default-face nil :foreground "#FF3333" :background "#FFCDCD")
