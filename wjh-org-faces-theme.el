
(deftheme wjh-org-faces
  "Created 2011-11-04.")
(custom-theme-set-faces
 'wjh-org-faces
 '(org-block ((t (:inherit (shadow fixed-pitch)))))
 '(org-block-background ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-table ((default (:inherit fixed-pitch))
              (((class color) (background light)) (:foreground "Blue4"))))
 '(org-date ((((class color) (background light)) (:foreground "Purple4" :underline t))))
 '(org-document-title ((default  (:weight bold))
                       (((class color) (background light)) 
                        (:foreground "midnight blue"))
                       (((class color) (background dark)) 
                        (:foreground "white"))
                       ))
 ;; '(org-level-5 ((t (:inherit outline-5 :foreground "#c06d1a"))))
 ;; '(org-level-6 ((t (:inherit outline-6 :foreground "#317563"))))
 '(org-link ((((class color) (background light)) (:foreground "gray50" :underline t :weight bold))))
 '(org-todo ((t (:foreground "#b93030" :weight bold))))

 ;; Org column
 '(org-column-title ((((class color) (min-colors 16) (background light)) (:background "grey90" :underline t :weight bold :family "monaco"))))
 )
(provide-theme 'wjh-org-faces)
