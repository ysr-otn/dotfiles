;;; 天気予報取得サービス wttr.in を用いてコマンドラインで天気を取得する機能を
;;; 用いて Emacs 上から天気予報を取得
;;; https://github.com/bcbcarl/emacs-wttrin

;;; デフォルトの都市を設定
(setq wttrin-default-cities '("Osaka"))

;;; 日本語の設定
(setq wttrin-default-accept-language '("Accept-Language" . "ja"))
