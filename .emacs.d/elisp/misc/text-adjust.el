;;
;; text-adjust.el $BF|K\8l$NJ8>O$r@07A$9$k(B. 
;;
;;  By $B>.>>909,(B  Hiroyuki Komatsu <komatsu@taiyaki.org>
;;
;; $B$3$N%3!<%I$O(B GPL $B$K=>$C$FG[I[2DG=$G$9(B. (This is GPLed software.)
;; 
;; $B"#%$%s%9%H!<%kJ}K!(B
;; 1) $BE,Ev$J%G%#%l%/%H%j$K$3$N%U%!%$%k$H(B mell.el $B$r$*$/(B.
;;    (~/elisp/ $BFb$K$*$$$?$H$9$k(B). mell.el $B$N0l85G[I[85$O(B
;;    http://www.taiyaki.org/elisp/mell/ $B$G$9(B.
;;
;; 2) .emacs $B$K<!$N(B 2 $B9T$rDI2C$9$k(B.
;; (setq load-path (cons (expand-file-name "~/elisp") load-path))
;; (load "text-adjust")
;; 
;; $B"#;H$$J}(B
;; 1) M-x text-adjust $B$r<B9T$9$k$HJ8>O$,@07A$5$l$k(B.
;; 2) $B;HMQ2DG=$J4X?t$N35MW(B.
;;     text-adjust-codecheck : $BH>3Q%+%J(B, $B5,3J30J8;z$r!V".!W$KCV$-49$($k(B.
;;     text-adjust-hankaku   : $BA43Q1Q?tJ8;z$rH>3Q$K$9$k(B.
;;     text-adjust-kutouten  : $B6gFIE@$r!V(B, $B!W!V(B. $B!W$KCV$-49$($k(B.
;;     text-adjust-space     : $BA43QJ8;z$HH>3QJ8;z$N4V$K6uGr$rF~$l$k(B.
;;     text-adjust           : $B$3$l$i$r$9$Y$F<B9T$9$k(B.
;;     text-adjust-fill      : $B6gFIE@M%@h$G(B, fill-region $B$r$9$k(B.
;;    $BE,1~HO0O$O%j!<%8%g%s$,$"$k>l9g$O$=$NHO0O$r(B,
;;    $B$J$1$l$P(B mark-paragraph $B$GF@$i$l$?CM(B. 
;;
;;     *-region : $B>e5-4X?t$r%j!<%8%g%sFb$G<B9T$9$k(B.
;;     *-buffer : $B>e5-4X?t$r%P%C%U%!Fb$G<B9T$9$k(B.
;; 
;;
;; $B"#(BTips
;; 1) $B<!$N$h$&$K@_Dj$9$k$H(B, text-adjust-fill-region $B<B9T;~$K(B, 
;;  $B:8%^!<%8%s$,9MN8$5$l$k(B.
;;  | (setq adaptive-fill-regexp "[ \t]*")
;;  | (setq adaptive-fill-mode t)
;;
;; 2) $B!)!*$dA43Q6uGr$rH>3Q$XJQ49$7$J$$$h$&$K$9$k$K$O(B.
;;  text-adjust-hankaku-except $B$KJ8;z$rDI2C$9$l$P2DG=$K$J$j$^$9(B.
;;  | (setq text-adjust-hankaku-except "$B!!!)!*!w!<!A!"!$!#!%(B")
;;

(require 'mell)

(defvar text-adjust-hankaku-except "$B!w!<!A!"!$!#!%(B"
  "text-adjust-hankaku $B$GH>3Q$K$5$l$?$/$J$$J8;zNs(B. $B@55,I=8=$G$O$J$$(B.")

;; text-adjust-rule $B$N%U%)!<%^%C%H$O(B
;; (("$B:8C<J8;zNs(B" "$BBP>]J8;zNs(B" "$B1&C<J8;zNs(B") "$BJQ49J8;zNs(B") $B$H$$$&9=@.$N(B
;; $B%j%9%H$G$9(B. "$B:8C<J8;zNs(B", "$BBP>]J8;zNs(B", "$B1&C<J8;zNs(B" $B$O@55,I=8=$G(B
;; $B5-=R2DG=$G$3$N(B 3 $B$D(B $B$rO"7k$7$?J8;zNs$K%^%C%A$7$?8D=j$rJQ49BP>]$H$7(B, 
;; "$BBP>]J8;zNs(B" $B$r(B "$BJQ49J8;zNs(B" $B$XJQ49$7$^$9(B.
;;
;; $B"#Nc(B1
;; (("$BCKEr(B" " " "$B=wEr(B")   "|$BJI(B|")
;; $BJQ49A0(B = "$BCKEr(B $B=wEr(B",  $BJQ498e(B = "$BCKEr(B|$BJI(B|$B=wEr(B"
;;
;; $B"#Nc(B2
;; ((("\\cj"        "" "[0-9a-zA-Z]")   " ")
;;  (("[0-9a-zA-Z]" "" "\\cj")          " "))
;; $BJQ49A0(B = "You$B$O(BShoooock!",  $BJQ498e(B = "You $B$O(B Shoooock!"
;;
;; "$BJQ49J8;zNs(B" $B$G$O(B "{", "}" $B$rMQ$$$?FH<+5-K!$K$h$C$FBP>]J8;zNs$r(B
;; $B;2>H$9$k$3$H$,2DG=$G$9(B. "{1}", "{2}", "{3}" $B$O$=$l$>$l=g$K(B "$B:8C<J8;zNs(B",
;; "$BBP>]J8;zNs(B", "$B1&C<J8;zNs(B" $B$NA4BN$rI=$o$7(B, "{2-3}" $B$O(B "$BBP>]J8;zNs(B" $B$N(B
;; 3 $BHVL\$N@55,I=8=$N3g8L$KBP1~$7$^$9(B. $B$^$?(B, "{1}" $B$H(B "{1-0}" $B$OF1CM$G$9(B.
;;
;; $B"#Nc(B3
;; (("$B7n(B" "$B2P?eLZ(B" "$B6b(B") "{1}{2}{3}")
;; $BJQ49A0(B = "$B7n2P?eLZ6b(B", $BJQ498e(B = "$B7n7n2P?eLZ6b6b(B"
;;
;; $B"#Nc(B4
;; (("" "\\(.$B%s(B\\)\\(.$B%s(B\\)" "") "{2-2}{2-1}")
;; $BJQ49A0(B = "$BLkL@$1$N%,%s%^%s(B", $BJQ498e(B = "$BLkL@$1$N%^%s%,%s(B"
;;
;; text-adjust-mode-skip-rule $B$O3F%b!<%I$KFC2=$7$?FC<lJQ49%k!<%k$G(B, 
;; $B<g$KJQ49$r$5$;$?$/$J$$8D=j$r%9%-%C%W$9$kL\E*$GMQ0U$5$l$F$$$^$9(B.
;; text-adjust-rule-space, text-adjust-rule-kutouten, 
;; text-adjust-rule-codecheck $B$N$=$l$>$l$N@hF,$KDI2C$5$l$?$N$A(B, $B<B9T$5$l$^$9(B.


;; $BF|K\8lMQ@55,I=8=(B (M-x describe-category $B$r;2>H(B)
;\\cK $B%+%?%+%J(B
;\\cC $B4A;z(B
;\\cH $B$R$i$,$J(B
;\\cS $BA43Q5-9f(B
;\\cj $BF|K\8l(B ($B>e5-A4It(B)
;\\ck $BH>3Q%+%J(B
(defvar text-adjust-rule-space 
  '((("\\cj\\|)" "" "[[(0-9a-zA-Z+]")   " ")
    (("[])/!?0-9a-zA-Z+]" "" "(\\|\\cj") " "))
  "$BCV49$9$k6uGr$NJQ49%k!<%k(B.")

(defvar text-adjust-rule-kutouten-hperiod
  '((("\\cA\\|\\ca" "$B!%(B" "\\cA\\|\\ca")   ".")
    (("" "[$B!"!$(B] ?\\([)$B!W!Y(B]?\\) *" "$")  "{2-1},")
    (("" "[$B!"!$(B] ?\\([)$B!W!Y(B]?\\) ?" "")   "{2-1}, ")
    (("" "[$B!#!%(B] ?\\([)$B!W!Y(B]?\\) *" "$")  "{2-1}.")
    (("" "[$B!#!%(B] ?\\([)$B!W!Y(B]?\\) ?" "")   "{2-1}. ")
    )
  "$B!V(B,.$B!WMQ(B, $B6gFIE@$NJQ49%k!<%k(B.")

(defvar text-adjust-rule-kutouten-zperiod
  '((("" "$B!"(B ?\\([)$B!W!Y(B]?\\)" "")     "{2-1}$B!$(B")
    (("" "$B!#(B ?\\([)$B!W!Y(B]?\\)" "")     "{2-1}$B!%(B")
    (("\\cj" ", ?\\([)$B!W!Y(B]?\\)" "")   "{2-1}$B!$(B")
    (("\\cj" "\\. ?\\([)$B!W!Y(B]?\\)" "") "{2-1}$B!%(B"))
  "$B!V!$!%!WMQ(B, $B6gFIE@$NJQ49%k!<%k(B.")

(defvar text-adjust-rule-kutouten-zkuten
  '((("" "$B!$(B ?\\([)$B!W!Y(B]?\\)" "")     "{2-1}$B!"(B")
    (("" "$B!%(B ?\\([)$B!W!Y(B]?\\)" "")     "{2-1}$B!#(B")
    (("\\cj" ", ?\\([)$B!W!Y(B]?\\)" "")   "{2-1}$B!"(B")
    (("\\cj" "\\. ?\\([)$B!W!Y(B]?\\)" "") "{2-1}$B!#(B"))
  "$B!V!"!#!WMQ(B, $B6gFIE@$NJQ49%k!<%k(B.")

(defvar text-adjust-rule-kutouten text-adjust-rule-kutouten-hperiod
  "$BCV49$9$k6gFIE@$NJQ49%k!<%k(B.
nil $B$N>l9g(B, $B%P%C%U%!$4$H$KA*Br2DG=(B.")

(defvar text-adjust-rule-codecheck
  '((("" "\\ck\\|\\c@" "") "$B".(B")
    ))

(defvar text-adjust-mode-skip-rule '((sgml-mode . ((("<" "[^>]*" ">") "{2}")
						   ))))

;(defvar text-adjust-fill-regexp ", \\|\\. \\|! \\|\\? \\|$B$r(B\\| ")
;(defvar text-adjust-fill-regexp "[,.!?] \\|[$B$r(B ]"
(defvar text-adjust-fill-regexp "[,!] \\|[$B$r(B ]"
  "$B$3$N@55,I=8=$N<!$GM%@h$7$F2~9T$9$k(B.")
(defvar text-adjust-fill-start 60
  "$B3F9T$H$b(B, $B$3$NCM$+$i(B fill-column $B$^$G$NCM$^$G$,(B\
 text-adjust-fill $B$NM-8zHO0O(B.")

(global-set-key [(meta zenkaku-hankaku)] 'text-adjust)


;;;; text-adjust
(defun text-adjust (&optional force-kutouten-rule)
  "$BF|K\8lJ8>O$r@07A$9$k(B.
$B3F4X?t(B text-adjust-codecheck, text-adjust-hankaku, text-adjust-kutouten,
text-adjust-space $B$r=g$K<B9T$9$k$3$H$K$h$j(B,
$B1Q?t;z8r$8$j$NF|K\8lJ8>O$r@07A$9$k(B.
$B%j!<%8%g%s$N;XDj$,$"$C$?>l9g$O$=$NHO0O$r(B, $B$J$1$l$P(B mark-paragraph $B$K$h$C$F(B
$BF@$i$l$?HO0O$rBP>]$K$9$k(B."
  (interactive "P")
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-region (region-beginning) (region-end) force-kutouten-rule)))

(defun text-adjust-buffer (&optional force-kutouten-rule)
  "$B%P%C%U%!Fb$G4X?t(B text-adjust $B$r<B9T$9$k(B."
  (interactive "P")
  (text-adjust-region (point-min) (point-max) force-kutouten-rule))

(defun text-adjust-region (from to &optional force-kutouten-rule) 
  "$B%j!<%8%g%sFb$G4X?t(B text-adjust $B$r<B9T$9$k(B."
  (interactive "r\nP")
  (text-adjust-kutouten-read-rule force-kutouten-rule)
  (save-restriction
    (narrow-to-region from to)
    (text-adjust-codecheck-region (point-min) (point-max))
    (text-adjust-hankaku-region (point-min) (point-max))
    (text-adjust-kutouten-region (point-min) (point-max))
    (text-adjust-space-region (point-min) (point-max))
;    (text-adjust-fill)
    ))


;;;; text-adjust-codecheck
;;;; jischeck.el $B$h$j0zMQ(B
;;
;; jischeck.el 19960827+19970214+19980406
;;     By TAMURA Kent <kent@muraoka.info.waseda.ac.jp>
;;      + akira yamada <akira@linux.or.jp>
;;      + Takashi Ishioka <ishioka@dad.eec.toshiba.co.jp>

;; JIS X 0208-1983 $B$GL58z$JHO0O(B($B?tCM$O(B ISO-2022-JP $B$G$NCM(B):
;;  1,2 Byte$BL\$,(B 0x00-0x20, 0x7f-0xff
;;  1 Byte$BL\(B:  0x29-0x2f, 0x75-0x7e
;;
;; $B:Y$+$$$H$3$m$G$O(B:
;;  222f-2239, 2242-2249, 2251-225b, 226b-2271, 227a-227d
;;  2321-232f, 233a-2340, 235b-2360, 237b-237e
;;  2474-247e,
;;  2577-257e,
;;  2639-2640, 2659-267e,
;;  2742-2750, 2772-277e,
;;  2841-287e,
;;  4f54-4f7e,
;;  7425-747e,
;;
;;;; $B0zMQ=*$o$j(B.

;;;; 1 byte $BL\$,(B 0x29-0x2f, 0x75-0x7e $B$NJ8;z$K$N$_BP1~(B.
(or (if running-xemacs
	(defined-category-p ?@)
      (category-docstring ?@))
    (let ((page 41))
      (define-category ?@ "invalid japanese char category")
      (while (<= page 126)
	(if running-xemacs
	    (modify-category-entry `[japanese-jisx0208 ,page] ?@)
	  (modify-category-entry (make-char 'japanese-jisx0208 page) ?@))
	(setq page 
	      (if (= page 47) 117 (1+ page))))))

(defun text-adjust-codecheck (&optional from to)
  "$BL58z$JJ8;z%3!<%I$r(B text-adjust-codecheck-alarm $B$KCV$-49$($k(B.

$B%j!<%8%g%s$N;XDj$,$"$C$?>l9g$O$=$NHO0O$r(B, $B$J$1$l$P(B mark-paragraph $B$K$h$C$F(B
$BF@$i$l$?HO0O$rBP>]$K$9$k(B."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-codecheck-region (region-beginning) (region-end))))

(defun text-adjust-codecheck-buffer ()
  "$B%P%C%U%!Fb$G4X?t(B text-adjust-jischeck $B$r<B9T$9$k(B."
  (interactive)
  (text-adjust-codecheck-region (point-min) (point-max)))

(defun text-adjust-codecheck-region (from to)
  "$B%j!<%8%g%sFb$G4X?t(B text-adjust-jischeck $B$r<B9T$9$k(B."
  (interactive "r")
  (text-adjust--replace text-adjust-rule-codecheck from to))


;;;; text-adjust-hankaku
(defun text-adjust-hankaku ()
  "$BA43Q1Q?tJ8;z$rH>3Q$K$9$k(B.

$B%j!<%8%g%s$N;XDj$,$"$C$?>l9g$O$=$NHO0O$r(B, $B$J$1$l$P(B mark-paragraph $B$K$h$C$F(B
$BF@$i$l$?HO0O$rBP>]$K$9$k(B."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-hankaku-region (region-beginning) (region-end))))

(defun text-adjust-hankaku-buffer ()
  "$B%P%C%U%!Fb$G4X?t(B text-adjust-hankaku $B$r<B9T$9$k(B."
  (interactive)
  (text-adjust-hankaku-region (point-min) (point-max)))

(defun text-adjust-hankaku-region (from to) 
  "$B%j!<%8%g%sFb$G4X?t(B text-adjust-hankaku $B$r<B9T$9$k(B."
  (interactive "r")
  (require 'japan-util)
  (save-excursion
    (let ((tmp-table (text-adjust--copy-char-table char-code-property-table)))
      (text-adjust--modify-char-table ?$B!!(B (list 'ascii "  "))
      (mapcar '(lambda (c) (text-adjust--modify-char-table c nil))
       (string-to-list text-adjust-hankaku-except))
      (japanese-hankaku-region from to t)
      (setq char-code-property-table 
	    (text-adjust--copy-char-table tmp-table)))))

(defun text-adjust--modify-char-table (range value)
  (if running-xemacs
      (put-char-table range value char-code-property-table)
    (set-char-table-range char-code-property-table range value)))

(defun text-adjust--copy-char-table (table)
  (if running-xemacs
      (copy-char-table table)
    (copy-sequence table)))


;;;; text-adjust-kutouten
(defun text-adjust-kutouten (&optional forcep)
  "$B6gFIE@$rJQ49$9$k(B.
$B6gE@$r(B text-adjust-kuten-from $B$+$i(B text-adjust-kuten-to $B$NCM$K(B,
$BFIE@$r(B text-adjust-touten-from $B$+$i(B text-adjust-touten-to $B$NCM$KJQ49$9$k(B.

$B%j!<%8%g%s$N;XDj$,$"$C$?>l9g$O$=$NHO0O$r(B, $B$J$1$l$P(B mark-paragraph $B$K$h$C$F(B
$BF@$i$l$?HO0O$rBP>]$K$9$k(B."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-kutouten-region (region-beginning) (region-end) forcep)))

(defun text-adjust-kutouten-buffer (&optional forcep)
  "$B%P%C%U%!Fb$G4X?t(B text-adjust-kutouten $B$r<B9T$9$k(B."
  (interactive "P")
  (text-adjust-kutouten-region (point-min) (point-max) forcep))

(defun text-adjust-kutouten-region (from to &optional forcep)
  "$B%j!<%8%g%sFb$G4X?t(B text-adjust-kutouten $B$r<B9T$9$k(B."
  (interactive "r\nP")
  (text-adjust-kutouten-read-rule forcep)
  (text-adjust--replace text-adjust-rule-kutouten from to))

(defun text-adjust-kutouten-read-rule (&optional forcep)
  "$BJQ498e$N6gFIE@$rA*Br$9$k(B."
  (interactive)
  (if (and text-adjust-rule-kutouten (not forcep) (not (interactive-p)))
      text-adjust-rule-kutouten
    (make-local-variable 'text-adjust-rule-kutouten)
    (setq text-adjust-rule-kutouten
	  (symbol-value
	   (let ((kutouten-alist 
		  '(("kuten-zenkaku"  . text-adjust-rule-kutouten-zkuten)
		    ("zenkaku-kuten"  . text-adjust-rule-kutouten-zkuten)
		    ("$B!"!#(B"           . text-adjust-rule-kutouten-zkuten)
		    ("period-zenkaku" . text-adjust-rule-kutouten-zperiod)
		    ("zenkaku-period" . text-adjust-rule-kutouten-zperiod)
		    ("$B!$!%(B"           . text-adjust-rule-kutouten-zperiod)
		    ("period-hankaku" . text-adjust-rule-kutouten-hperiod)
		    ("hankaku-period" . text-adjust-rule-kutouten-hperiod)
		    (",."             . text-adjust-rule-kutouten-hperiod))))
	     (cdr (assoc
		   (completing-read "$B6gFIE@$N<oN`(B: " kutouten-alist
				    nil t ",.")
		   kutouten-alist)))))))

;;;; text-adujst-space
(defun text-adjust-space ()
  "$BH>3Q1Q?t$HF|K\8l$N4V$K6uGr$rA^F~$9$k(B.
text-adjust-japanese $B$GDj5A$5$l$?F|K\8lJ8;z$r<($9@55,I=8=$H(B,
text-adjust-ascii $B$GDj5A$5$l$?H>3Q1Q?tJ8;z$r<($9@55,I=8=$H$N4V$K(B
$B6uGr$rA^F~$9$k(B.

$B%j!<%8%g%s$N;XDj$,$"$C$?>l9g$O$=$NHO0O$r(B, $B$J$1$l$P(B mark-paragraph $B$K$h$C$F(B
$BF@$i$l$?HO0O$rBP>]$K$9$k(B."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-space-region (region-beginning) (region-end))))

(defun text-adjust-space-buffer () 
  "$B%P%C%U%!Fb$G4X?t(B text-adjust-space $B$r<B9T$9$k(B."
  (interactive)
  (text-adjust-space-region (point-min) (point-max)))
  
(defun text-adjust-space-region (from to) 
  "$B%j!<%8%g%sFb$G4X?t(Btext-adjust-space$B$r<B9T$9$k(B."
  (interactive "r")
  (text-adjust--replace text-adjust-rule-space from to))


;;;; text-adjust-fill
(defun text-adjust-fill ()
  "$B6gFIE@$G$N2~9T$rM%@h$7$F(B, fill-region $B$r<B9T$9$k(B.
$B3F9T$N(B text-adjust-fill-start $B$+$i(B, fill-column $B$^$G$N4V$K(B,
text-adjust-fill-regexp $B$,:G8e$K4^$^$l$F$$$k$H$3$m$G2~9T$9$k(B.

$B%j!<%8%g%s$N;XDj$,$"$C$?>l9g$O$=$NHO0O$r(B, $B$J$1$l$P(B mark-paragraph $B$K$h$C$F(B
$BF@$i$l$?HO0O$rBP>]$K$9$k(B."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-fill-region (region-beginning) (region-end))))

(defun text-adjust-fill-buffer () 
  "$B%P%C%U%!Fb$G4X?t(B text-adjust-fill $B$r<B9T$9$k(B."
  (interactive)
  (text-adjust-fill-region (point-min) (point-max)))
  
(defun text-adjust-fill-region (from to) 
  "$B%j!<%8%g%sFb$G4X?t(B text-adjust-fill $B$r<B9T$9$k(B."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region from to)
      (let ((kinsoku-tmp kinsoku-ascii)
	    (prefix (if adaptive-fill-mode (fill-context-prefix from to) "")))
	(setq kinsoku-ascii t)
	(fill-region (point-min) (point-max))
	(goto-char (point-min))
	(while (/= (line-end-position) (point-max))
	  (move-to-column text-adjust-fill-start)
	  (if (and (re-search-forward
		    (concat "\\(" text-adjust-fill-regexp 
			    "\\) *[^" text-adjust-fill-regexp "]*$")
		    (line-end-position) t))
	      (progn
		(goto-char (match-end 1))
		(delete-horizontal-space)
		(if (eolp)
		    (beginning-of-line 2)
		  (progn
		    (insert (concat "\n" prefix))
		    (beginning-of-line)
		    )))
	    (beginning-of-line 2))
	  (narrow-to-region (point) (point-max))
	  (fill-region (point-min) to nil nil t)
	  (goto-char (point-min)))
	(delete-horizontal-space)
	(setq kinsoku-ascii kinsoku-tmp)))))


;;;; text-adjust engine
(defun text-adjust--replace (rule from to)
  (save-excursion
    (save-restriction
      (narrow-to-region from to)
      (goto-char (point-min))
      (let* ((rule-pattern 
	      (text-adjust--make-rule-pattern 
	       (append (cdr (assoc major-mode text-adjust-mode-skip-rule)) 
		       rule)))
	     (regexp (nth 0 rule-pattern))
	     (target (nth 1 rule-pattern))
	     (counts (nth 2 rule-pattern)))
	(while (re-search-forward regexp nil t)
	  (let ((n 1) (m 0) right-string)
	    ; $B3:Ev%Q%?!<%s$^$G$9$9$a$k(B
	    (while (not (match-beginning n))
	      (setq n (+ n 3 (mapadd (nth m counts)))
		    m (1+ m)))
	    ; $B3:Ev%Q%?!<%s$HCV49$9$k(B
	    (let* ((tmp n)
		   (total-counts 
		    (cons n (mapcar (lambda (x) (setq tmp (+ tmp x 1)))
				    (nth m counts))))
		   (right-string (match-string (nth 2 total-counts))))
	      (replace-match 
	       (concat 
		;; $B3:Ev%Q%?!<%s$N:8B&(B
		(match-string n)
		;; $B3:Ev%Q%?!<%s$N$^$sCf(B ($BCV49ItJ,(B)
		(mapconcat
		 (lambda (x) 
		   (if (stringp x) x
		     (match-string (+ (nth (1- (car x)) total-counts) 
				      (cdr x)))))
		 (nth m target) "")
		;; $B3:Ev%Q%?!<%s$N1&B&(B
		right-string))
	      ;; "$B$"(Ba$B$"(Ba" $B$N$h$&$K0lJ8;z$:$D$GJB$s$G$$$k;~$NBP=h(B
	      (backward-char (length right-string))))))
      )))

(defun text-adjust--make-rule-pattern (rule)
  (let ((regexp (mapconcat 
		 (lambda (x) 
		   (format "\\(%s\\)\\(%s\\)\\(%s\\)"
			   (nth 0 (car x)) (nth 1 (car x)) (nth 2 (car x))))
		 rule "\\|"))
	(target (mapcar 
		 (lambda (x)
		   (text-adjust--parse-replace-string (nth 1 x)))
		 rule))
	(counts (mapcar
		 (lambda (x)
		   (list (count-string-match "\\\\(" (nth 0 (car x)))
			 (count-string-match "\\\\(" (nth 1 (car x)))
			 (count-string-match "\\\\(" (nth 2 (car x)))))
		 rule)))
    (list regexp target counts)))

(defun text-adjust--parse-replace-string (rule)
  (let ((n 0) m list)
    (while (string-match "\\([^{]*\\){\\([^}]+\\)}" rule n)
      (setq n (match-end 0))
      (let ((match1 (match-string 1 rule))
	    (match2 (match-string 2 rule)))
	(cond ((string-match "^[0-9]+\\(-[0-9]+\\)?$" match2)
	       (or (string= match1 "") (setq list (cons match1 list)))
	       (let* ((tmp (split-string match2 "-"))
		      (num (cons (string-to-number (car tmp))
				 (string-to-number (or (nth 1 tmp) "0")))))
		 (setq list (cons num list))))
	      (t
	       (setq list (cons match2 (cons match1 list)))))))
    (reverse (cons (substring rule n) list))))


(provide 'text-adjust)
; $Id: text-adjust.el,v 1.1.1.1 2002/08/25 14:24:48 komatsu Exp $
