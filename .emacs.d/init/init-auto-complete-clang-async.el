;; auto-complete-clang-async
(require 'auto-complete-clang-async)

(cond ((eq system-type 'darwin)
	   (setq ac-clang-complete-executable (substitute-in-file-name "/usr/local/bin/clang-complete")))
	  ((eq system-type 'gnu/linux)
	   (setq ac-clang-complete-executable (substitute-in-file-name "$HOME/Tools/$HOSTTYPE/bin/clang-complete.sh"))))

(add-hook 'c++-mode-hook
          '(lambda()
			 (setq ac-sources '(ac-source-clang-async))
			 (ac-clang-launch-completion-process)))

(add-hook 'c-mode-hook
          '(lambda()
			 (setq ac-sources '(ac-source-clang-async))
			 (ac-clang-launch-completion-process)))

;; カレントディレクトリをインクルードパスに追加
(custom-set-variables
 '(ac-clang-cflags '("-I./"))
  )

;; プライベート設定ファイルが存在すれば読み込む
(if (file-exists-p (substitute-in-file-name "$HOME/.emacs.d/init/init-auto-complete-clang-async-private.el"))
	(load (substitute-in-file-name "$HOME/.emacs.d/init/init-auto-complete-clang-async-private.el")))

;; 注
;;   マルチバイトを含むコードだと clang-complete の解析に失敗する事があったので下記以降の
;;   auto-complete-clang-async.el を使用すること
;;   https://raw.githubusercontent.com/8bit-jzjjy/emacs-clang-complete-async/62d0531425b91e937bc9ec50775d0b8e9c73d75b/auto-complete-clang-async.el
