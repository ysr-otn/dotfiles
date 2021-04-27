(require 'calfw)
(require 'calfw-org)

;; Month
(setq calendar-month-name-array
  ["1(Jan)" "2(Feb)" "3(Mar)" "4(Apr)"  "5(May)"  "6(Jun)"
   "7(Jul)" "8(Aug)" "9(Sep)" "10(Oct)" "11(Nov)" "12(Dec)"])

;; Week days
(setq calendar-day-name-array
      ["日(Sun)" "月(Mon)" "火(Tue)" "水(Wed)" "木(Thu)" "金(Fri)" "土(Sat)"])

;; First day of the week
(setq calendar-week-start-day 0) ; 0:Sunday, 1:Monday

;;; しょぼいカレンダーの設定(M-x syb:open-calendar-syobocal で起動)
(load "calfw-syobocal.el")
;;; サンテレビ，NHK 総合，E テレ，MBS, ABC, 関西 TV，読売テレビ，テレビ大阪，
;;; NHK-BS1，NHK-BS2，BS-TBS，BSフジ，BS朝日，BS日テレ，BS11イレブン
(setq syb:channels "58,1,2,48,67,70,54,28,9,10,16,17,18,71,128")
