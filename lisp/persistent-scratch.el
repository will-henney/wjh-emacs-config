;;; From http://dorophone.blogspot.com/2011/11/how-to-make-emacs-scratch-buffer.html
;;; Make the *scratch* buffer persistent.
;;; This differs slightly from the one in the article. On advice from the
;;; comment the following changes were made:
;;;
;;;   * Changed the call to "cat" using shell-command, to insert-file-contents.
;;;
;;;   * Changed the call to current-time to format-time-string. I modified the
;;;     format string slightly so the filenames would sort properly.
;;;
;;; Made another change to put the .emacs-persistent-scratch file in the backup
;;; directory. I had permision trouble in windows when writing the file to
;;; c:/. Running through expand-file-name helps too, but may not be necessary
;;; anymore.

(defvar persistent-scratch-filename 
    "emacs-persistent-scratch"
    "Location of *scratch* file contents for persistent-scratch.")
(defvar persistent-scratch-backup-directory 
    "~/.emacs.d/scratch/"
    "Location of backups of the *scratch* buffer contents for
    persistent-scratch.")

(defun persistent-scratch-path ()
  "Create the full path for where the latest version is stored."
  (expand-file-name (concat persistent-scratch-backup-directory persistent-scratch-filename)))

(defun make-persistent-scratch-backup-name ()
  "Create a filename to backup the current scratch file by
  concatenating PERSISTENT-SCRATCH-BACKUP-DIRECTORY with the
  current date and time."
  (concat 
   persistent-scratch-backup-directory 
   (replace-regexp-in-string 
     (regexp-quote " ") "-" (format-time-string "%Y-%m-%d_%H-%M-%S"))))

(defun save-persistent-scratch ()
  "Write the contents of *scratch* to the file name
  PERSISTENT-SCRATCH-FILENAME, placing that and a backup copy in
  PERSISTENT-SCRATCH-BACKUP-DIRECTORY."
  (with-current-buffer (get-buffer "*scratch*")
    (if (file-exists-p (persistent-scratch-path))
        (copy-file (persistent-scratch-path)
                   (make-persistent-scratch-backup-name)))
    (write-region (point-min) (point-max) 
                  (persistent-scratch-path))))

(defun load-persistent-scratch ()
  "Load the contents of PERSISTENT-SCRATCH-FILENAME into the
  scratch buffer, clearing its contents first."
  (if (file-exists-p (persistent-scratch-path))
      (with-current-buffer (get-buffer "*scratch*")
        (delete-region (point-min) (point-max))
        (insert-file-contents (persistent-scratch-path)))))

(provide 'persistent-scratch)
