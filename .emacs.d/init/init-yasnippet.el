;;; http://keisanbutsuriya.hateblo.jp/entry/2015/12/12/181028
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"			   ;; 自作スニペット
        yas-installed-snippets-dir         ;; package に最初から含まれるスニペット
        ))
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)
