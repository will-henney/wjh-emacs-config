;;; adaptive-soft-wrap.el --- Soft indentation of word-wrapped lines

;; The following code leverages visual-line-mode, font-lock-mode and filladapt to provide a soft indent feature. I’ve only been using it for a while, so it may have some rough edges yet that need to be smoothed out; comments or suggestions would be very welcome. – JamesWright

;; Copied from http://www.emacswiki.org/emacs/SoftIndent

;;; Code:

(defvar adaptive-soft-wrap-font-keywords
  '((find-next-fillable-line 0 (list 'face nil 'wrap-prefix fill-prefix) append))
  "Add this to a mode's keywords to enable adaptive soft-wrapping.")

(define-minor-mode adaptive-soft-wrap-mode
  "Use font-lock machinery to automatically set `wrap-prefix' properties on each line based on its filladapt fill-prefix."
  nil nil nil
  (require 'filladapt)
  (require 'font-lock)
  (if adaptive-soft-wrap-mode
      (progn
	(font-lock-add-keywords nil adaptive-soft-wrap-font-keywords t)
	(unless (memq 'wrap-prefix font-lock-extra-managed-props)
	  (setq font-lock-extra-managed-props
		(cons 'wrap-prefix font-lock-extra-managed-props))))
    (progn
      (font-lock-remove-keywords nil adaptive-soft-wrap-font-keywords)
      (font-lock-fontify-buffer))))

(defun find-next-fillable-line (bound)
  (let ((prefix nil)
	(nleft 0)
	(bolp nil))
    (save-restriction
      (setq bolp (bolp))
      (narrow-to-region (point) bound)
      (if (and (not bolp)
	       (zerop (setq nleft (forward-line 1))))
	(goto-char (point-at-bol)))
      ;; From this point onward, point is either at bol or we are done
      (while (and (zerop nleft)
		  (not (setq prefix (fillable-line-prefix)))
		  (zerop (setq nleft (forward-line 1)))))
      (if prefix
	(let ((s (point-marker))
	      (e (save-excursion (goto-char (point-at-eol)) (point-marker))))
	  (set-match-data (list s e) t)
	  (setq fill-prefix prefix)
	  prefix)
	(progn
	  (goto-char (point-min))
	  nil)))))

(defun fillable-line-prefix ()
  "Return a prefix for the current line if at the beginning of a fillable line, or NIL otherwise."
  (let* ((tokens (filladapt-parse-prefixes))
	 (prefix (when tokens
		   (filladapt-make-fill-prefix tokens))))
    (if (> (length prefix) 0)
	prefix)))

(provide 'adaptive-soft-wrap)

;;; adaptive-soft-wrap.el ends here
