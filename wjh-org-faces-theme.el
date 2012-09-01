
(deftheme wjh-org-faces
  "Created 2011-11-04.")
(custom-theme-set-faces
 'wjh-org-faces
 '(org-block ((t (:inherit (shadow fixed-pitch)))))
 '(org-block-background ((default (:inherit fixed-pitch))
                         (((class color) (background dark)) (:background "gray18"))
                         ) nil "This looks good with zenburn. YMMV otherwise")
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-formula (
                (((class color) (background dark)) (:foreground "LightSalmon1"))
                ))
 '(org-table ((default (:inherit fixed-pitch))
              (((class color) (background light)) (:foreground "Blue4"))
              (((class color) (background dark)) (:foreground "PaleTurquoise1"))
              ))
 '(org-date ((default (:underline t))
             (((class color) (background light)) (:foreground "Purple4"))
             (((class color) (background dark)) (:foreground "#c2a9c2"))
             ))
 '(org-document-title ((default  (:weight bold))
                       (((class color) (background light)) 
                        (:foreground "midnight blue"))
                       (((class color) (background dark)) 
                        (:foreground "white"))
                       ))
;; bisque to lightcyan intermingled with lavender to goldenrod
'(org-level-1 ((((class color) (background dark)) (:foreground "#ffe4c4"))))
'(org-level-2 ((((class color) (background dark)) (:foreground "#e4dddb"))))
;; '(org-level-2 ((((class color) (background dark)) (:foreground "#fbe8cc"))))
'(org-level-3 ((((class color) (background dark)) (:foreground "#f6ecd5"))))
'(org-level-4 ((((class color) (background dark)) (:foreground "#e1ca9d"))))
;; '(org-level-4 ((((class color) (background dark)) (:foreground "#f2f0dd"))))
'(org-level-5 ((((class color) (background dark)) (:foreground "#edf3e6"))))
'(org-level-6 ((((class color) (background dark)) (:foreground "#ddb85e"))))
;; '(org-level-6 ((((class color) (background dark)) (:foreground "#e9f7ee"))))
'(org-level-7 ((((class color) (background dark)) (:foreground "#e4fbf7"))))
'(org-level-8 ((((class color) (background dark)) (:foreground "#daa520"))))
;; '(org-level-8 ((((class color) (background dark)) (:foreground "#e0ffff"))))
;; ;; lavender to goldenrod
;;  '(org-level-1 ((((class color) (background dark)) (:foreground "#e6e6fa"))))
;;  '(org-level-2 ((((class color) (background dark)) (:foreground "#e4dddb"))))
;;  '(org-level-3 ((((class color) (background dark)) (:foreground "#e3d3bc"))))
;;  '(org-level-4 ((((class color) (background dark)) (:foreground "#e1ca9d"))))
;;  '(org-level-5 ((((class color) (background dark)) (:foreground "#dfc17d"))))
;;  '(org-level-6 ((((class color) (background dark)) (:foreground "#ddb85e"))))
;;  '(org-level-7 ((((class color) (background dark)) (:foreground "#dcae3f"))))
;;  '(org-level-8 ((((class color) (background dark)) (:foreground "#daa520"))))
 ;; '(outline-1 ((((class color) (background dark)) (:foreground "green3"))))
 ;; '(outline-2 ((((class color) (background dark)) (:foreground "SeaGreen3"))))
 ;; '(outline-3 ((((class color) (background dark)) (:foreground "SpringGreen3"))))
 ;; '(outline-4 ((((class color) (background dark)) (:foreground "olive drab"))))
 ;; '(outline-5 ((((class color) (background dark)) (:foreground "green4"))))
 ;; '(outline-6 ((((class color) (background dark)) (:foreground "SeaGreen4"))))
 ;; '(outline-7 ((((class color) (background dark)) (:foreground "SpringGreen4"))))
 ;; '(outline-8 ((((class color) (background dark)) (:foreground "dark olive green"))))
 '(org-link ((((class color) (background light)) (:foreground "gray50" :underline t :weight bold))))
 '(org-todo ((t (:foreground "#b93030" :weight bold))))

 ;; Org column
 '(org-column-title ((((class color) (min-colors 16) (background light)) (:background "grey90" :underline t :weight bold :family "monaco"))))
 )
(provide-theme 'wjh-org-faces)
