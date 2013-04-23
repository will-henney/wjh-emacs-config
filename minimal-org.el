;;; Minimal setup to load latest `org-mode'
     
;; activate debugging
(setq debug-on-error t
      debug-on-signal nil
      debug-on-quit nil)

;; add latest org-mode to load path
(add-to-list 'load-path (expand-file-name "/usr/local/share/emacs/site-lisp/org/lisp"))
(add-to-list 'load-path (expand-file-name "/usr/local/share/emacs/site-lisp/org/contrib/lisp" t))
