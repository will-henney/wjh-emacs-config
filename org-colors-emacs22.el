(custom-set-variables
 ;;; These are the colors that I used in Aquamacs 1.x
 ;;; Something causes problems in 2.0, so I am removing them from custom.el 
 ;;; for now
 '(org-code ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey30" :family "-apple-monaco-*"))) t)
 '(org-date ((((class color) (background light)) (:foreground "DarkSeaGreen4" :underline t))))
 '(org-done ((t (:foreground "chartreuse3" :overline "gray" :underline "gray" :weight bold :height 0.75))))
 '(org-level-1 ((((class color) (min-colors 88) (background light)) (:foreground "#a26" :weight bold))))
 '(org-level-2 ((((class color) (min-colors 16) (background light)) (:inherit org-level-1 :foreground "#23a"))))
 '(org-level-3 ((((class color) (min-colors 88) (background light)) (:inherit org-level-1 :foreground "#2a2"))))
 '(org-level-4 ((((class color) (min-colors 88) (background light)) (:inherit org-level-1 :foreground "#952"))))
 '(org-level-5 ((((class color) (min-colors 16) (background light)) (:inherit org-level-1 :foreground "#829"))))
 '(org-level-6 ((((class color) (min-colors 16) (background light)) (:inherit org-level-1 :foreground "#288"))))
 '(org-level-7 ((((class color) (min-colors 16) (background light)) (:inherit org-level-1 :foreground "#882"))))
 '(org-level-8 ((((class color) (min-colors 16) (background light)) (:inherit org-level-1 :foreground "#911"))))
 '(org-link ((((class color) (background light)) (:foreground "MidnightBlue" :underline t))))
 '(org-mode-default ((t (:inherit default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(org-table ((((class color) (min-colors 88) (background light)) (:inherit org-table :foreground "Blue4" :family "-apple-monaco-*"))))
 '(org-tag ((t (:box (:line-width 1 :color "grey75") :slant italic :weight light :height 0.7))))
 '(org-time-grid ((((class color) (min-colors 16) (background light)) (:foreground "DarkGoldenrod"))))
 '(org-todo ((t (:foreground "Red2" :overline "gray" :underline "gray" :weight bold :height 0.75))))
) 
