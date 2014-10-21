(defun wjh-insert-current-date ()
  "Insert the current date in format \"dd MONTH yyyy\" at point."
  (interactive)
  (insert (format-time-string "%d %b %Y" (current-time))))
(global-set-key "\C-cd" 'wjh-insert-current-date)


;; This is no longer necessary in emacs 22+ since we have input methods, 
;; which are much better
(if (< emacs-major-version 22)
    ((defun wjh-iso-accents-spanish ()
       "Activate iso-accents-mode and set language to spanish."
       (interactive)
       (iso-accents-mode 1)
       (iso-accents-customize "spanish"))
     (global-set-key "\C-ca" 'wjh-iso-accents-spanish))
  )

;; Strange that this useful function is not bound to a key by default
(global-set-key "\C-cr" 'revert-buffer)
;; And for when I am absolutely sure I know what I am doing
(defun wjh-unsafe-revert-buffer ()
  "Like `revert-buffer' but no confirm and no reset of major mode."
  (interactive)
  (revert-buffer nil t t)
  (message "Buffer reverted to version on disk!"))
(global-set-key "\C-cR" 'wjh-unsafe-revert-buffer)

;; We now have an entire C-c t keymap for toggling various things. 
;; Most are defined in wjh-org-config.el, but these ones are more general.
;;
;; For those pesky cloudy output files
(global-set-key "\C-ctt" 'toggle-truncate-lines)
;; Turning this on automatically never seems to work
(global-set-key "\C-ctv" 'visual-line-mode)



(defun shell-other-window ()
  "Switch to shell in other window.
If you already started a shell and it is called `*shell*' then use that, 
otherwise start a new shell."
  (interactive)
  (pop-to-buffer "*shell*" t) ; the second argument forces other window
  (if (not (eq major-mode 'shell-mode))
      (shell))
  )
(global-set-key "\C-cs" 'shell-other-window)

;; Toggle automatic filling
(global-set-key "\C-cf" 'auto-fill-mode)
