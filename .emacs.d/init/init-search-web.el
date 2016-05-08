;;; http://qiita.com/akisute3@github/items/8deb54b75b48e8b04cb0

(defun search-web-dwim (&optional arg-engine)
  "transient-mark-mode がオンの時はリージョンを，
オフの時はカーソル位置の単語を検索する．"
  (interactive)
  (cond
   ((transient-region-active-p)
    (search-web-region arg-engine))
   (t
    (search-web-at-point arg-engine))))

(require 'search-web)

(define-prefix-command 'search-web-map)
(global-set-key (kbd "M-I") 'search-web-map)
(global-set-key (kbd "M-I g") (lambda () (interactive) (search-web-dwim "google")))
(global-set-key (kbd "M-I e") (lambda () (interactive) (search-web-dwim "eijiro")))

;; 注
;; 検索結果を表示するブラウザは M-x customize-group で search-web を選択し，
;; Search Web Default Browser で設定する

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
