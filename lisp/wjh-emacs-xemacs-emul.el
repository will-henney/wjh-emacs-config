;; xemacs emulation
(global-set-key [C-tab] 'other-window)
;; not needed for CVS emacs since we have `M-g g' or `M-g M-g'
(if (< emacs-major-version 22)
    (global-set-key [M-g] 'goto-line))

;; And just for fun, this is by the same author
;; Disabled 09 Sep 2005 - I never use it and it is confusing anyhow
;;(require 'mouse-drag)
;;(global-set-key [down-mouse-2] 'mouse-drag-throw)

;; WJH 14 May 2010 - disabled since I don't really understand what it does
;; ;; clipboard behaviour 
;; (setq x-select-enable-clipboard t)

;; still missing....
;; 1. electric ~ and / in file dialog
;; 2. Searching behavior of C-up after typing beginning of command in *shell*
;; 3. Sane behavior of `!' in dired after selecting multiple files

