;;; https://qiita.com/yuttie/items/0f38870817c11b2166bd
(require 'initchart)

;; initchart で測定する関数の設定
;; 起動後 *initchart* バッファに起動時間が記録され，initchart-visualize-init-sequence で
;; svg ファイルで起動時間を視覚化できる
(initchart-record-execution-time-of load file)
(initchart-record-execution-time-of require feature)
