;; I could never get this to work very well

;; I do have a self-contained config in /Users/will/tmp/emacs-init-org-modern.el
;; But even that does not work great


(use-package org-modern
  :ensure t
  :init
  ;; Add frame borders and window dividers
  ;;
  ;; WJH 2023-12-05: These are necessary in order to be able to see the
  ;; indicators for source blocks.  On the other hand, I do not want
  ;; them as large as in the examples (40 pixels!), so I am using 4
  ;; instead
  (modify-all-frames-parameters
   '((right-divider-width . 4)
     (internal-border-width . 4)))
  ;; Make things blend in
  (dolist (face '(window-divider
                  window-divider-first-pixel
                  window-divider-last-pixel))
    (face-spec-reset-face face)
    (set-face-foreground face (face-attribute 'default :background)))
  :config
  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")
  (global-org-modern-mode)
  )


(require-theme 'modus-themes)
(modus-themes-load-vivendi)
