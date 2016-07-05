(require 'helm-swoop)

;; キーバインドはお好みで
(global-set-key (kbd "C-c s") nil)
(global-set-key (kbd "C-c s s") 'helm-swoop)
(global-set-key (kbd "C-c s b") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c s m") 'helm-multi-swoop)
(global-set-key (kbd "C-c s a") 'helm-multi-swoop-all)

;; isearch実行中にhelm-swoopに移行
(define-key isearch-mode-map (kbd "C-M-s") 'helm-swoop-from-isearch)
;; helm-swoop実行中にhelm-multi-swoop-allに移行
(define-key helm-swoop-map (kbd "C-M-s") 'helm-multi-swoop-all-from-helm-swoop)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; 値がtの場合はウィンドウ内に分割、nilなら別のウィンドウを使用
(setq helm-swoop-split-with-multiple-windows nil)

;; ウィンドウ分割方向 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; nilなら一覧のテキストカラーを失う代わりに、起動スピードをほんの少し上げる
(setq helm-swoop-speed-or-color t)

;; helm-multi-swoop で参照しないバッファの正規表現
(setq helm-multi-swoop-ignore-buffers-match "\\(.*~$\\|\*.*\*$\\)")


;;; http://fukuyama.co/helm-swoop
;;	編集機能: 
;;		helm-swoopまたはhelm-multi-swoop(-all)を実行中に
;;		[C-c C-e]と押すことでリストを編集して、
;;		バッファに反映[C-x C-s]させることができます。
;;		[C-SPC]で編集したい行をいくつかマークしておくと、
;;		[C-c C-e]で編集モードに移行した際にその行だけが
;;		編集対象となります。
;;	Multiline機能: 
;;		M-5 M-x helm-swoop や C-u 3 M-x helm-swoop とすることで
;;		複数の行単位で使用できます。
