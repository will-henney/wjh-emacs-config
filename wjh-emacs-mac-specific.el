;; Turn on transparency: 
;; 90% opacity for selected frame
;; 80% opacity for the others
;; This should work in both aquamacs and carbon emacs
;; I copied it from http://www.emacswiki.org/cgi-bin/wiki/CarbonEmacsPackage
;; (setq default-frame-alist
;;       (append
;;        (list
;; 	'(active-alpha . 0.9)  ;; active frame
;; 	'(inactive-alpha . 0.8) ;; non active frame
;; 	) default-frame-alist)
;;       )

;; (cond
;;  ((boundp 'aquamacs-version)
;;   ;;; aquamacs-specific config was here
;;   ;;; It is now all in ~/Library/Preferences/Aquamacs Emacs/Preferences.el
;;   ()
;;   )
;;  )
