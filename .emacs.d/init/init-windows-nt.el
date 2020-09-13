;;; shell に zsh を使用する
;;; http://www.bookshelf.jp/soft/meadow_9.html#SEC50
(setq explicit-shell-file-name "zsh")
(setq shell-file-name "sh")
(setq shell-command-switch "-c")


;;; 環境変数 PATH の追加
(setenv "PATH"
		(concat "C:\\cygwin64\\opt\\texlive\\2020\\bin\\win32;"
				"C:\\Program Files\\R\\R-4.0.2\\bin;"
				"C:\\ProgramData\\Anaconda3\\Scripts;"
				"C:\\cygwin64\\usr\\local\\bin;"
				"C:\\cygwin64\\usr\\bin;"
				"C:\\cygwin64\\bin;"
				"C:\\msys64\\mingw64\\usr\\bin;"
				"C:\\msys64\\mingw64\\bin;"
				(concat (substitute-in-file-name "$HOME") "\\.gem\\ruby\\2.6.0\\gems\\taskjuggler-3.7.1\\bin;")
				(getenv "PATH")))

;;; Emacs 用に PATH に追加したディレクトリを exec-path にも追加
(setq exec-path
	  (append
	   (list
		"c:/cygwin64/opt/texlive/2020/bin/win32"
		"c:/Program Files/R/R-4.0.2/bin"
		"c:/ProgramData/Anaconda3"
		"c:/ProgramData/Anaconda3/Scripts"
		"c:/cygwin64/usr/local/bin"
		"c:/cygwin64/usr/bin"
		"c:/cygwin64/bin"
		"c:/msys64/usr/bin"
		"c:/msys64/bin"
		"~/.gem/ruby/2.6.0/gems/taskjuggler-3.7.1/bin"
		)
	   exec-path))


;;; for llvm
(setenv "DYLD_LIBRARY_PATH"
		(concat "C:\\msys64\\mingw64\\lib:"
				(getenv "DYLD_LIBRARY_PATH")))

(setenv "LDFLAGS" "-LC:\\msys64\\mingw64\\lib")
(setenv "CPPFLAGS" "-IC:\\msys64\\mingw64\\include")


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
(setq default-process-coding-system '(utf-8 . cp932))	; vc-svn で日本語ファイル名のファイルの文字化けを防ぐ(http://yoshimov.com/tips/windows-emacs-vc-git/)

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

;;; vc-git
;; コミットログの文字化けを防ぐ
;; http://moimoitei.blogspot.jp/2010/05/use-ntemacs-231x.html
(defadvice vc-git-checkin
    (around my-vc-git-checkin activate)
  (let ((files (ad-get-arg 0))
		(comment (ad-get-arg 2))
		(fname (make-temp-file "vc-git-")))
	(let ((buffer-file-coding-system 'utf-8-unix))
	  (with-temp-file fname (insert comment)))
	(vc-git-command nil 0 files "commit" "-F" fname "--only" "--")
	(delete-file fname)
	))


;; Cygwin のドライブ・プレフィックスを有効にする
(require 'cygwin-mount)
(cygwin-mount-activate)
(setq cygwin-mount-table--internal
	  '(("c:/" . "/cygdrive/c/") ("c:/cygwin64/lib/" . "/usr/lib/") ("c:/cygwin64/bin/" . "/usr/bin/") ("c:/cygwin64/" . "/")
		))

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


;;; dired で ! によるプログラムの起動に MS-Office ファイルの場合は cygstart を用いる
(add-to-list 'dired-guess-shell-alist-user '("\\.\\(xls\\|xlsx\\|xlsm\\)" "cygstart"))
(add-to-list 'dired-guess-shell-alist-user '("\\.\\(ppt\\|pptx\\)" "cygstart"))
(add-to-list 'dired-guess-shell-alist-user '("\\.\\(doc\\|docx\\)" "cygstart"))


;;; ispell
(setq ispell-alternate-dictionary "/usr/share/dict/words")



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
