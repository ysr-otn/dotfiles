;;; http://qiita.com/akisute3@github/items/8deb54b75b48e8b04cb0

(require 'search-web)

;;; search-web-dwim を用いて，カーソルのある単語，もしくはリージョンの文字列を search-web に渡す
(define-prefix-command 'search-web-map)
(global-set-key (kbd "M-I") 'search-web-map)
;;; M-I g なら google
(global-set-key (kbd "M-I g") (lambda () (interactive) (search-web-dwim "google")))
;;; M-I e なら eijiro
(global-set-key (kbd "M-I e") (lambda () (interactive) (search-web-dwim "eijiro")))

;; 注
;; 検索結果を表示するブラウザは M-x customize-group で search-web を選択し，
;; Search Web Default Browser で設定するか，直接 search-web-default-browser を設定する
(setq search-web-default-browser 'w3m-browse-url)


;;; popwin を用いて検索結果を w3m/eww で表示する時の設定(search-web.el のコメント部を参照)
(defadvice w3m-browse-url (around w3m-browse-url-popwin activate)
   (save-window-excursion ad-do-it)
   (unless (get-buffer-window "*w3m*")
      (pop-to-buffer "*w3m*")))

(defadvice eww-render (around eww-render-popwin activate)
  (save-window-excursion ad-do-it)
  (unless (get-buffer-window "*eww*")
    (pop-to-buffer "*eww*")))

(push "*eww*" popwin:special-display-config)
(push "*w3m*" popwin:special-display-config)
