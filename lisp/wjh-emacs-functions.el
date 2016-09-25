(defun wjh/insert-current-date ()
  "Insert the current date in format \"dd MONTH yyyy\" at point."
  (interactive)
  (insert (format-time-string "%d %b %Y" (current-time))))
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
(defun wjh/mouse-drag-secondary-pasting (start-event)
  "Drag out a secondary selection, then paste it at the current point.

Just the same as the `mouse-drag-secondary-pasting` from
mouse-copy.el, with two exceptions: (1) It behaves the same way
as `yank' with respect to text properties (as in not copying
invisible properties that you probably don't want), and (2) it
deactivates the secondary selection when it has finished."
  (interactive "e")
  ;; Temporarily redefine `insert` - based on discussion at
  ;; http://endlessparentheses.com/understanding-letf-and-how-it-replaces-flet.html
  (cl-letf (((symbol-function 'insert) #'insert-for-yank-1))
    (mouse-drag-secondary-pasting start-event))
  (delete-overlay mouse-secondary-overlay))

(global-set-key [M-down-mouse-1] 'wjh/mouse-drag-secondary-pasting)
;; TODO 18 Feb 2016 - re-write this function too
(global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)


;; move file to current directory
;; copied from Pragmatic Emacs blog post 
;; http://pragmaticemacs.com/emacs/quickly-move-a-file-to-the-current-directory/
(require 'dash)
(require 'swiper)

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
