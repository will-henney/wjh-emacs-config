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

;; What is this doing here? Should be somewhere else?
(global-set-key (kbd "M-/") 'hippie-expand)

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



