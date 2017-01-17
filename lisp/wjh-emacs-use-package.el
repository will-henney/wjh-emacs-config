;; Third party add-on packages that are not shipped with Emacs
;; 16 Jan 2017 : Ported to John Wiegley's use-package

;; (eval-when-compile
;;   (require 'use-package))
(require 'use-package)
(require 'diminish)
(require 'bind-key)   


;; 25 Sep 2016 - do the opposite of fill
(use-package unfill
  :ensure t)


;; 21 Jun 2015 - lispy mode (another abo-abo package)
(use-package lispy
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))))



;; Key chord stuff in wjh-emacs-addon-packages.el
(use-package key-chord
  :ensure t)
;; Skipping for now 16 Jan 2017, maybe partially reinstate later


;; 21 Jun 2015 - fancy-narrow
(use-package fancy-narrow
  :ensure t
  :config
  (fancy-narrow-mode))


;; 20 Jun 2015 - Lots of packages by Oleh Krehel (abo-abo)

;; Hydra stuff
(load "wjh-hydra")

(use-package avy
  :ensure t
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char)
  ;; Docs suggest C-' but I use that for shell-switcher
  (global-set-key (kbd "C-\"") 'avy-goto-char-2)
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  (global-set-key (kbd "M-g g") 'avy-goto-line)
  (avy-setup-default))


;; Paradox uses a private github token
;; The following file should NOT be commited to any pulic repo
;; A copy can be found in a Secure Note in my 1Password vault
(load "wjh-private-stuff")

(use-package swiper
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  ;; 22 Nov 2016 - I prefer the regular isearch to swiper I think
  ;; (global-set-key "\C-s" 'swiper)
  ;; (global-set-key "\C-r" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (setq magit-completing-read-function 'ivy-completing-read)
  (setq projectile-completion-system 'ivy))

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "C-x o") 'ace-window))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))


;; 20 Jun 2015
;; Try out deft for organising note files
;; See http://pragmaticemacs.com/emacs/make-quick-notes-with-deft/
(use-package deft
  :ensure t
  :config
  (setq deft-directory "~/Dropbox/Notes")
  (setq deft-extension "org")
  (setq deft-text-mode 'org-mode)
  (setq deft-use-filename-as-title t)
  (setq deft-use-filter-string-for-filename t)
  (setq deft-auto-save-interval 0)
  ;;key to launch deft
  (global-set-key (kbd "C-c o") 'deft))

;; 26 May 2015 - generic modes
(use-package generic-x)

;; What is this doing here? Should be somewhere else?
(global-set-key (kbd "M-/") 'hippie-expand)


;; 03 Dec 2014 - spelling and grammar
;; Inspired by https://joelkuiper.eu/spellcheck_emacs
(use-package flyspell
  :ensure t
  :config
  ;; Use hunspell if available 
  (when (executable-find "hunspell")
    (setq-default ispell-program-name "hunspell")
    (setq ispell-really-hunspell t))
  (global-set-key [s-down-mouse-1] 'flyspell-correct-word))


;; Use langtool 
(use-package langtool
  :ensure t
  :config
  (setq langtool-language-tool-jar 
	"/usr/local/Cellar/languagetool/2.8/libexec/languagetool-commandline.jar"
	langtool-mother-tongue "en"
	langtool-disabled-rules '("WHITESPACE_RULE"
				  "EN_UNPAIRED_BRACKETS"
				  "COMMA_PARENTHESIS_WHITESPACE"
				  "EN_QUOTES"))
  (global-set-key "\C-x4w" 'langtool-check)
  (global-set-key "\C-x4W" 'langtool-check-done)
  (global-set-key "\C-x4l" 'langtool-switch-default-language)
  (global-set-key "\C-x44" 'langtool-show-message-at-point)
  (global-set-key "\C-x4C" 'langtool-correct-buffer)
  (defun langtool-autoshow-detail-popup (overlays)
    (when (require 'popup nil t)
      ;; Do not interrupt current popup
      (unless (or popup-instances
		  ;; suppress popup after type `C-g' .
		  (memq last-command '(keyboard-quit)))
	(let ((msg (langtool-details-error-message overlays)))
	  (popup-tip msg)))))
  (setq langtool-autoshow-message-function
	'langtool-autoshow-detail-popup))


;; 27 Aug 2014 - popup git commit messages
(use-package git-messenger
  :ensure t
  :config
  (global-set-key (kbd "C-x v p") 'git-messenger:popup-message))



;; 31 Jul 2014 - Delete all whitespace
;; 05 Dec 2014 - No, I didn't like this much, at least not to be
;; turned on all the time.  It hijacks the delete key and many times I
;; deleted more than I wanted and had to undo.
(use-package hungry-delete
  :ensure t
  :config
  ;; (global-hungry-delete-mode)
  ;; 05 Dec 2014 - Just put it on control delete in case we want it ever
  (global-set-key (kbd "C-DEL") 'hungry-delete-backward))


;; 14 Jul 2014 - change default file for calc settings
(use-package calc
  :config
  (setq calc-settings-file "/Users/will/.emacs.d/calc-settings.el"))


;; 14 Apr 2014 - Use ibuffer and ibuffer-vc
(use-package ibuffer
  :ensure t
  :config
  ;; Override the standard list-buffers command
  (defalias 'list-buffers 'ibuffer)
  (add-hook 'ibuffer-hook
	    (lambda ()
	      ;; Make mouse clicks work as in dired, etc
	      (define-key ibuffer-name-map [(mouse-1)] 'ibuffer-visit-buffer)
	      ;; Sort by VC root
	      (ibuffer-vc-set-filter-groups-by-vc-root)
	      (unless (eq ibuffer-sorting-mode 'alphabetic)
		(ibuffer-do-sort-by-alphabetic))))
  ;; Use human readable Size column instead of original one
  ;; Original written by http://www.emacswiki.org/emacs/Yen-Chin%2cLee#coldnew
  ;; Copied from http://www.emacswiki.org/emacs/IbufferMode
  ;; Modified WJH 14 Apr 2014 to use fewer sig figs
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fK" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))
  ;; Add a column showing VC status 
  (setq ibuffer-formats
	'((mark modified read-only vc-status-mini " "
		(name 32 32 :left :elide)
		" "
		(size-h 9 -1 :right)
		" "
		(mode 16 16 :left :elide)
		" "
		;; (vc-status 16 16 :left)
		;; " "
		filename-and-process))))

(use-package ibuffer-vc
  :ensure t)


;; 27 Feb 2014 - Try out smex
;; https://github.com/nonsequitur/smex/blob/master/README.markdown
(use-package smex
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))


(use-package stripe-buffer
  :ensure t
  :config
  ;; 24 Feb 2014 - Use stripe-buffer in tables
  (add-hook 'dired-mode-hook 'turn-on-stripe-buffer-mode)
  (add-hook 'tsv-mode-hook 'turn-on-stripe-buffer-mode)
  ;; 16 Jan 2017 - Not in org mode - too slow!
  ;; (add-hook 'org-mode-hook 'turn-on-stripe-table-mode)
  )
  
;; 16 Jan 2017 - Prodigy stuff for ipython notebooks ditched since I
;; no longer use it


;; 25 Nov 2013 - stuff inspired by Magnar Sveen's config
;; https://github.com/magnars/.emacs.d/blob/master/init.el

;; ido vertical mode - much easier to take in the options at a glance
(use-package ido-vertical-mode
  :ensure t
  :config
  (ido-vertical-mode))

;; expand-region - this is great!
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; 28 Jan 2015 - Similar to expand-region, but possibly even better.
;; Let's try out easy-kill!
(use-package easy-kill
  :ensure t
  :config
  ;; Replace M-w - should work as command and as prefix
  (global-set-key [remap kill-ring-save] 'easy-kill)
  ;; Replace C-M-@ (need a better keybinding!  Note that C-M-SPACE is
  ;; taken by Alfred on my Macbook
  (global-set-key [remap mark-sexp] 'easy-mark))

;; Now the mappings for easy-mark-extras
(use-package easy-kill-extras
  :ensure t
  :config
  (global-set-key [remap mark-word] 'easy-mark-word)
  (global-set-key [remap zap-to-char] 'easy-mark-to-char)
  (global-set-key [remap zap-up-to-char] 'easy-mark-up-to-char)
  (define-key easy-kill-base-map (kbd "C-d") 'easy-kill-delete-region)
  (define-key easy-kill-base-map (kbd "DEL") 'easy-kill-delete-region))
;; Note that customizations to easy-kill-alist are in custom file


;; 04 Nov 2013 - persistent scratch buffer
(use-package persistent-scratch
  :ensure t)


;; 04 Nov 2013 - try out guide key
;; 16 Jan 2017 - No longer use my custom version since it is obsolete
(use-package guide-key
  :ensure t
  :config
  (guide-key-mode 1)  ; Enable guide-key-mode
  (setq guide-key/guide-key-sequence '("C-x" "C-c"))
  (setq guide-key/recursive-key-sequence-flag t)
  (setq guide-key/popup-window-position 'bottom)
  (setq guide-key/idle-delay 2.0)
  (defun guide-key/my-hook-function-for-org-mode ()
    (guide-key/add-local-guide-key-sequence "C-c")
    (guide-key/add-local-guide-key-sequence "C-c C-x")
    (guide-key/add-local-highlight-command-regexp "org-"))
  (add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode))



;; 04 Nov 2013 - try out google-this
(use-package google-this
  :ensure t
  :config
  (google-this-mode 1)
  (global-set-key (kbd "C-x g") 'google-this-mode-submap))
;; To start a blank search, do google-search ("C-c / RET" or "C-x g
;; RET"). If you want more control of what "under point" means for the
;; google-this command, there are the google-word, google-symbol,
;; google-line and google-region functions, bound as w, s, l and r,
;; respectively. They all do a search for what's under point.

;; If the google-wrap-in-quotes variable is t, than searches are
;; enclosed by double quotes (default is NOT). If a prefix argument is
;; given to any of the functions, invert the effect of
;; google-wrap-in-quotes.

;; There is also a google-error (C-c / e) function. It checks the
;; current error in the compilation buffer, tries to do some parsing
;; (to remove file name, line number, etc), and googles it. It's still
;; experimental, and has only really been tested with gcc error
;; reports.


;; 04 Nov 2013 - try out anchored transpose, for swapping two regions around a static part
(use-package anchored-transpose
  :ensure t
  :config
  (global-set-key [?\C-x ?t] 'anchored-transpose))
;; Test of anchored transpose: 
;;
;; FROM: I want this phrase but not that word.
;; TO: I want that word but not this phrase.
;;
;; 1. Select "this phrase but not that word"
;; 2. Type "C-x t"
;; 3. Select "but not" as anchor
;; 4. Type "C-x t" again


;; Various package that have nothing in common except for the word
;; "smart" in their names!

;; 03 Nov 2013 - try out smartparens
(use-package smartparens
  :ensure t
  :config
  (use-package smartparens-config)
  (load "wjh-smartparens-config"))
;; 03 Jul 2015 - switch back to MELPA version
;; 10 Nov 2014 - force the github version which I have patched for 24.4
;; (require 'smartparens-config (concat wjh-local-lisp-dir
;; 				     "/smartparens/smartparens-config.el"))


;; 03 Nov 2013 - try out smartscan
;; (why does everything have to be smart these days?!)
;; This is sort of like occur or isearch, but different
;; M-n or M-p just jump to next or prev occurence of the word under point
;; Just like that, no fuss, no fancy UI or highlighting
(use-package smartscan
  :ensure t
  :config
  (global-smartscan-mode 1))

(use-package smart-mode-line
  :ensure t
  :init
  ;; 26 Oct 2013 - Try out smart-mode-line
  (setq sml/theme 'dark)
  ;; These are minor modes that we don't want to see cluttering up the modeline
  (setq sml/hidden-modes
	(mapconcat 'identity 
		   '(" hl-p" " Undo-Tree" " MRev" " Projectile.*" " SP"
		     " Google" " Guide" " Helm" " Ind" " GG" " OCDL"
		     " Ref" " Wrap")
		   "\\|"))
  :config
  (if after-init-time (sml/setup)
    (add-hook 'after-init-hook 'sml/setup))
  ;; Vars moved from cutomize - 10 Dec 2014
  (setq
   sml/inactive-background-color "#222233"
   sml/name-width 20))


;; Latex stuff
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode))

;; Miss out the latex-extra stuff for now


;; 12 Oct 2013 - try projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching nil)
  (setq projectile-require-project-root nil)
  (setq projectile-switch-project-action 'projectile-dired)
  (setq projectile-remember-window-configs t) 
  (setq projectile-find-dir-includes-top-level t)
  (define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
  (define-key projectile-mode-map [?\s-p] 'hydra-projectile/body)
  (define-key projectile-mode-map [?\s-f] 'projectile-find-file)
  (define-key projectile-mode-map [?\s-g] 'projectile-grep))

;; projectile recommends use of flx-ido
(use-package flx-ido
  :ensure t
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil))


;; 18 Apr 2013 - try fancy bullets
(use-package org-bullets
  :ensure t
  :config
  ;; http://nadeausoftware.com/articles/2007/11/latency_friendly_customized_bullets_using_unicode_characters
  ;; Reserve list: 
  ;; "✸" "◰" "►" "★" "⬓" "☀" "☛" "☼" "⚛" "☯" "⬡"
  ;; "➽" "⚀" "⚁" "⚂" "⚃" "⚄" "⚅"
  ;; ◐ ◑ ◒ ◓
  ;; ♣ ♥ ♦ ♠ ♧ ♡ ♢ ♤
  (add-hook 'org-mode-hook (lambda () 
			     (setq org-bullets-bullet-list
				   '("⚀" "⚁" "⚂" "⚃" "⚄" "⚅"
				     "♧" "♡" "♢" "♤" "♣" "♥" "♦" "♠"))
			     (org-bullets-mode 1))))

;; 17 Apr 2013 - markdown mode installed with package manager
(use-package markdown-mode
  :ensure t
  :mode ("\\.markdown\\'" "\\.md\\'")
  )


;; 31 Aug 2012: Magit is magic!
(use-package magit
  :ensure t
  :bind ("C-c i" . magit-status))


