;;; インデント関数
(defun abbrev-indent ()
  ""
  (interactive)
  (previous-line 1)
  (c-indent-command)
  (next-line 1)
  (c-indent-command)
  (search-backward "(" nil t nil)
  (forward-char)
  )

;;; c, c++ 専用補完定義
(setq c-mode-default-abbrev-table 
  '(
	;; 制御構文
    ("if" "if()
{
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("i" "if()" (lambda nil (backward-char 1)) 2)
    ("el" "else
{
}" 
	 (lambda nil (previous-line 1) (c-indent-command) (next-line 1) 
	   (c-indent-command) (search-backward "else") (forward-char 4)) 0)
    ("e" "else" nil 2)
    ("ei" "else if()
{
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("wh" "while()
{
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("w" "while()" (lambda nil (backward-char 1)) 2)
    ("fo" "for(;;)
{
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("f" "for(;;)" (lambda nil (backward-char 3)) 2)
    ("sw" "switch()
{
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("ca" "case :
break;" 
	 (lambda nil (backward-char 10) (c-indent-command) (next-line 1) 
	   (c-indent-command) (search-backward ":" nil t nil) (backward-delete-char 1)) 2)
    ("b" "break;" nil 2)
    ("de" "default:
break;" (lambda nil (c-indent-command) (backward-char 10)) 2)
    ("r" "return;" (lambda nil (backward-char 1)) 2)
	 
    ;; コメントアウト
    ("l" "/*  */" (lambda nil (c-indent-command) (search-backward " */" nil t nil) 
					(backward-char 0)) 2)
	("ll" "/********************************************************
 * 
 ********************************************************/" 
	 (lambda nil (previous-line 1)) 2)
    
	;; 型定義
    ("d" "double" nil 2)
	("u" "unsigned" nil 2)
    ("o" "\"\"" (lambda nil (backward-char 1)) 2)

    ;; 構造体
	("st" "struct {
};" 
	 (lambda nil (backward-char 4) (c-indent-command) 2) 0)	
	
	;; マクロ
    ("in" "#include" nil 2)
    ("df" "#define" nil 2)
	("id" "#ifdef" nil 2)
    ("nd" "#ifndef" nil 2)
    ("en" "#endif" nil 2)
    ("n" "NULL" nil 2)

	
	;; 関数
    ("p" "printf(\"\");" (lambda nil (backward-char 3)) 2)
    ("pn" "printf(\"\\n\");" (lambda nil (backward-char 5)) 2)
	("dpn" "dbgprintf(\"\\r\\n\");" (lambda nil (backward-char 7)) 2)
    ("fpn" "fprintf(, \"\\n\");" (lambda nil (backward-char 8)) 2)
    ("fpe" "fprintf(stderr, \"\");" (lambda nil (backward-char 3)) 2)
    ("sp" "sprintf(, \"\");" (lambda nil (backward-char 6)) 2)
    ("fgi" "fgets(, , stdin);" (lambda nil (backward-char 11)) 2)
    ("sc" "scanf(\"\", );" (lambda nil (backward-char 5)) 2)
    ("ssc" "sscanf(, \"\", );" (lambda nil (backward-char 8)) 2)
    ("fs" "fscanf(, \"\", );" (lambda nil (backward-char 8)) 2)
    ("fsi" "fscanf(stdin, \"\", );" (lambda nil (backward-char 5)) 2)
    ("fp" "fprintf(, \"\");" (lambda nil (backward-char 6)) 2)
    ("fpen" "fprintf(stderr, \"\\n\");" (lambda nil (backward-char 5)) 2)
    ("sz" "sizeof();" (lambda nil (backward-char 2)) 2)
    ("main" "#include <stdio.h>

int
main(int argc, char *argv[])
{

	return 0;
}" 
	 (lambda nil (previous-line 2) (c-indent-command)) 2)
	))



;;; c++-mode 専用
(setq c++-mode-local-abbrev-table
  '(
	;; 入出力
    ("os" "ostream" nil 0)
    ("ofs" "ofstream" nil 0)
    ("is" "istream" nil 0)
    ("ifs" "ifstream" nil 0)
    ("oo" "cout << endl;" nil 0)
    ("con" "cout <<  << endl;" (lambda nil (backward-char 9)) 0)
    ("cco" "cout << \"\";" (lambda nil (backward-char 2)) 0)
    ("ccon" "cout << \"\" << endl;" (lambda nil (backward-char 10)) 0)
    ("ce" "cerr << ;" (lambda nil (backward-char 1)) 0)
    ("ee" "cerr << endl;" nil 0)
    ("cce" "cerr << \"\";" (lambda nil (backward-char 2)) 0)
    ("ccen" "cerr << \"\" << endl;" (lambda nil (backward-char 10)) 0)
    ("cen" "cerr <<  << endl;" (lambda nil (backward-char 9)) 0)
	
	;; クラス
    ("c" "class 
{

};" 
	 (lambda nil (backward-char 6) (c-indent-command)) 2)
    ("pub" "public:" (lambda nil (c-indent-command)) 2)
	("pro" "protected:" (lambda nil (c-indent-command)) 2)
    ("pri" "private:" (lambda nil (c-indent-command)) 2)
    ("del" "delete;" (lambda nil (c-indent-command) (backward-char 1)) 2)
    ("sr" "string" nil 0)
    ("v" "virtual" nil 2)
    ("t" "template" nil 2)
    ("co" "cout << ;" (lambda nil (backward-char 1)) 0)
    ("n" "NULL" nil 2)
    ("df" "#define" nil 2)
    ("de" "default:
break;" 
	 (lambda nil (c-indent-command) (backward-char 10)) 2)
    ("main" "#include <iostream>
#include <string>

int
main(int argc, char *argv[])
{

	return 0;
}" 
	 (lambda nil (previous-line 2) (c-indent-command)) 2)
	))





;;; c-mode
(define-abbrev-table 'c-mode-abbrev-table 
  (append c-mode-default-abbrev-table))

;;; c++-mode
(define-abbrev-table 'c++-mode-abbrev-table 
  (append c-mode-default-abbrev-table
		  c++-mode-local-abbrev-table ))
   
											
;;; java-mode
(define-abbrev-table 'java-mode-abbrev-table 
  '(
    ;; 制御構文
    ("if" "if() {
}" 
	 (lambda nil (abbrev-indent)) 0)
	("el" "else {
}" 
	 (lambda nil (previous-line 1) (c-indent-command) (next-line 1) (c-indent-command) 
	   (search-backward "else") (forward-char 6)) 0)
    ("e" "else" nil 2)
    ("ei" "else if() {
}"
	 (lambda nil (abbrev-indent)) 0)
	
    ("wh" "while() {
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("w" "while()" (lambda nil (backward-char 1)) 2)
    ("fo" "for(;;) {
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("f" "for(;;)" (lambda nil (backward-char 3)) 2)
    ("sw" "switch() {
}" 
	 (lambda nil (abbrev-indent)) 0)
    ("ca" "case :
break;" 
	 (lambda nil (backward-char 10) (c-indent-command) (next-line 1) (c-indent-command) 
	   (search-backward ":" nil t nil) (backward-delete-char 1)) 2)
	("b" "break;" nil 2)
    ("de" "default:
break;" 
	 (lambda nil (c-indent-command) (backward-char 10)) 2)
    ("r" "return;" (lambda nil (backward-char 1)) 2)
    ;; コメントアウト
    ("l" "/*  */" 
	 (lambda nil (c-indent-command) (search-backward " */" nil t nil) (backward-char 0)) 2)
    ("ll" "/********************************************************
 * 
 ********************************************************/" 
	 (lambda nil (previous-line 1)) 2)
	
	;; 関数
    ("main" "public static void main(String args[]) {

}" 
	 (lambda nil (abbrev-indent) (next-line 1)) 3)
    
    ("p" "System.out.print(\"\");" (lambda nil (backward-char 3)) 0)
	("pn" "System.out.println(\"\");" 
	 (lambda nil (backward-char 3)) 0)
    ("o" "\"\"" (lambda nil (backward-char 1)) 2)
    
	;; クラス
    ("c" "class  {
}
" 
	 (lambda nil (previous-line 2) (c-indent-command) (forward-char 6)) 3)
	("im" "import ;" nil 2)
	("ex" "extends " nil 2)
    ))



;;; ruby-mode
(define-abbrev-table 'ruby-mode-abbrev-table '(
    ("a" "ARGV" nil 2)
    ("pn" "print \"\\n\"" (lambda nil (backward-char 3)) 2)
    ("pf" "printf(\"\")" (lambda nil (backward-char 2)) 2)
    ("pfn" "printf(\"\\n\")" (lambda nil (backward-char 4)) 2)
    ("fo" "foreach" nil 2)
    ("el" "else" nil 2)
    ("ll" "######  ######" (lambda nil (backward-char 7) 2) 0)
    ("so" "STDOUT" nil 2)
    ("ei" "elsif" (lambda nil (ruby-indent-command)) 2)
    ("w" "while" nil 2)
    ("t" "true" nil 2)
    ("s" "shift" nil 2)
    ("si" "STDIN" nil 2)
    ("r" "return" nil 2)
    ("p" "print" nil 2)
    ("se" "STDERR" nil 2)
    ("f" "false" nil 2)
    ("e" "end" (lambda nil (ruby-indent-command)) 2)
    ("c" "class" nil 2)
    ))


;;; org-mode
;(define-abbrev-table 'org-mode-abbrev-table 
;  '(
;    ;; 制御構文
;    ("h" (format "#+STARTUP: showall
;#+TITLE: 
;#+AUTHOR: 大谷 欽洋
;#+DATE: %s
;#+OPTIONS: ^:{}
;"			(format-time-string "%Y/%m/%d" (current-time)))
;	 nil 2)
;	))

(define-abbrev-table 'org-mode-abbrev-table 
  '(
    ;; ヘッダ
    ("h" "#+STARTUP: showall
#+TITLE: 
#+AUTHOR: 大谷 欽洋
#+DATE: 
#+OPTIONS: ^:{}" (lambda nil (previous-line 3)) 2)
	;; HTML 画像サイズ指定
	("hi" "#+ATTR_HTML: :width 800px" nil 2)
	;; ファイルへのリンク
	("f" "[[file:]]" (lambda nil (backward-char 2)) 2)
	;; 脚注
	("n" "[fn:]" (lambda nil (backward-char 1)) 2)
	))

(define-abbrev-table 'wl-draft-mode-abbrev-table '(
    ))

(define-abbrev-table 'eshell-mode-abbrev-table '(
    ))

(define-abbrev-table 'pike-mode-abbrev-table '(
    ))

(define-abbrev-table 'idl-mode-abbrev-table '(
    ))

(define-abbrev-table 'text-mode-abbrev-table '(
    ))

(define-abbrev-table 'lisp-mode-abbrev-table '(
    ))

(define-abbrev-table 'fundamental-mode-abbrev-table '(
    ))

(define-abbrev-table 'global-abbrev-table '(
    ))


;;; for private setting
(if (file-exists-p (substitute-in-file-name "$HOME/.emacs.d/abbrev_defs-private.el"))
	(load (substitute-in-file-name "$HOME/.emacs.d/abbrev_defs-private.el")))
