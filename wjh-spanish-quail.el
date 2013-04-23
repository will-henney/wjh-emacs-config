(quail-define-package
 "spanish-wjh" "Spanish" "ES'" t
 "Spanish (Español) input method with simpler prefix modifiers

    effect   | prefix | examples
 ------------+--------+----------
    acute    |   '    | 'a -> á
  diaeresis  |   ''   | ''u -> ü
    tilde    |   '    | 'n -> ñ
   symbol    |   '    | '> -> »   '< -> «   '! -> ¡   '? -> ¿
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
 ;; ("' a" ["'a"])
)
'kj kj
á¿¡«ü ñ 'crap'

 
