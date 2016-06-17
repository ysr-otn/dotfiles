;;; キャッシュを有効化(キャッシュをクリアするには M-x projectile-invalidate-cache)
;;; http://d.hatena.ne.jp/sugyan/20141022/1413967555
(custom-set-variables
  '(projectile-enable-caching t))

(setq projectile-keymap-prefix (kbd "C-c P"))

;;; helm-projectile 込みで projectile を有効化
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
