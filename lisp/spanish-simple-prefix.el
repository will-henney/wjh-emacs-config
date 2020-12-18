;;; spanish-simple-prefix.el --- Spanish input method using ascii quote key alone
;; 
;; Filename: spanish-simple-prefix.el
;; Description: Spanish input method using ascii quote key alone
;; Author: William Henney (whenney@gmail.com)
;; Maintainer: 
;; Copyright (C) 2013,2017, William Henney, all rights reserved.
;; Created: Sat Sep  2 23:47:20 2017 (-0500)
;; Version: 1.0
;; Package-Requires: ()
;; Last-Updated: Sun Sep  3 00:13:42 2017 (-0500)
;;           By: William Henney
;;     Update #: 1
;; URL: 
;; Doc URL: 
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 3-Sep-2017    William Henney  
;;    Last-Updated: Sun Sep  3 00:13:42 2017 (-0500) #1 (William Henney)
;;    
;; 3-Sep-2017    William Henney  
;;    Last-Updated: 02 Sep 2017 #0 (William Henney)
;;    
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

(provide 'spanish-simple-prefix)

(quail-define-package
 "spanish-simple-prefix" "Spanish" "ES'" t
 "Spanish (Español) input method with simpler prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   '    | 'a -> á
  diaeresis  |   ''   | ''u -> ü
    tilde    |   '    | 'n -> ñ
   symbol    |   '    | '> -> »   '< -> «   '! -> ¡   '? -> ¿

To get a literal ', type a following space: \"' \" 
(the space will be eaten) or type three in a row: \"'''\"
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("'A" ?Á)
 ("'E" ?É)
 ("'I" ?Í)
 ("'O" ?Ó)
 ("'U" ?Ú)
 ("'a" ?á)
 ("'e" ?é)
 ("'i" ?í)
 ("'o" ?ó)
 ("'u" ?ú)
 ("' " ?')
 ;; ("' " ["' "])
 ("''U" ?Ü)
 ("''u" ?ü)
 ("'N" ?Ñ)
 ("'n" ?ñ)
 ("'>" ?\»)
 ("'<" ?\«)
 ("'!" ?¡)
 ("'?" ?¿)
 ("'''" ?')
 ;; ("' a" ["'a"])
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; spanish-simple-prefix.el ends here
