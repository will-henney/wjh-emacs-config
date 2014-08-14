;; Let M-DIGIT be useful
;;
;; We already have C-DIGIT for digit-argument, so we don't need
;; M-DIGIT as well.  Instead, we can use the digits to do something
;; more useful, based on their shifted symbol (assuming a US keyboard)

(defun wjh/magit-status ()
  "Save project buffers and call `magit-status'"
  (interactive)
  (projectile-save-project-buffers)
  (magit-status (magit-get-top-dir)))

(defun wjh/safe-constants-replace ()
  (interactive)
  (with-demoted-errors (constants-replace)))

;; `:~
(global-set-key (kbd "M-`") 'other-window)
;; 1:!
(global-set-key (kbd "M-1") 'wjh/magit-status)
;; 2:@
(global-set-key (kbd "M-2") 'projectile-switch-project)
;; 3:#  
(global-set-key (kbd "M-3") 'wjh/safe-constants-replace)
;; 4:$
(global-set-key (kbd "M-4") 'shell-switcher-new-shell)
;; 5:%
(global-set-key (kbd "M-5") 'query-replace-regexp)
;; 6:^ 
(global-set-key (kbd "M-6") 'wjh/dired-jump)
;; 7:&
;; 8:* 
(global-set-key (kbd "M-8") 'quick-calc)
;; 9:(
(global-set-key (kbd "m-9") 'org-store-link)
;; 0:)
(global-set-key (kbd "m-0") 'locate)
;; -:_

