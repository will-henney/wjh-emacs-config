;; Other stuff


;; 24 Aug 2020 - Use mouse when in terminal emacs - useful when connecting from iPad!
(unless (display-graphic-p)
  (xterm-mouse-mode)
  (global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1))))



;; 04 Apr 2015 - so we never lose text copied from external application
;; Based on some discussion thread on reddit
(setq save-interprogram-paste-before-kill t)

;; 02 Feb 2014 - not necessary any more! see set-exec-path-from-shell-PATH in wjh-emacs-mac-specific.el
;; 07 Nov 2013 - why is it suddenly necessary to put these in my PATH in emacs?
;; (setq wjh-python-path "/Users/will/Library/Enthought/Canopy_64bit/User/bin")
;; (setenv "PATH" (concat wjh-python-path ":" (getenv "PATH")))
;; (add-to-list 'exec-path wjh-python-path)

;; 10 Dec 2014 - Pointed out by Artur Malabarba
;; http://endlessparentheses.com/sweet-new-features-in-24-4.html
;; "... so you’re never accidentally using outdated compiled files."
(setq load-prefer-newer t)

;; 26 Oct 2013 - tweak scrolling behavior
;; Copied from http://zeekat.nl/articles/making-emacs-work-for-me.html
;; Revisited 03 May 2017 - get rid of scroll-margin

(defun wjh/ultra-conservative-scrolling ()
  (interactive)
  (setq
   scroll-margin 0
   scroll-step 0
   scroll-conservatively 10000
   scroll-preserve-screen-position 1))

(defun wjh/ultra-aggressive-scrolling ()
  (interactive)
  (setq
   scroll-margin 2
   scroll-step 0
   scroll-conservatively 0
   scroll-down-aggressively 0.95
   scroll-up-aggressively 0.95
   scroll-preserve-screen-position nil))

(defun wjh/default-aggressive-scrolling ()
  (interactive)
  (setq
   scroll-margin 1
   scroll-step 0
   scroll-conservatively 0
   scroll-down-aggressively 0.5
   scroll-up-aggressively 0.5
   scroll-preserve-screen-position nil))

;; (wjh/ultra-aggressive-scrolling)
;; (wjh/default-aggressive-scrolling)
(wjh/ultra-conservative-scrolling)

;; 03 Aug 2017 - Playing with pixel-based scrolling

;; Primitives to move by 1 pixel
(defun wjh/pxscroll-vscroll-1px-down ()
  (interactive)
  (set-window-vscroll nil (1+  (window-vscroll nil t)) t))
(defun wjh/pxscroll-vscroll-1px-up ()
  (interactive)
  (set-window-vscroll nil (1-  (window-vscroll nil t)) t))

;; 
(defun wjh/pxscroll-scroll-down-line ()
  (interactive)
  (let ((height (default-line-height)))
       (dotimes (n height) (wjh/pxscroll-vscroll-1px-down))))
(defun wjh/pxscroll-scroll-up-line ()
  (interactive)
  (let ((height (default-line-height)))
       (dotimes (n height) (wjh/pxscroll-vscroll-1px-up))))

;; Why doesn't this work?  It is fine if I run each line by hand, but
;; not when I call the function Answer: this is what
;; pixel-scroll-down-and-set-window-vscroll in pixel-scroll.el is for
(defun wjh/pxscroll-increase-vscroll-1-line-inplace ()
  (setq ovscroll (window-vscroll nil t))
  (set-window-vscroll nil 0 t)
  (scroll-down 1)
  (set-window-vscroll nil (+ (default-line-height) ovscroll) t))

(global-set-key (kbd "H-j") 'wjh/pxscroll-vscroll-1px-down)
(global-set-key (kbd "H-k") 'wjh/pxscroll-vscroll-1px-up)

(global-set-key (kbd "H-J") 'wjh/vscroll-default-line-height-down)
(global-set-key (kbd "H-K") 'wjh/vscroll-default-line-height-up)


(defun wjh/bind-to-noop-wheel-left-right ()
  "Bind all horizontal scroll wheel events to do nothing"
  (dolist (modstring '("" "C-" "S-"))
    (dolist (keystring '("wheel-left" "wheel-right"))
      (global-set-key (kbd (format "<%s%s>" modstring keystring)) 'wjh/drop-event))))

;; 01 Aug 2017: More fiddling with the scrolling behavior.  I want to
;; see if I can get the best possble behavior with a track pad for the
;; two cases of line-by-line or pixel-by-pixel scrolling
(defun use-line-based-scrolling ()
  "Optimize settings for scrolling by line (not pixel)"
  (interactive)
  ;; Turn off smooth scroll if we are using the "Mac port"
  (when (boundp 'mac-mouse-wheel-smooth-scroll)
    (setq mac-mouse-wheel-smooth-scroll nil)
    ;; Stop using mac-mwheel-scroll in term/mac-win.el
    (mac-mouse-wheel-mode -1)
    ;; Deactivating mac-mouse-wheel-mode nukes all wheel bindings, so
    ;; we must restore these to avoid spurious minibuffer chatter
    (wjh/bind-to-noop-wheel-left-right)
    ;; Start using mwheel-scroll in mwheel.el
    (mouse-wheel-mode 1)
    )
  ;; And also turn off the pixel-scroll-mode if present
  (when (boundp 'pixel-scroll-mode) (pixel-scroll-mode 0))
  ;; 01 Aug 2017: The following is inspired by a comment by
  ;; SteveJobzniak from this issue thread
  ;; https://github.com/d12frosted/homebrew-emacs-plus/issues/10
  (setq
   ;; Progressive speed runs away far too fast, so disable
   mouse-wheel-progressive-speed nil
   ;; Make each scroll-event move 1 line at a time (instead of default
   ;; 5). Hold down shift to move 3x, or hold down control to move 5x
   ;; as fast. Perfect for trackpads.
   mouse-wheel-scroll-amount '(1 ((shift) . 3) ((control) . 5))))


(defun use-pixel-based-scrolling ()
  "Optimize settings for scrolling by pixel"
  (interactive)
  (if (not (boundp 'mac-mouse-wheel-smooth-scroll))
      (use-elisp-pixel-based-scrolling)	; fall-back for vanilla emacs builds
    (setq mac-mouse-wheel-smooth-scroll t)
    (mouse-wheel-mode -1)
    (mac-mouse-wheel-mode 1)
    (wjh/bind-to-noop-wheel-left-right)
    (setq
     mouse-wheel-progressive-speed nil
     ;; Holding down shift or control reverts to line-based scrolling
     mouse-wheel-scroll-amount '(5 ((shift) . 1) ((control) . 2)))))

(require 'pixel-scroll)
(defun use-elisp-pixel-based-scrolling ()
  "Based on pixel-scroll library with snap-to-line"
  (interactive)
  (pixel-scroll-mode 1)
  (setq pixel-resolution-fine-flag nil)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 3) ((control) . 5)))
  )

(defun use-elisp-fine-pixel-based-scrolling ()
  "Based on pixel-scroll library with no snap (very slow)"
  (interactive)
  (pixel-scroll-mode 1)
  (setq pixel-resolution-fine-flag t)
  (setq mouse-wheel-scroll-amount '(3 ((shift) . 10) ((control) . 30) ((meta) . 100)))
  )


;; 28 May 2016 - backups and auto-saves and minibuffer history
;; Make sure we don't litter the file system
;; Put everything under ~/.emacs.d/
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list" t)))
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; 2022-05-10 - Stop using autocomplete since it is conflicting with company mode
;; 26 Oct 2013 - autocomplete
;; (use-package fuzzy :ensure t)
;; (use-package auto-complete :ensure t)
;; (setq ac-auto-show-menu t
;;       ac-quick-help-delay 0.5
;;       ac-use-fuzzy t)
;; (global-auto-complete-mode +1)

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
(server-start)

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


;; 24 Sep 2016 - don't ask redundantly which buffer to kill
;; Borrowed from suggestion by Ben Maughan
;; http://pragmaticemacs.com/emacs/dont-kill-buffer-kill-this-buffer-instead/
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; 08 Aug 2010 Miscellaneous tweaks to editing commands
(require 'misc)
;; always goes to start of word
(global-set-key (kbd "M-F") 'forward-to-word)
;; always goes to end of word
(global-set-key (kbd "M-B") 'backward-to-word)
;; zaps all BUT the character zapped to
(global-set-key (kbd "M-z") 'zap-up-to-char) 


;; Allow Shift-click to extend the region 
(global-set-key (kbd "<S-down-mouse-1>") 'ignore) 
(global-set-key (kbd "<S-mouse-1>") 'mouse-save-then-kill)

;; 15 Jul 2014/31 Jul 2014 - a better super-click. It used to be on
;; shift-click but I didn't like it so much, so demoted.  Turns out
;; that the C-= binding is much more useful
;;
;; 04 Dec 2014 - Now remove the binding completely because I wanted it
;; for flyspell-correct-word
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
;; (global-set-key (kbd "<s-down-mouse-1>") 'ignore) 
;; (global-set-key [s-mouse-1] 'wjh/mouse-expand-region)

;; WJH 31 Jul 2014 - useful naroow/widen function
;; Copied from http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))

(global-set-key (kbd "C-c n") 'narrow-or-widen-dwim)

;; WJH 23 Apr 2013 recentf-open-files is too useful not to have a
;; binding
(global-set-key (kbd "C-c F") 'recentf-open-files)

;; WJH 01 Sep 2017 - need better way to do emphasis, etc in org files
;; This will actually work anywhere, but will always use the org
;; syntax. TODO: write a more general function that adapts to the
;; current major mode (org, markdown, latex, etc)
(global-set-key (kbd "C-c e") 'org-emphasize)


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
;; (require 'adaptive-soft-wrap)
;; (add-hook 'visual-line-mode-hook 'adaptive-soft-wrap-mode)
;; (setq visual-line-fringe-indicators (quote (left-curly-arrow right-curly-arrow)))
;; (add-hook 'emacs-lisp-mode-hook 'visual-line-mode)
;; (add-hook 'swift-mode-hook 'visual-line-mode)
;; (add-hook 'python-mode-hook 'visual-line-mode)

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
(add-hook 'text-mode-hook #'turn-on-visual-line-mode)

(add-hook 'LaTeX-mode-hook '(lambda () 
			      (set-variable 'line-spacing 5)
			      ;; TeX-PDF-mode is set in customize
			      (reftex-mode t)
			      ))


;; Use the echo area to display tooltips that are present at point position
(setq help-at-pt-timer-delay 0)
(help-at-pt-set-timer) 
(setq help-at-pt-display-when-idle t)

;; 27 Aug 2014 - Useful bindings for M-1, M-2, M-3, etc
(load "wjh-emacs-meta-digits")

;; WJH 06 Oct 2016 - saner behavior for prettified symbols
(setq prettify-symbols-unprettify-at-point 'right-edge)
(global-prettify-symbols-mode)
