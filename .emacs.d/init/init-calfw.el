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
