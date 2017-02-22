(require 'minimap)
(setq minimap-window-location 'right)

;;; minimap-mode が使えるメジャーモードを追加
(add-to-list 'minimap-major-modes 'text-mode)
(add-to-list 'minimap-major-modes 'org-mode)

