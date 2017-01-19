;;; shell に zsh を使用する
;;; http://www.bookshelf.jp/soft/meadow_9.html#SEC50
(setq explicit-shell-file-name "zsh")
(setq shell-file-name "sh")
(setq shell-command-switch "-c")


;;; 各種の言語設定を UTF-8 を基準にし，Shell, Grep の文字コード設定をする
;;; https://skalldan.wordpress.com/2011/11/09/ntemacs-%E3%81%A7-utf-8-%E3%81%AA%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89%E3%82%92%E8%A9%A6%E8%A1%8C%E9%8C%AF%E8%AA%A4/
;; LANG 設定
(setenv "LANG" "ja_JP.UTF-8")

;; 言語環境
(set-language-environment "Japanese")

;; 文字コード
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-16le-dos)

;; Grep
(defadvice grep (around grep-coding-setup activate)
  (let ((coding-system-for-read 'utf-8))
    ad-do-it))
(setq grep-command "lgrep -n -Au8 -Ia ")
(setq grep-program "lgrep")
(setq grep-find-command "find . -type f -print0 | xargs -0 lgrep -n -Au8 -Ia ")

;;; Shell
(setq shell-mode-hook
      (function (lambda()
                  (set-buffer-process-coding-system 'utf-8-unix
                                                    'utf-8-unix))))

;; Cygwin のドライブ・プレフィックスを有効にする
;(require 'cygwin-mount)
;(cygwin-mount-activate)
;(setq cygwin-mount-table--internal
;	  '(("c:/" . "/cygdrive/c/") ("c:/cygwin64/lib/" . "/usr/lib/") ("c:/cygwin64/bin/" . "/usr/bin/") ("c:/cygwin64/" . "/")
;		))

;;; dired-mode 時の fiber により Windows によってファイルに関連付けされたアプリの起動
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map
              "e" 'dired-fiber-find)))

(defun dired-fiber-find ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (start-process "explorer" "diredfiber" "explorer.exe"
                       (unix-to-dos-filename file))
      (start-process "fiber" "diredfiber" "fiber.exe" file))))



;;; NTEmacsでスクリプトを実行する
;(require 'nt-script)


;;; Windows 機種依存文字を表示する方法
;;; http://www.ysnb.net/meadow/meadow-users-jp/2012/msg00010.html

;; 「丸付き数字」「はしごだか」が入った JISメールを読むための設定
(coding-system-put 'iso-2022-jp :decode-translation-table
       '(cp51932-decode japanese-ucs-cp932-to-jis-map))

;; 「丸付き数字」「はしごだか」が入った JISメールを送るための設定
;; 以下設定をしない場合は、本来の utf-8 で送付 (消極 Windows派になる)
(coding-system-put 'iso-2022-jp :encode-translation-table
      '(cp51932-encode))

;; 「丸付き数字」「はしごだか」が入った shift-jis のファイルを
;; 保存できるようにする
(coding-system-put 'japanese-shift-jis :decode-translation-table
       '(cp51932-decode japanese-ucs-cp932-to-jis-map))
(coding-system-put 'japanese-shift-jis :encode-translation-table
      '(cp51932-encode))


;; 「丸付き数字」「はしごだか」が入った euc-jp のファイルを
;; 保存できるようにする
(coding-system-put 'euc-jp :decode-translation-table
       '(cp51932-decode japanese-ucs-cp932-to-jis-map))
(coding-system-put 'euc-jp :encode-translation-table
      '(cp51932-encode))


;; 全角チルダ/波ダッシュをWindowsスタイルにする
(let ((table (make-translation-table-from-alist '((#x301c . #xff5e))) ))
  (mapc
   (lambda (coding-system)
     (coding-system-put coding-system :decode-translation-table table)
     (coding-system-put coding-system :encode-translation-table table)
     )
   '(utf-8 cp932 utf-16le)))


;;; font
; 「msgochic」という名前で新たなフォントセットを定義
; 英字フォントとしてＭＳ ゴシック、12ポイントを使用
(create-fontset-from-ascii-font
 "-outline-ＭＳ ゴシック-normal-r-normal-normal-12-*-*-*-*-*-iso8859-1"
 nil "msgochic")

; myfont-msgochicの日本語フォントとしてメイリオを使用
(set-fontset-font "fontset-msgochic"
                  'japanese-jisx0208
				  '("ＭＳ ゴシック" . "jisx0208-sjis"))

; myfont-msgochicのカタカナフォントとしてメイリオを使用
(set-fontset-font "fontset-msgochic"
                  'katakana-jisx0201
                  '("ＭＳ ゴシック" . "jisx0201-katakana"))

; 定義したフォントセットを登録
(add-to-list 'default-frame-alist
			 '(font . "fontset-msgochic"))

;;; frame
(setq default-frame-alist
      (append (list
				'(width . 124)
				'(height . 92)
				'(top		. 0)
				'(left		. 0)
				'(foreground-color . "white")
				'(background-color . "black")
				'(cursor-color . "turquoise3")
				'(font . "fontset-msgochic")    ; 通常のフォント
;				'(ime-font . (w32-logfont; 変換待ち中のフォント設定
;							  "ms-gothic9"
;							  0 -12 400 0 nil nil nil
;							  128 1 3 49))
				
				)
			  default-frame-alist))
