(defun wjh/insert-current-date (arg)
  "Insert the current date in format \"yyyy-mm-dd\" at point.
With a prefix argument, use the format \"dd MONTH yyyy\" instead."
  (interactive "p")
  (let* ((wjh/time-format (if (= arg 4) "%d %b %Y" "%Y-%m-%d")))
    (insert (format-time-string wjh/time-format (current-time))))
  )
(global-set-key "\C-cd" 'wjh/insert-current-date)

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
(defun wjh/unsafe-revert-buffer ()
  "Like `revert-buffer' but no confirm and no reset of major mode."
  (interactive)
  (revert-buffer nil t t)
  (message "Buffer reverted to version on disk!"))
(global-set-key "\C-cR" 'wjh/unsafe-revert-buffer)

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

;; this does something similar to C-mouse1 in xemacs
(require 'mouse-copy)

;; 24 Sep 2016 - Greatly simplify this function by dynamically
;; rebinding `insert` (previously, I had just copied and edited
;; 2022-05-09 - Remove the rebinding of `insert' since it did not work
;; any more, now that I am using Native Compilation.  On the other
;; hand, it does not seem to be necessary any more either.
(defun wjh/mouse-drag-secondary-pasting (start-event)
  "Drag out a secondary selection, then paste it at the current point.

Just the same as the `mouse-drag-secondary-pasting` from
mouse-copy.el, with one exception: it deactivates the secondary
selection when it has finished."
  (interactive "e")
  (mouse-drag-secondary-pasting start-event)
  (delete-overlay mouse-secondary-overlay))

;; (defun wjh/mouse-drag-secondary-pasting (start-event)
;;   "Drag out a secondary selection, then paste it at the current point.

;; Just the same as the `mouse-drag-secondary-pasting` from
;; mouse-copy.el, with two exceptions: (1) It behaves the same way
;; as `yank' with respect to text properties (as in not copying
;; invisible properties that you probably don't want), and (2) it
;; deactivates the secondary selection when it has finished."
;;   (interactive "e")
;;   ;; Temporarily redefine `insert` - based on discussion at
;;   ;; http://endlessparentheses.com/understanding-letf-and-how-it-replaces-flet.html
;;   (cl-letf (((symbol-function 'insert) #'insert-for-yank-1))
;;     (mouse-drag-secondary-pasting start-event))
;;   (delete-overlay mouse-secondary-overlay))

(global-set-key [M-down-mouse-1] 'wjh/mouse-drag-secondary-pasting)
;; TODO 18 Feb 2016 - re-write this function too
(global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)


;; move file to current directory
;; copied from Pragmatic Emacs blog post 
;; http://pragmaticemacs.com/emacs/quickly-move-a-file-to-the-current-directory/
(use-package dash :ensure t)
(use-package swiper :ensure t)

;; start directory
(defvar bjm/move-file-here-start-dir (expand-file-name "~/Downloads"))

(defun bjm/move-file-here ()
  "Move file from somewhere else to here.
The file is taken from a start directory set by
`bjm/move-file-here-start-dir' and moved to the current directory
if invoked in dired, or else the directory containing current
buffer. The user is presented with a list of files in the start
directory, from which to select the file to move, sorted by most
recent first."
  (interactive)
  (let (file-list target-dir file-list-sorted start-file start-file-full)
    ;; clean directories from list but keep times
    (setq file-list
          (-remove (lambda (x) (nth 1 x))
                   (directory-files-and-attributes bjm/move-file-here-start-dir)))

    ;; get target directory
    ;; http://ergoemacs.org/emacs/emacs_copy_file_path.html
    (setq target-dir
          (if (equal major-mode 'dired-mode)
              (expand-file-name default-directory)
            (if (null (buffer-file-name))
                (user-error "ERROR: current buffer is not associated with a file.")
              (file-name-directory (buffer-file-name)))))

  ;; sort list by most recent
  ;;http://stackoverflow.com/questions/26514437/emacs-sort-list-of-directories-files-by-modification-date
  (setq file-list-sorted
        (mapcar #'car
                (sort file-list
                      #'(lambda (x y) (time-less-p (nth 6 y) (nth 6 x))))))

  ;; use ivy to select start-file
  (setq start-file (ivy-read
                    (concat "Move selected file to " target-dir ":")
                    file-list-sorted
                    :re-builder #'ivy--regex
                    :sort nil
                    :initial-input nil))

  ;; add full path to start file and end-file
  (setq start-file-full
        (expand-file-name start-file bjm/move-file-here-start-dir))
  (setq end-file
        (expand-file-name (file-name-nondirectory start-file) target-dir))
  (rename-file start-file-full end-file)
  (message "moved %s to %s" start-file-full end-file)))

(global-set-key (kbd "C-c D") 'bjm/move-file-here)


;; WJH 06 Oct 2016.  Some extra commands for scrolling medium amounts.
;; Remember that scrolling moves the viewport, so the window moves in
;; the opposite direction to what you might think.
;;
;; Four lines seems like a good compromise.  It means we can use the
;; Cmd key as an accelerator for cursor movement.
(defun wjh/scroll-up-4 ()
  "Scroll viewport up by 4 lines"
  (interactive)
  (cua-scroll-up 4)
  )
(defun wjh/scroll-down-4 ()
  "Scroll viewport down by 4 lines"
  (interactive)
  (cua-scroll-down 4)
  )
(global-set-key (kbd "s-<up>") 'wjh/scroll-down-4)
(global-set-key (kbd "s-<down>") 'wjh/scroll-up-4)


;; Also, a complementary pair of functions for doing the same
;; acceleration of C-p and C-n.  Except, this time we do it by moving
;; up/down lines in the buffer instead of moving the viewport, so the
;; visual effect is different.
(defun wjh/forward-4-lines ()
  "Move 4 lines forward"
  (interactive)
  (forward-line 4)
  )
(defun wjh/backward-4-lines ()
  "Move 4 lines backward"
  (interactive)
  (forward-line -4)
  )
(global-set-key (kbd "s-C-p") 'wjh/backward-4-lines)
(global-set-key (kbd "s-C-n") 'wjh/forward-4-lines)

;; For consistency, we do a similar thing for left and right arrows.
;; This time, we don't do it by scrolling the viewport, since I very
;; rarely want to that in the horizontal direction.
(defun wjh/move-right-4 ()
  "Move point 4 characters to the right"
  (interactive)
  (right-char 4)
  )
(defun wjh/move-left-4 ()
  "Move point 4 characters to the left"
  (interactive)
  (left-char 4)
  )
;; Acceleration of arrows and of C-f/C-b is exactly the same
(global-set-key (kbd "s-<left>") 'wjh/move-left-4)
(global-set-key (kbd "s-<right>") 'wjh/move-right-4)
(global-set-key (kbd "s-C-b") 'wjh/move-left-4)
(global-set-key (kbd "s-C-f") 'wjh/move-right-4)


;; Functions to make numbers nicer
(defun wjh/clean-float (a n)
  "Round floating point number to n decimal places"
  (let ((fmt (format "%%.%dg" n)))
    (format fmt a)))

;; Technique for replacing number at point is partially based on
;; https://stackoverflow.com/questions/25188206/how-do-you-write-an-emacs-lisp-function-to-replace-a-word-at-point
;; 17 Apr 2020 - need to make this better - use the following regex:
;; "\b-?[1-9](?:\.\d+)?[Ee][-+]?\d+\b" taken from
;; http://regexlib.com/Search.aspx?k=scientific%20notation&AspxAutoDetectCookieSupport=1
(defun wjh/convert-float-to-clean-form (p)
  "Convert number at point to a nicer representation."
  (interactive "p")
  (let* ((bounds (if (use-region-p)
                     (cons (region-beginning) (region-end))
                   (bounds-of-thing-at-point 'sexp)))
	 (precision (if (= p 1) 4 p))
         (text (buffer-substring-no-properties (car bounds) (cdr bounds)))
	 (newtext (wjh/clean-float (string-to-number text) precision)))
    (if (= (string-to-number text) 0)
	(message "No number found!")
      (when (and (/= (string-to-number text) 0) bounds)
	(delete-region (car bounds) (cdr bounds))
	(insert newtext)))))
(global-set-key (kbd "C-c w") 'wjh/convert-float-to-clean-form)


;; 2023-04-04: Duplicate line function to mimic behavior of Cmd-D in
;; JetBrains editors. This is copied from
;; https://stackoverflow.com/a/998472/353062
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))
(global-set-key (kbd "s-d") 'duplicate-line)
