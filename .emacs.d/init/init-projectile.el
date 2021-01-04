;;; キャッシュを有効化(キャッシュをクリアするには M-x projectile-invalidate-cache)
;;; http://d.hatena.ne.jp/sugyan/20141022/1413967555
(custom-set-variables
  '(projectile-enable-caching t))

(setq projectile-keymap-prefix (kbd "C-c P"))

;;; helm-projectile 込みで projectile を有効化
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;; Windows 用の設定
(cond ((eq system-type 'windows-nt)
	   (progn
		 ;; 外部インデックシングを使用
		 (setq projectile-indexing-method 'alien)
		 ;; デフォルトの "svn list -R . | grep -v '$/' | tr '\\n' '\\0'" だと
		 ;; Windows では遅すぎるので svn コマンドと find コマンドを流用してインデックシング
		 ;; 余計なファイルはインデックシングの対象外とする)
		 (setq projectile-svn-command "find `svn info | grep 'Working Copy Root Path' | awk '{print $NF}'` -type f | grep -v '.svn' | grep -v '\.o$' | grep -v '/obj/' | grep -v '\.mcrdb' | grep -v '$/' | tr '\\n' '\\0'")
		 )))


