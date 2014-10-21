
(deftheme wjh-latex-faces
  "Make latex buffers look nice")
(custom-theme-set-faces
 'wjh-latex-faces
 '(latex-mode-default ((t (:inherit text-mode-default :height 120 :width normal :family "Monaco"))))
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face :height 1.05))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face :height 1.05))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face :height 1.05))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face :height 1.05))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face :height 1.05))))
 '(font-latex-sectioning-5-face ((default (:inherit variable-pitch :weight bold))
                                 (((class color) (background light)) (:foreground "IndianRed4"))
                                 (((class color) (background dark)) (:foreground "Khaki"))
                                 ))
 '(font-latex-slide-title-face ((t (:inherit (variable-pitch font-latex-sectioning-5-face) :weight bold :height 1.2))))
 '(font-latex-string-face ((default (:inherit font-lock-string-face))))
 '(font-latex-warning-face ((default (:inherit bold))
                            (((class color) (background light)) (:foreground "red3"))
                            (((class color) (background dark)) (:foreground "#e5786d"))
                            ))
 '(font-latex-math-face (
                           (((class color) (background dark)) (:foreground "PaleTurquoise1"))
                           ))
 '(tex-fold-folded-face (
                           ;; The default grayish blue for light backgrounds is fine
                           (((class color) (background dark)) (:foreground "MistyRose3"))
                           ))
 )
(provide-theme 'wjh-latex-faces)
