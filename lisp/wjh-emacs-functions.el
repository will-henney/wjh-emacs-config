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


(defun wjh-mouse-drag-secondary-pasting (start-event)
  "Drag out a secondary selection, then paste it at the current point.

This is modified from the original version (from mouse-copy.el)
in two ways.  First, it behaves the same way as `yank' with
respect to text properties (as in not copying invisible
properties that you probably don't want).  Secondly, it
deactivates the secondary selection when it has finished."
  (interactive "e")
  ;; Work-around: We see and react to each part of a multi-click event
  ;; as it proceeds.  For a triple-event, this means the double-event
  ;; has already copied something that the triple-event will re-copy
  ;; (a Bad Thing).  We therefore undo the prior insertion if we're on
  ;; a multiple event.
  (if (and mouse-copy-last-paste-start
	   (>= (event-click-count start-event) 2))
      (delete-region mouse-copy-last-paste-start
		     mouse-copy-last-paste-end))

  ;; HACK: We assume that mouse-drag-secondary returns nil if
  ;; there's no secondary selection.  This assumption holds as of
  ;; emacs-19.22 but is not documented.  It's not clear that there's
  ;; any other way to get this information.
  (if (mouse-drag-secondary start-event)
      (progn
	(if mouse-copy-have-drag-bug
	    (mouse-copy-work-around-drag-bug start-event last-input-event))
	;; Remember what we do so we can undo it, if necessary.
	(setq mouse-copy-last-paste-start (point))
	;; WJH 18 Feb 2016 - change insert to insert-for-yank-1
	(insert-for-yank-1 (x-get-selection 'SECONDARY))
	(setq mouse-copy-last-paste-end (point))
	;; WJH 18 Feb 2016 - added the following line so that
	;; highlighting doesn't linger
	(delete-overlay mouse-secondary-overlay))
    (setq mouse-copy-last-paste-start nil)))


;; this does something similar to C-mouse1 in xemacs
(require 'mouse-copy)
(global-set-key [M-down-mouse-1] 'wjh-mouse-drag-secondary-pasting)
;; TODO 18 Feb 2016 - re-write this function too
(global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)
