;; Other stuff

;; WJH 14 May 2010 - these are default in aquamacs anyhow
;; ;; Fontify unconditionally
;; (global-font-lock-mode t)

;; ;; Visual feedback on selections
;; (setq-default transient-mark-mode t)

;; Make sure we always assume unicode, if feasible
;; This is the default in Aquamacs, but vanilla Emacs will prefer latin-1 out of the box
(prefer-coding-system 'utf-8)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Enable wheelmouse support by default
;; (cond
;;  ((boundp 'aquamacs-version)
;;   ;; this is already on by default in aquamacs
;;   (message "Skipping mouse wheel activation")
;;   )
;;  (window-system
;;   (mwheel-install)
;;   ))
 
;; allow emacsclient processes to connect
;;(server-start) disabled for now

;; diary/calendar stuff
(setq mark-diary-entries-in-calendar t)

;; make buffer names be unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Load preprocessor F90 files as fortran
(add-to-list 'auto-mode-alist '("\\.F90\\'" . f90-mode))

;; Make underscore not be a word character in fortran files
;; 31 May 2012 - Why on earth did I ever do this? It messed up 
;; fontification and auto-completion of blocks....
;; (require 'f90)
;; (defvar wjh-f90-syntax-table
;;   (let ((table (make-syntax-table f90-mode-syntax-table)))
;;     (modify-syntax-entry ?_ "w" table)
;;     table))
;; (add-hook 'f90-mode-hook (lambda () (set-syntax-table wjh-f90-syntax-table)))

;; ;; New attempt to make F90 files look a bit nicer
;; (require 'pretty-mode)
;; ;; This way did not work
;; ;; (setq pretty-patterns
;; ;;       (pretty-compile-patterns
;; ;;        `(
;; ;; 	 (?• ("%" f90))
;; ;; 	 (?… ("\\(&\\)$\\|^ +\\(&\\)" f90))
;; ;; 	 )))
;; (defun wjh-f90-pretty-mode-setup ()
;;   (turn-on-pretty-mode)
;;   ;; (pretty-regexp "[^\\\\]\\(%\\)" "•") ; use bullet for derived type separator (backslash to escape)
;;   (pretty-regexp "%" "•") ; use bullet for derived type separator
;;   ;; (pretty-regexp "\\(&\\)$\\|^ +\\(&\\)" "…") ; use ellipsis for line continuation
;;   (pretty-regexp "&" "…") ; use ellipsis for line continuation
;;   )
;; (add-hook 'f90-mode-hook 'wjh-f90-pretty-mode-setup)


;; 08 Aug 2010 Miscellaneous tweaks to editing commands
(require 'misc)
;; always goes to start of word
(global-set-key (kbd "M-f") 'forward-to-word)
;; always goes to end of word
(global-set-key (kbd "M-b") 'backward-to-word)
;; zaps all BUT the character zapped to
(global-set-key (kbd "M-z") 'zap-up-to-char) 


;; Add in the Cmd-C, Cmd-V, Cmd-A, etc bindings like in aquamacs
(global-set-key (kbd "s-a") 'mark-whole-buffer)
;; This function copied from http://unix.stackexchange.com/questions/20849/emacs-how-to-copy-region-and-leave-it-highlighted
(defun kill-ring-save-keep-highlight (beg end)
  "Keep the region active after the kill"
  (interactive "r")
  (prog1 (kill-ring-save beg end)
    (setq deactivate-mark nil)))
(global-set-key (kbd "s-c") 'kill-ring-save-keep-highlight)
(global-set-key (kbd "s-v") 'cua-paste)
;; Allow shift-click to extend the region
(global-set-key (kbd "<S-down-mouse-1>") 'ignore) 
(global-set-key (kbd "<S-mouse-1>") 'mouse-save-then-kill)

;; WJH 23 Apr 2013 recentf-open-files is too useful not to have a
;; binding
(global-set-key (kbd "C-c F") 'recentf-open-files)


;; WJH 26 Jul 2012
;; Use spotlight instead of locate
(defun locate-spotlight-make-command-line (search-string)
  "Function to be used as value of locate-make-command-line.
This will actually use spotlight instead of locate, so it only works on OS X"
  (list "mdfind" "-name" search-string))
(setq locate-make-command-line 'locate-spotlight-make-command-line)


;;;
;;; Using Emacs as an external editor for textareas in Firefox
;;;
;; Temporary firefox files from my ifront.org wiki
(add-to-list 'auto-mode-alist '("ifront\\.org.*\\.txt\\'" . wikipedia-mode))
;; Temporary firefox files from my Cloudy Trac site
(add-to-list 'auto-mode-alist '("cloud9\\.pa\\.uky\\.edu.*\\.txt\\'" . trac-wiki-mode))
;; Temporary firefox files from gmail - need to read as UTF8
(add-to-list 'auto-coding-alist '("mail\\.google\\.com.*\\.txt\\'" . utf-8))

;;; Cloudy source files use literal tabs a lot
(add-hook 'c-mode-hook '(lambda () (set-variable 'tab-width 4)))
(add-hook 'c++-mode-hook '(lambda () (set-variable 'tab-width 4)))

;; Turn on word wrapping in text and derived modes
(add-hook 'text-mode-hook '(lambda () 
			     (turn-on-visual-line-mode)
			     ))

(add-hook 'LaTeX-mode-hook '(lambda () 
			      (set-variable 'line-spacing 5)
			      ;; TeX-PDF-mode is set in customize
			      (reftex-mode t)
			      ))


;; Use the echo area to display tooltips that are present at point position
(setq help-at-pt-timer-delay 0)
(help-at-pt-set-timer) 
(setq help-at-pt-display-when-idle t)

