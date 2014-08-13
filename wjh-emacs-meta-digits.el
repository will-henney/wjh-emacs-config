;; Let M-DIGIT be useful
;;
;; We already have C-DIGIT for digit-argument, so we don't need
;; M-DIGIT as well.  Instead, we can use the digits to do something
;; more useful, based on their shifted symbol (assuming a US keyboard)

;; 1:!
(defun wjh/magit-status ()
  "Save project buffers and call `magit-status'"
  (interactive)
  (projectile-save-project-buffers)
  (magit-status (magit-get-top-dir)))

(global-set-key (kbd "M-1") 'wjh/magit-status)
;; 2:@
;; 3:#
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
;; 0:)
;; -:_
