(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)

(setq ac-use-menu-map t)
(setq ac-delay 0.1) ; auto-completeまでの時間
(setq ac-auto-show-menu 0.2) ; メニューが表示されるまで
(setq ac-use-fuzzy t) ; 曖昧検索
(global-set-key "\M-/" 'ac-start)

(require 'ac-helm)
(define-key ac-complete-mode-map (kbd "C-c a") 'ac-complete-with-helm)


;;; look を用いた英単語の auto-complete インタフェース
;;; http://d.hatena.ne.jp/kitokitoki/20101205/p2

(defun my-ac-look ()
  "look コマンドの出力をリストで返す"
  (interactive)
  (unless (executable-find "look")
    (error "look コマンドがありません"))
  (let ((search-word (thing-at-point 'word)))
    (with-temp-buffer
      (call-process-shell-command "look" nil t 0 search-word)
      (split-string-and-unquote (buffer-string) "\n"))))

(defun ac-complete-look ()
  (interactive)
  (let ((ac-menu-height 50)
        (ac-candidate-limit t))
  (auto-complete '(ac-source-look))))

;; 表示数制限を変更しない場合
;;(defun ac-complete-look ()
;;  (interactive)
;;  (auto-complete '(ac-source-look)))

(defvar ac-source-look
  '((candidates . my-ac-look)
    (requires . 2)))  ;; 2文字以上ある場合にのみ対応させる

;; ac-complete-look のキーバインドを設定
(global-set-key (kbd "C-c i") 'ac-complete-look)

;;; 自動的に look による入力補完をするための設定
; (setq ac-source-look
;   '((candidates . my-ac-look)
;     (requires . 2)))  ;; 4文字以上の入力のみ対象とするように変更. 2 だと候補が多すぎてうっとうしい
; 
; (push 'ac-source-look ac-sources) ;追加
