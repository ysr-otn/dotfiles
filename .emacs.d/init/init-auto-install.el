(setq load-path
      (append
        (list
		 (substitute-in-file-name "$HOME/.emacs.d/elisp/auto-install"))
		load-path))

(when (require 'auto-install nil t)
  ;;インストールディレクトリを設定。.emacs.d/elispに入れる。
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;;EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;;必要であればプロキシの設定を行う
  ;;(setq url-proxy-services '(("http" . "hogehoge")))
  ;;install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))
