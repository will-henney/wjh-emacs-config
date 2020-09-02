;; Third party add-on packages that are not shipped with Emacs
;; 16 Jan 2017 : Ported to John Wiegley's use-package

;;* TODO: 06 Sep 2018 : port my setup over to straight.el
;;* https://github.com/raxod502/straight.el
;;* This can replace package.el and elpa and parts of use-package


;; (eval-when-compile
;;   (require 'use-package))
(require 'use-package)

;; On first run on a ne machines, diminish and bindkey neet to be installed
(use-package diminish
  :ensure t)
(use-package bind-key
  :ensure t)


;; 12 May 2017 - try out quelpa for getting non-elpa versions of
;; packages directly from github and local files
;; (ignore-errors
;;   (if (require 'quelpa nil t)
;;       (quelpa-self-upgrade)
;;     (with-temp-buffer
;;       (url-insert-file-contents
;;        "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
;;       (eval-buffer))))

(use-package quelpa-use-package
  :ensure t
  :init (setq quelpa-update-melpa-p nil))

;; Quelpa uses MELPA's recipe format (see
;; https://github.com/melpa/melpa), but with the addition of
;; additional fetchers, for example "file" for single-file packages
;; from local .el files
(use-package spanish-simple-prefix
  :quelpa ((spanish-simple-prefix
	    :fetcher file
	    :path "~/.emacs.d/lisp/spanish-simple-prefix.el")
	   :update t)
  :config (setq default-input-method "spanish-simple-prefix"))

;; Note that the package file needs to have header comments that
;; conform to the conventional format for Emacs libraries, see
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Headers.html
;; One easy way to do that is to use `make-header` from header2.el

;; Original motivation was to use the org-mode master branch
;; But I haven't got round to this yet
;; Example here: https://emacs.stackexchange.com/a/26510/1980

(use-package org
  :quelpa (org :fetcher git)
  )


;; 14 Jul 2020 - org-roam
(setq org-roam-directory "~/org-roam")
(add-hook 'after-init-hook 'org-roam-mode)

;; 31 Mar 2020 - Try out this, looks good: https://github.com/alphapapa/org-sidebar
(use-package org-sidebar
  :quelpa (org-sidebar :fetcher github :repo "alphapapa/org-sidebar"))

;; 02 Sep 2017 - utility functions for writing your own elisp packages
;; 19 Jan 2020 - Cannot seem to install this package
;; (use-package header2
;;   :ensure t)


;; Yaml mode is included in emacs, but there is a newer version on github
;; This incorporates code for outline mode from this issue: https://github.com/yoshiki/yaml-mode/issues/25
(use-package yaml-mode
  :ensure t
  :mode (".yaml$")
  :hook
  (yaml-mode . yaml-mode-outline-hook)

  :init
  (defun yaml-outline-level ()
    "Return the outline level based on the indentation, hardcoded at 2 spaces."
    (s-count-matches "[ ]\\{2\\}" (match-string 0)))

  (defun yaml-mode-outline-hook ()
    (outline-minor-mode)
    (setq outline-regexp
	  "^\\([ ]\\{2\\}\\)*\\([-] \\)?\\([\"][^\"]*[\"]\\|[a-zA-Z0-9_-]*\\):")
    (setq outline-level 'yaml-outline-level))
  )



;; 27 Apr 2017 - new mail config
;; Based on a bizarre hybrid of the following sites:
;; + http://pragmaticemacs.com/emacs/master-your-inbox-with-mu4e-and-org-mode/
;; + http://www.ict4g.net/adolfo/notes/2014/12/27/EmacsIMAP.html
;; + https://github.com/cocreature/dotfiles/blob/master/emacs/.emacs.d/emacs.org
;; + http://www.djcbsoftware.nl/code/mu/mu4e/Contexts.html
(use-package mu4e
  :load-path "/usr/local/Cellar/mu/0.9.18/share/emacs/site-lisp/mu/mu4e"
  :commands mu4e
  :config
  ;; (setq mu4e-get-mail-command "/usr/local/bin/mbsync -a")
  ;; Get mail manually to start with - when things are working, switch to the above
  (setq mu4e-get-mail-command t)
  ;; a  list of user's e-mail addresses
  (setq mu4e-user-mail-address-list
	'("whenney@gmail.com" "will@henney.org" "w.henney@irya.unam.mx"))
  ;; Different set-ups for different accounts
  (setq mu4e-contexts
	`(,(make-mu4e-context
	    :name "icloud"
	    :enter-func (lambda () (mu4e-message "Switch to icloud context"))
	    :match-func (lambda (msg)
			  (when msg
			    (s-prefix? "/icloud/" (mu4e-message-field msg :maildir))))
	    :vars '((user-mail-address . "deprecated@icloud.com")
		    (mu4e-sent-folder . "/icloud/Sent Messages")
		    (mu4e-drafts-folder . "/icloud/Drafts")
		    (mu4e-trash-folder . "/icloud/Deleted Messages")))
	  ,(make-mu4e-context
	    :name "gmail"
	    :enter-func (lambda () (mu4e-message "Switch to gmail context"))
	    :match-func (lambda (msg)
			  (when msg
			    (s-prefix? "/gmail/" (mu4e-message-field msg :maildir))))
	    :vars '((user-mail-address . "whenney@gmail.com")
		    (mu4e-sent-folder . "/gmail/sent")
		    (mu4e-drafts-folder . "/gmail/drafts")
		    (mu4e-trash-folder . "/gmail/trash")
		    (mu4e-sent-messages-behavior . delete)
		    ))
	  ))
  (setq mu4e-html2text-command "/usr/local/bin/w3m -t 2 -graph -S -T text/html")
  ;; (setq mu4e-html2text-command 'mu4e-shr2text)
  (setq mu4e-view-show-addresses t)
  (setq mu4e-headers-include-related t)
  (setq mu4e-headers-show-threads nil)
  (setq mu4e-headers-skip-duplicates t)
  (setq mu4e-split-view 'horizontal)
  (setq
   user-full-name  "William Henney"
   mu4e-compose-signature ""
   mu4e-compose-signature-auto-include nil
   mu4e-attachment-dir "~/Downloads")
  (setq mu4e-maildir-shortcuts
	'(("/gmail/inbox"     . ?g)
	  ("/icloud/inbox"       . ?i)))
  )




;; 14 Jul 2020 - spotlight
(use-package spotlight
  :bind
  (("s-SPC" . spotlight))
  :ensure t)

;; 25 Sep 2016 - do the opposite of fill
(use-package unfill
  :bind
  (("M-Q" . unfill-paragraph))
  :ensure t)


;; 26 Aug 2020 - DISABLE lispy mode since I suspect that it might be causing hangs
;; 21 Jun 2015 - lispy mode (another abo-abo package)
;; (use-package lispy
;;   :ensure t
;;   :config
;;   (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))))



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
  ;; Now that I don't use helm, I can use C-. instead
  (global-set-key (kbd "C-.") 'avy-goto-char-2)
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  (global-set-key (kbd "M-g g") 'avy-goto-line)
  (avy-setup-default))


;; Paradox uses a private github token
;; The following file should NOT be commited to any pulic repo
;; A copy can be found in a Secure Note in my 1Password vault
(load "wjh-private-stuff")

(use-package paradox
  :ensure t)

;; 01 Sep 2017
;; all-the-icons uses special icon fonts, so that the icons behave a
;; lot better (scale with surrounding text, can have properties, etc)

(when (display-graphic-p)
  (use-package all-the-icons
    :ensure t)
  ;; After installing for first time (only), we need to also install the
  ;; fonts via M-x all-the-icons-install-fonts

  ;; See below for the application of this to dired

  ;; Use the icons for ivy
  ;;
  ;; TODO: There is a strange space between the icon and the completion
  ;; candidate
  (use-package all-the-icons-ivy
    :ensure t
    :config (all-the-icons-ivy-setup))
  ;; Quick patches to fix spacing of icons in above package
  (defun all-the-icons-ivy--buffer-transformer (b s)
    "Return a candidate string for buffer B named S preceded by an icon.
Try to find the icon for the buffer's B `major-mode'.
If that fails look for an icon for the mode that the `major-mode' is derived from."
    (let* ((mode (buffer-local-value 'major-mode b))
	   (icon (or (all-the-icons-ivy--icon-for-mode mode)
		     (all-the-icons-ivy--icon-for-mode (get mode 'derived-mode-parent))
		     (all-the-icons-octicon "eye"))))
      (format "%s %s"
	      (propertize "@" 'display icon)
	      (all-the-icons-ivy--buffer-propertize b s))))
  (defun all-the-icons-ivy-file-transformer (s)
    "Return a candidate string for filename S preceded by an icon."
    (format "%s %s"
	    (propertize "@" 'display (all-the-icons-icon-for-file s))
	    s)))


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
  (setq projectile-completion-system 'ivy)
  :bind (("C-c v" . ivy-push-view)
	 ("C-c V" . ivy-pop-view)))

(use-package counsel
  ;; 27 Apr 2017 - I don't bind anything here yet
  :ensure t
  ;; 01 Sep 2017 - add default bindings ∰ 😻 💣
  :bind (("M-x" . counsel-M-x) 
	 ("C-x C-f" . counsel-find-file)
	 ("C-h v" . counsel-describe-variable)
	 ("C-h f" . counsel-describe-function)
	 ("C-c g" . counsel-rg)
	 ("C-c u" . counsel-unicode-char)))

(use-package ivy-hydra
  :ensure t)

(use-package counsel-projectile
  :ensure t
  ;; :config
  ;; (counsel-projectile-on)
  )

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
  (setq deft-default-extension "org")
  (setq deft-extensions '("org" "txt" "text" "md" "markdown"))
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

;; 26 Sep 2017: Big effort to get my spelling configuration sorted

(defun clean-hunspell-config ()
  "Attempt to auto-setup the hunspell dicts for ispell

This relies on ispell automatically parsing the hunspell .aff
files to populate the dictionary alist.  But then we have
problems with apostrophes at the emacs word recognition
level (although they work fine in hunspell itself). This is
because the othercars parameter is not set properly. "
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-dictionary "en_US,en_GB-large")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,en_GB-large"))

(defun hackish-hunspell-config ()
  "Set up `ispell-local-dictionary-alist` by hand

I didn't want to mess with the alist directly, but there seems to
be no choice.  Otherwise, words with internal apostrophes are not
recognised."
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-dictionary "english")
  (setq ispell-local-dictionary-alist
	`(("english" "[[:alpha:]]" "[^[:alpha:]]" "[0-9’']" t
	   ("-d" "en_US,en_GB-large") nil utf-8)
	  ("es_MX" "[[:alpha:]]" "[^[:alpha:]]" "[0-9]" t
	   ("-d" "es_MX") nil utf-8)))
  ;; If I don't do an explicit ispell-change-dictionary, then the
  ;; dictionary ends up being nil, which is no good
  (ispell-change-dictionary "english"))

;; Old version inspired by https://joelkuiper.eu/spellcheck_emacs
;; 
;; New version worked out on my own mainly, with some inspiration from
;; http://gromnitsky.blogspot.mx/2016/09/emacs-251-hunspell.html
;; although some of those recommendations didn't work 
(use-package flyspell
  :ensure t
  :init
  (add-hook 'text-mode-hook #'flyspell-mode)
  ;; In programming modes, flyspell is only activated in comments snd
  ;; strings
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  :config
  ;; Use hunspell if available 
  (when (executable-find "hunspell")
    (setq-default ispell-program-name (executable-find "hunspell"))
    (setq ispell-really-hunspell t)
    (hackish-hunspell-config)
    )
  ;; 10 Aug 2017: restore this since the next bit doesn't work
  (define-key flyspell-mouse-map [s-down-mouse-1] 'flyspell-correct-word))


;; This is a more general solution for emulating middle mouse clicks
;; Found here: https://emacs.stackexchange.com/a/20948/1980
;; (define-key key-translation-map (kbd "<s-down-mouse-1>") (kbd "<down-mouse-2>"))


;; 25 Sep 2017 - try out guess-language for auto-switching between
;; English and Spanish.  Note that it only really works with flyspell,
;; so we turn that on in the previous section.
(use-package guess-language
  :ensure t
  :init
  ;; Turns out not to be a good idea in latex mode, since it keeps
  ;; thinking that command arguments are spanish.  So ... we will not
  ;; start it automatically any more.
  ;; 
  ;; (add-hook 'text-mode-hook #'guess-language-mode)
  :config
  (setq guess-language-langcodes '((en . ("english" nil))
				   (es . ("es_MX" nil)))
	guess-language-languages '(en es)
	guess-language-min-paragraph-length 20)
  :diminish guess-language-mode)

;; 25 Sep 2017 - typo.el is not for typographic errors, but rather for
;; smart quotes and the like.  Adds a lot of bindings on "C-c 8"
;; suffix
(use-package typo
  :ensure t
  :config
  (typo-global-mode 1)
  ;; 16 Oct 2017 - turned this off, since it annoyingly hijacks the
  ;; quote keys, but we keep the typo-global-mode because that is more
  ;; useful (C-c 8 bindings)
  ;; (add-hook 'text-mode-hook 'typo-mode)
  )


;; Use langtool for grammar analysis (where did I get this from?)
(use-package langtool
  :ensure t
  :config
  (when (executable-find "languagetool")
    (setq langtool-version
	  (nth 2 (split-string
		  (shell-command-to-string "languagetool --version"))))
    (setq langtool-language-tool-jar 
	  (format
	   "/usr/local/Cellar/languagetool/%s/libexec/languagetool-commandline.jar"
	   langtool-version)
	  langtool-mother-tongue "en"
	  langtool-disabled-rules '("WHITESPACE_RULE"
				    "DASH_RULE"
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
	  'langtool-autoshow-detail-popup)))


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
  ;; 18 Sep 2017 - Disable default binding because I use ivy/counsel now
  ;; (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "C-c C-c C-c M-x") 'smex)
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
(setq google-this-keybind (kbd "C-x g"))
(use-package google-this
  :ensure t
  :config
  (google-this-mode 1)
  )
;; To start a blank search, do google-search ("C-c / RET" or "C-x g
;; RET"). If you want more control of what "under point" means for the
;; google-this command, there are the google-word, google-symbol,
;; google-line and google-region functions, bound as w, s, l and r,
;; respectively. They all do a search for what's under point.

;; If the google-wrap-in-quotes variable is t, then searches are
;; enclosed by double quotes (default is NOT). If a prefix argument is
;; given to any of the functions, invert the effect of
;; google-wrap-in-quotes.

;; There is also a google-error (C-c / e) function. It checks the
;; current error in the compilation buffer, tries to do some parsing
;; (to remove file name, line number, etc), and googles it. It's still
;; experimental, and has only really been tested with gcc error
;; reports.


;; 04 Nov 2013 - try out anchored transpose, for swapping two regions around a static part
;; 19 Jan 2020 - This packages has been dropped from MELPA because it comes from emacs-wiki
;; (use-package anchored-transpose
;;   :ensure t
;;   :config
;;   (global-set-key [?\C-x ?t] 'anchored-transpose))
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
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-PDF-mode t)
  ;; Use Skim as viewer, enable source <-> PDF sync
  ;; make latexmk available via C-c C-c
  ;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
  (push '("latexmk" "latexmk -synctex=1 -pdf %s" TeX-run-TeX nil t
	  :help "Run latexmk on file")
	TeX-command-list)
  (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
  ;; use Skim as default pdf viewer
  ;; Skim's displayline is used for forward search (from .tex to .pdf)
  ;; option -b highlights the current line; option -g opens Skim in the background
  ;; 16 Jun 2017: remove -g option 
  (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  (setq TeX-view-program-list
	'(("PDF Viewer" "/Users/will/.emacs.d/bin/displayline -b %n %o %b")))
  ;; See also
  ;; http://stackoverflow.com/questions/7899845/emacs-synctex-skim-how-to-correctly-set-up-syncronization-none-of-the-exi
  (add-hook 'TeX-mode-hook
	    (lambda ()
	      (add-to-list 'TeX-output-view-style
			   '("^pdf$" "."
			     "/Users/will/.emacs.d/bin/displayline -b %n %o %b"))))
  ;; Extras for LaTeX editing 29 Mar 2013
  ;; Code copied from tex.stackexchange
  ;; http://tex.stackexchange.com/questions/27241/entering-math-mode-in-auctex-using-and
  (add-hook 'LaTeX-mode-hook 
	    '(lambda ()
	       (define-key TeX-mode-map "\C-cm" 'TeX-insert-inline-math)
	       (defun TeX-insert-inline-math (arg)
		 "Like TeX-insert-braces but for \\(...\\)" 
		 (interactive "P")
		 (if (TeX-active-mark)
		     (progn
		       (if (< (point) (mark)) (exchange-point-and-mark))
		       (insert "\\)")
		       (save-excursion (goto-char (mark)) (insert "\\(")))
		   (insert "\\(")
		   (save-excursion
		     (if arg (forward-sexp (prefix-numeric-value arg)))
		     (insert "\\)"))))))
  ;; Drag and drop files onto latex buffer
  ;; Copied from SO answer;
  ;; http://emacs.stackexchange.com/questions/16318/drag-and-drop-images-to-auctex
  (defcustom AUCTeX-dnd-format "\\includegraphics[width=\\linewidth]{%s}"
    "What to insert, when a file is dropped on Emacs window. %s is
replaced by the actual file name. If the filename is located
under the directory of .tex document, only the part of the name
relative to that directory in used."
    :type 'string
    :group 'AUCTeX)
  ;; Modified version
  (defun AUCTeX-dnd-includegraphics (uri action)
    "Insert the text defined by `AUCTeX-dnd-format' when a file is
dropped on Emacs window."
    (let ((file (dnd-get-local-file-name uri t)))
      (when (and file (file-regular-p file))
	(if (string-match default-directory file)
	    (insert (format AUCTeX-dnd-format (file-name-nondirectory file)))
	  (insert (format AUCTeX-dnd-format file))
	  )
	)
      )
    )
  (defcustom AUCTeX-dnd-protocol-alist
    '(("^file:///" . AUCTeX-dnd-includegraphics)
      ("^file://"  . dnd-open-file)
      ("^file:"    . AUCTeX-dnd-includegraphics))
    "The functions to call when a drop in `mml-mode' is made.
See `dnd-protocol-alist' for more information.  When nil, behave
as in other buffers."
    :type '(choice (repeat (cons (regexp) (function)))
		   (const :tag "Behave as in other buffers" nil))
    :version "22.1" ;; Gnus 5.10.9
    :group 'AUCTeX)
  (define-minor-mode AUCTeX-dnd-mode
    "Minor mode to inser some text (\includegraphics by default)
when a file is dopped on Emacs window."
    :lighter " DND"
    (when (boundp 'dnd-protocol-alist)
      (if AUCTeX-dnd-mode
	  (set (make-local-variable 'dnd-protocol-alist)
	       (append AUCTeX-dnd-protocol-alist dnd-protocol-alist))
	(kill-local-variable 'dnd-protocol-alist))))
  (add-hook 'LaTeX-mode-hook 'AUCTeX-dnd-mode)
  ;; RefTeX needs extra help to find files that are not in the current
  ;; directory (added 07 Jul 2008)
  (setq reftex-use-external-file-finders t)
  (setq reftex-external-file-finders
	'(("tex" . "kpsewhich -format=.tex %f")
	  ("bib" . "kpsewhich -format=.bib %f")))
  )

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

;; 03 May 2017 - Use Ag for searching in project (executable must be
;; installed, e.g. ,via homebrew)
(use-package ag :ensure t)

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
  :bind ("C-c i" . magit-status)
  :config
  (setq magit-repository-directories
	`((,(expand-file-name "~/Dropbox") . 5)
	  (,(expand-file-name "~/Source") . 1)
	  (,(expand-file-name "~/Family") . 1)
	  (,(expand-file-name "~/Work") . 5))))


;; 14 May 2019 - add TODO section to magit buffer
(use-package magit-todos :ensure t)


;; 30 Jan 2020 - this package is magical - it seems to sort out my
;; conda problems. It also supersedes the
;; `set-exec-path-from-shell-PATH` function I had in
;; wjh-emacs-mac-specific.el
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


;; Trying something new 10 Mar 2013: https://github.com/jorgenschaefer/elpy/wiki
(load "wjh-python-elpy-config")

;; And try and set up better treatment of doc strings
(use-package python-docstring
  :ensure t
  :config
  (add-hook 'python-mode-hook (lambda () (python-docstring-mode t))))

;; 16 Apr 2019 - Try out emacs-jupyter
(use-package websocket
  :quelpa ((websocket :fetcher github :repo "ahyatt/emacs-websocket")
	   :upgrade nil))
(use-package simple-httpd
  :quelpa ((simple-httpd :fetcher github :repo "skeeto/emacs-web-server")
	   :upgrade nil))
;; (use-package zmq
;;   :quelpa ((zmq :fetcher github :repo "dzop/emacs-zmq")
;; 	   ))
;; (use-package jupyter
;;   :quelpa ((jupyter :fetcher github :repo "dzop/emacs-jupyter")
;; 	   :upgrade t))

;; And also try out emacs ipython notebook
(use-package ein :ensure t)


;; 22 Sep 2011 - also put org early on
;; Let's use org-mode!
;; (use-package org
;;   :ensure t
;;   ;; :ensure org-plus-contrib
;;   :pin org
;;   :config (load "wjh-org-config"))

;; 04 Sep 2017 - Try and use org master branch via quelpa
;; 20 Jan 2020 - comment out for now since repo is down
(load "wjh-org-config")
;; (with-demoted-errors "Org-mode update error: %S"
;;   (use-package org
;;     :quelpa ((org
;; 	      :fetcher git
;; 	      :url "https://code.orgmode.org/bzg/org-mode.git")
;; 	     :update t)
;;     :config (load "wjh-org-config")))

;; 2020-08-26 - Try and patch bibtex mode command to stop errors
;; during bibtex-parse-buffers-stealthily
(use-package bibtex
  :config
  (defsubst bibtex-type-in-head ()
    "Extract BibTeX type in head."
    ;; WJH 2020-08-26 - allow for possibility that match-beginning or
    ;; match-end might return nil
    (buffer-substring-no-properties
     (1+ (or (match-beginning bibtex-type-in-head) 0))
     (or (match-end bibtex-type-in-head) 1))))



;; 04 Sep 2017 - this will grab all my files from the
;; `org-dropbox-note-dir` and file them in an org datetree file.
;;
;; So, I could use Workflow or something on iOS to save snippets to
;; this folder, then they will be picked up by Org
(use-package org-dropbox
  :ensure t
  :config
  (setq org-dropbox-note-dir "~/Dropbox/org-dropbox-inbox/")
  (setq org-notes-datetree-file "~/Dropbox/Org/org-dropbox-datetree.org"))

;; 14 Oct 2018 - try out John Kit chin's org-ref
;; 15 Oct 2018 - it was nice, but it makes emacs *realLy* slow
;; (use-package org-ref
;;   :ensure t
;;   :config
;;   (setq org-ref-completion-library 'org-ref-ivy-cite))

;; 04 Sep 2017 - inserts the filesystem subtree for a given directory
;;
;; This is an old package (last release 2009), but I want to check if
;; it still works
;; 20 Jan 2020 - Not on MELPA any more, so disabled
;; (use-package org-fstree :ensure t)


;; misc packages
(use-package fold-dwim :ensure t)
(use-package fold-dwim-org :ensure t)

(use-package comint
  :bind (:map comint-mode-map
	      ("M-p" . comint-previous-matching-input-from-input)
	      ("M-n" . comint-next-matching-input-from-input)))

(use-package constants
  ;; :ensure t
  :commands (constants-insert constants-get constants-replace)
  :bind (("C-c c i" . constants-insert)
	 ("C-c c g" . constants-get)
	 ("C-c c r" . constants-replace))
  :config
  (setq constants-unit-system 'cgs)   ;  this is the default
  ;; Use "cc" as the standard variable name for speed of light,
  ;; "bk" for Boltzmann's constant, and "hp" for Planck's constant
  (setq constants-rename '(("cc" . "c") ("bk" . "k") ("hp" . "h")))
  ;; A default list of constants to insert when none are specified
  (setq constants-default-list "cc,bk,hp"))


(use-package csv-mode
  :ensure t
  :mode ("\\.tsv\\'" "\\.tab\\'"))

;; Following mention in this blog post
;; http://emacs-fu.blogspot.com/2010/04/navigating-kill-ring.html
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings)
  (setq browse-kill-ring-quit-action 'save-and-restore))

(use-package yaml-mode :ensure t :mode "\\.ya?ml$")


;; 29 Nov 2010 dired-x
(use-package dired-x
  :config
  (add-hook
   'dired-load-hook
   (lambda ()
     (load "dired-x")
     ;; 28 Jul 2014 - I don't like the "... omitting ..."
     ;; messages.  They get in the way.
     (setq dired-omit-verbose nil)
     ;; 18 Sep 2017 - This is good for when you have frame split in
     ;; two windows with different directpries in each.  Move and copy
     ;; commands will default to the directory in the other window
     ;;
     ;; Discovered in Emacs Rocks Epsiode 16: http://emacsrocks.com/e16.html
     (setq dired-dwim-target t)
     (dired-omit-mode 1)))
  (add-hook 'dired-mode-hook #'turn-on-auto-revert-mode)
  (customize-set-value 'auto-revert-verbose nil
		       "Prevent any auto-revert messages from
		     obscuring the minibuffer at crucial times!")
  ;; 08 Dec 2014 - Installed GNU coreutils from Homebrew - try using ls from that
  (when (executable-find "gls")
    (setq insert-directory-program "gls"))
  (setq dired-guess-shell-alist-user  ;quess shell command by file ext
	'(("\\.pdf\\'" "open" "open -a Adobe\\ Reader")
	  ("\\.png\\'" "open")
	  ("\\.jpg\\'" "open")
	  ("\\.avi\\'" "open")
	  ("\\.m4a\\'" "open")
	  ("\\.mov\\'" "open")
	  ("\\.gif\\'" "open -a Safari")
	  ("\\.doc\\'" "open -a TextEdit" "open -a Pages")))
  (defun wjh/dired-jump (&optional other-window)
    "Jump to dired buffer corresponding to current buffer.
Just like the `dired-jump' from `dired-x' except that interactively with
prefix argument set OTHER-WINDOW true."
    (interactive "P")
    (dired-jump other-window))
  ;; 13 Aug 2014 - A convenient binding for going up from a file to the enclosing dir
  (global-set-key (kbd "C-^") 'wjh/dired-jump)
  (global-set-key (kbd "M-6") 'wjh/dired-jump))

;; dired-details mode is obsolete - functionality is now built in
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Use the all-the-icons for dired
;; 
;; There was a bad interaction with dired-details, so that we get
;; bizarre extra boxes or icons when the dired buffer is in "hidden"
;; mode.  SOLVED (03 Sep 2017): by just setting the "hidden" indicator
;; to the empty string (you don't need it if you have the icons)

(when (display-graphic-p)
  (defun wjh/maybe-all-the-icons-dired-mode ()
    "Turn on `all-the-icons-dired-mode` if the directory is not too large"
    (when (<= (count-lines 1 (buffer-size)) 300)
      (all-the-icons-dired-mode 1)))

  (use-package all-the-icons-dired
    :ensure t
    :config
    (add-hook 'dired-after-readin-hook 'wjh/maybe-all-the-icons-dired-mode)
    (setq dired-details-hidden-string "")))



(use-package ido
  :ensure t
  :init
  (setq ido-enable-flex-matching t)
  :config
  (ido-mode)
  (setq ido-file-extensions-order 
	'(".org" ".tex" ".py" ".f90" ".xml" ".el"))
  )


(use-package eshell
  :ensure t
  :config
  ;; Eshell prompt configuration 23 Apr 2013 Initially based on code at
  ;; http://www.emacswiki.org/emacs/EshellPrompt but I have changed the
  ;; colors and split out the last element of the full path.  I also use
  ;; the rear-nonsticky property to make sure the prompt color does not
  ;; bleed into the rest of the command line.
  (setq eshell-prompt-function 
	(lambda nil
	  (concat
	   (propertize (car 
			(last 
			 (split-string 
			  (expand-file-name (eshell/pwd)) "/")))
		       'face `(:foreground "gray50"))
	   (propertize " $ " 
		       'face `(:foreground "orange" :weight 'bold) 
		       'rear-nonsticky t))))
  (setq eshell-highlight-prompt nil))

;; (use-package em-smart :ensure t)
;; (use-package em-rebind :ensure t)

(use-package shell-switcher
  :ensure t
  :config
  (setq shell-switcher-mode t)
  ;; WJH 25 Apr 2013 - use the Cmd key here since C-' is already mapped
  ;; in many modes
  (define-key shell-switcher-mode-map (kbd "s-'")
    'shell-switcher-switch-buffer)
  (define-key shell-switcher-mode-map (kbd "C-x 4 '")
    'shell-switcher-switch-buffer-other-window)
  (define-key shell-switcher-mode-map (kbd "s-M-'")
    'shell-switcher-new-shell)
  (add-hook 'eshell-mode-hook 'shell-switcher-manually-register-shell)
  )


;; 24 Apr 2013 - Try out keyfreq package, which compiles statistics on
;; use of keys.  To see them, use "M-x keyfreq-show".  See
;; https://github.com/dacap/keyfreq and Xah Lee's page at
;; http://ergoemacs.org/emacs/command-frequency.html, which has a
;; python script for analysing the results
(use-package keyfreq
  :ensure t
  :config
  (customize-set-value 'keyfreq-file "~/.emacs.d/emacs.keyfreq"
		       "Tidy this away, out of top-level home dir")
  (customize-set-value 'keyfreq-file-lock "~/.emacs.d/emacs.keyfreq.lock"
		       "Tidy this away, out of top-level home dir")
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))


(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  ;; Basic Usage: 
  ;; + "C-/" undo
  ;; + "C-?" redo
  ;; + "C-x u" visualize (use arrows to navigate tree)
  )


;; 10 Aug 2017 - suggest functions when writing elisp
(use-package suggest
  :ensure t)
