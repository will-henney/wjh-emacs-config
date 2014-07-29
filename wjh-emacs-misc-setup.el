;; Other stuff

;; 02 Feb 2014 - not necessary any more! see set-exec-path-from-shell-PATH in wjh-emacs-mac-specific.el
;; 07 Nov 2013 - why is it suddenly necessary to put these in my PATH in emacs?
;; (setq wjh-python-path "/Users/will/Library/Enthought/Canopy_64bit/User/bin")
;; (setenv "PATH" (concat wjh-python-path ":" (getenv "PATH")))
;; (add-to-list 'exec-path wjh-python-path)


;; 26 Oct 2013 - tweak scrolling behavior
;; Copied from http://zeekat.nl/articles/making-emacs-work-for-me.html
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; 26 Oct 2013 - autocomplete
(require 'fuzzy)
(require 'auto-complete)
(setq ac-auto-show-menu t
      ac-quick-help-delay 0.5
      ac-use-fuzzy t)
(global-auto-complete-mode +1)

;; 07 Jun 2013 switch to variable pich for text modes
;; 28 Nov 2013: turned it off again - more trouble than it was worth
;; (add-hook 'text-mode-hook 'variable-pitch-mode)
;; This requires some finessing of org-mode tables etc

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


;; Allow super-click to extend the region (used to be on shift-click
;; but I never used it, so demoted)
(global-set-key (kbd "<s-down-mouse-1>") 'ignore) 
(global-set-key (kbd "<s-mouse-1>") 'mouse-save-then-kill)

;; 15 Jul 2014 - a better shift-click
(defun wjh/mouse-expand-region (click)
  "Half-baked attempt to use the mouse to do er/expand-region
It sort of works but you have to move the mouse around to feel
for the boundary that you want."
  (interactive "e")
  (mouse-minibuffer-check click)
  (let ((posn (event-start click)))
    (select-window (posn-window posn))
      (goto-char (posn-point posn))
      (er/expand-region 1)
    ))
(global-set-key (kbd "<S-down-mouse-1>") 'ignore) 
(global-set-key [S-mouse-1] 'wjh/mouse-expand-region)


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

;; WJH 27 Jul 2014 - did not like this
;; Put a darker background on code buffers to match org-block-background
;; (defun buffer-background-dark ()
;;   (interactive)
;;   (setq buffer-face-mode-face `(:background "gray18"))
;;   (buffer-face-mode 1))
;; (add-hook 'python-mode-hook 'buffer-background-dark)

;; 27 Jul 2014
;; Turn on soft-wrapping in certain modes
;; Not perfect, but it sometimes works
(require 'adaptive-soft-wrap)
(add-hook 'visual-line-mode-hook 'adaptive-soft-wrap-mode)
(setq visual-line-fringe-indicators (quote (left-curly-arrow right-curly-arrow)))
(add-hook 'emacs-lisp-mode-hook 'visual-line-mode)
(add-hook 'swift-mode-hook 'visual-line-mode)
(add-hook 'python-mode-hook 'visual-line-mode)





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

