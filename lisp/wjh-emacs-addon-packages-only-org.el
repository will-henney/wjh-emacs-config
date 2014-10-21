;; Third party add-on packages that are not shipped with Emacs 22 CVS
(defun wjh-add-to-load-path (pkg)
  "Add pkg directory to load path."
  (add-to-list 'load-path (concat wjh-local-lisp-dir "/lisp/" pkg)))
;; org-mode comes included with recent emacsen 
;; - but let's just use a new version
(wjh-add-to-load-path "org")

;; make sure it gets loaded on .org files
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; global binding for saving a link to the current file
(define-key global-map "\C-cl" 'org-store-link)
;; global binding for agenda
(define-key global-map "\C-ca" 'org-agenda)
;; where to keep all the files
(setq org-directory "~/Org/")





