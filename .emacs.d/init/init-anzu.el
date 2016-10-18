(global-anzu-mode +1)

(custom-set-variables
 '(anzu-use-migemo nil)
 '(anzu-search-threshold 1024))

;;; キーマップを query-replace と query-replace-regexp に割り当て
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
