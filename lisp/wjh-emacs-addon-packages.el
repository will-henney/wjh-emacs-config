;; Third party add-on packages that are not shipped with Emacs

;; 19 Dec 2013 - Hopefully, cask will simplify everything
(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)


(defun wjh-add-to-load-path (pkg)
  "Add pkg directory to load path."
  (add-to-list 'load-path (concat wjh-local-lisp-dir "/" pkg)))




;; 03 Dec 2014 - spelling and grammar
;; Inspired by https://joelkuiper.eu/spellcheck_emacs

;; Use hunspell if available 
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))

;; Use langtool 
(require 'langtool)
(setq langtool-language-tool-jar 
      "/usr/local/Cellar/languagetool/2.7/libexec/languagetool-commandline.jar"
      langtool-mother-tongue "en"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"))

(global-set-key [s-down-mouse-1] 'flyspell-correct-word)



;; 27 Aug 2014 - popup git commit messages
(require 'git-messenger)
(global-set-key (kbd "C-x v p") 'git-messenger:popup-message)


;; 02 Aug 2014 - A better way of indicating indentation?
;; 02 Aug 2014 - NOPE: I didn't like it
;; (require 'indent-guide)
;; (indent-guide-global-mode)
;; (set-face-background 'indent-guide-face "dimgray")
;; (setq indent-guide-char ":")

;; 31 Jul 2014 - Delete all whitespace
;; 05 Dec 2014 - No, I didn't like this much, at least not to be
;; turned on all the time.  It hijacks the delete key and many times I
;; deleted more than I wanted and had to undo.
(require 'hungry-delete)
;; (global-hungry-delete-mode)
;; 05 Dec 2014 - Just put it on control delete in case we want it ever
(global-set-key (kbd "C-DEL") 'hungry-delete-backward)

;; 14 Jul 2014 - Use colored identifiers
;; (load "wjh-rainbow-config")

;; 13 Jul 2014 - Use helm
(load "wjh-helm-config")

;; 14 Jul 2014 - change default file for calc settings 
(setq calc-settings-file "/Users/will/.emacs.d/calc-settings.el")

;; 14 Apr 2014 - Use ibuffer and ibuffer-vc
(require 'ibuffer)

;; Override the standard list-buffers command
(defalias 'list-buffers 'ibuffer)

(add-hook 'ibuffer-hook
	  (lambda ()
	    ;; Make mouse clicks work as in dired, etc
	    (define-key ibuffer-name-map [(mouse-1)] 'ibuffer-visit-buffer)
	    ;;	    (local-set-key [mouse-1] 'ibuffer-visit-buffer)
	    ;; (local-set-key [double-mouse-1] 'ibuffer-visit-buffer)
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
	      filename-and-process)))



;; 27 Feb 2014 - Try out smex
;; https://github.com/nonsequitur/smex/blob/master/README.markdown
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; 24 Feb 2014 - Use stripe-buffer in tables
(add-hook 'dired-mode-hook 'turn-on-stripe-buffer-mode)
(add-hook 'tsv-mode-hook 'turn-on-stripe-buffer-mode)
(add-hook 'org-mode-hook 'turn-on-stripe-table-mode)


;; 19 Dec 2013 - use prodigy to manage iPython Notebook sessions
(require 'prodigy)
(prodigy-define-tag
  :name 'ipynb
  :command "ipython"
  :args '("notebook" "--pylab=inline")
  :stop-signal 'sigkill)
(prodigy-define-tag
  :name 'ipynb27
  :command "/Users/will/anaconda/envs/py27/bin/ipython"
  :args '("notebook" "--pylab=inline")
  :stop-signal 'sigkill)
(prodigy-define-service
  :name "Jorge Bowshocks"
  :cwd "/Users/will/Work/Bowshocks/Jorge/bowshock-shape"
  :tags '(ipynb))
(prodigy-define-service
  :name "Orion Statistics"
  :cwd "/Users/will/Dropbox/OrionStats/SacOrion"
  :tags '(ipynb))
(prodigy-define-service
  :name "Orion Dust"
  :cwd "/Users/will/Dropbox/OrionDust"
  :tags '(ipynb))
(prodigy-define-service
  :name "Orion T-squared"
  :cwd "/Users/will/Work/RubinWFC3/Tsquared"
  :tags '(ipynb))
(prodigy-define-service
  :name "Py2.7: Orion T-squared"
  :cwd "/Users/will/Work/RubinWFC3/Tsquared"
  :tags '(ipynb27))
(prodigy-define-service
  :name "Ring Nebula"
  :cwd "/Users/will/Work/RingNebula/WFC3/2013-Geometry"
  :tags '(ipynb))
(prodigy-define-service
  :name "LL Ori Bowshocks"
  :cwd "/Users/will/Dropbox/LuisBowshocks"
  :tags '(ipynb))




;; 25 Nov 2013 - stuff inspired by Magnar Sveen's config
;; https://github.com/magnars/.emacs.d/blob/master/init.el

;; ido vertical mode - much easier to take in the options at a glance
(require 'ido-vertical-mode)
(ido-vertical-mode)

;; expand-region - this is great!
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; 28 Jan 2015 - Similar to expand-region, but possibly even better.
;; Let's try out easy-kill!
;; Replace M-w - should work as command and as prefix
(global-set-key [remap kill-ring-save] 'easy-kill)
;; Replace C-M-@ (need a better keybinding!  Note that C-M-SPACE is
;; taken by Alfred on my Macbook
(global-set-key [remap mark-sexp] 'easy-mark)
;; Now the mappings for easy-mark-extras
(global-set-key [remap mark-word] 'easy-mark-word)
(global-set-key [remap zap-to-char] 'easy-mark-to-char)
(global-set-key [remap zap-up-to-char] 'easy-mark-up-to-char)
(define-key easy-kill-base-map (kbd "C-d") 'easy-kill-delete-region)
(define-key easy-kill-base-map (kbd "DEL") 'easy-kill-delete-region)
;; Note that customizations to easy-kill-alist are in custom file


;; 04 Nov 2013 - persistent scratch buffer
(require 'persistent-scratch)


;; 04 Nov 2013 - try out guide key
(wjh-add-to-load-path "guide-key") ;; try and get my version
(require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
(guide-key-mode 1)  ; Enable guide-key-mode
(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/idle-delay 2.0)
;; (add-hook 'guide-key/popup-buffer-hook 
;; 	  (lambda () 
;; 	    (setq mode-line-format nil)
;; 	    ;; (text-scale-set -2)
;; 	    ))
(defun guide-key/my-hook-function-for-org-mode ()
  (guide-key/add-local-guide-key-sequence "C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-x")
  (guide-key/add-local-highlight-command-regexp "org-"))
(add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)


;; 04 Nov 2013 - try out google-this
(require 'google-this)
(google-this-mode 1)
(global-set-key (kbd "C-x g") 'google-this-mode-submap)
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
(global-set-key [?\C-x ?t] 'anchored-transpose)
(autoload 'anchored-transpose "anchored-transpose" nil t)
;; Test of anchored transpose: 
;;
;; FROM: I want this phrase but not that word.
;; TO: I want that word but not this phrase.
;;
;; 1. Select "this phrase but not that word"
;; 2. Type "C-x t"
;; 3. Select "but not" as anchor
;; 4. Type "C-x t" again


;; 03 Nov 2013 - try out smartparens
;;(require 'smartparens-config)
;; 10 Nov 2014 - force the github version which I have patched for 24.4
(require 'smartparens-config (concat wjh-local-lisp-dir
				     "/smartparens/smartparens-config.el"))
(load "wjh-smartparens-config")

;; 03 Nov 2013 - try out smartscan
;; (why does everything have to be smart these days?!)
;; This is sort of like occur or isearch, but different
;; M-n or M-p just jump to next or prev occurence of the word under point
;; Just like that, no fuss, no fancy UI or highlighting
(global-smartscan-mode 1)

;; 26 Oct 2013 - Try out smart-mode-line
(setq sml/theme 'dark)
;; These are minor modes that we don't want to see cluttering up the modeline
(setq sml/hidden-modes (mapconcat 'identity 
				  '(" hl-p" " Undo-Tree" " MRev" " Projectile.*" " SP"
				   " Google" " Guide" " Helm" " Ind" " GG" " OCDL"
				   " Ref" " Wrap")
				  "\\|"))
(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))
;; Vars moved from cutomize - 10 Dec 2014
(setq
 sml/inactive-background-color "#222233"
 sml/name-width 20
 )


(add-hook 'LaTeX-mode-hook 'TeX-global-PDF-mode)

;; 12 Oct 2013 - try latex-extra
;; 29 Nov 2013 - but I don't like some of the keybindings
(setq latex/override-preview-map t)
(defun wjh-latex/setup-keybinds ()
  "Define our key binds. Modified by wjh from original"
  (interactive)
  (add-hook 'LaTeX-mode-hook 'latex/setup-auto-fill)  
  (define-key LaTeX-mode-map "\C-\M-f" 'latex/forward-environment)
  (define-key LaTeX-mode-map "\C-\M-b" 'latex/backward-environment)
  (define-key LaTeX-mode-map "\C-\M-a" 'latex/beginning-of-environment)
  (define-key LaTeX-mode-map "\C-\M-e" 'latex/end-of-environment)
  (define-key LaTeX-mode-map ""   'latex/beginning-of-line)
  (define-key LaTeX-mode-map "" 'latex/compile-commands-until-done)
  ;; This overrides C-c C-q C-e, etc but I never used those and maybe
  ;; this is better
  (define-key LaTeX-mode-map "" 'latex/clean-fill-indent-environment)
  (define-key LaTeX-mode-map "" 'latex/up-section)
  ;; This overrides TeX-normal-mode, which I rearely use
  (define-key LaTeX-mode-map "" 'latex/next-section)
  ;; This overrides the font changing command ...
  (define-key LaTeX-mode-map "" 'latex/next-section-same-level)
  ;; ... so move TeX-font to "C-c f".  I tried to customize
  ;; Tex-font-list so I could use "C-c f i" instead of "C-c f C-i",
  ;; etc, but that doesn't work.  I can successfully change the global
  ;; value, but the buffer-local value is gettig overridden somewhere
  ;; and reverts to the Control version.
  (define-key LaTeX-mode-map "f" 'TeX-font)
  ;; overrides TeX-command-buffer, which I never use
  (define-key LaTeX-mode-map "" 'latex/previous-section-same-level)
  (when latex/override-preview-map
    (define-key LaTeX-mode-map "" 'latex/previous-section)
    (define-key LaTeX-mode-map "p"  'preview-map))
  (add-hook 'LaTeX-mode-hook 'latex/setup-auto-fill)
  (defadvice LaTeX-preview-setup (after latex/after-LaTeX-preview-setup-advice () activate)
    "Move the preview map to \"p\" so that we free up \"\"."
    (when latex/override-preview-map
      (define-key LaTeX-mode-map "" 'latex/previous-section)
      (define-key LaTeX-mode-map "p"  'preview-map))))
(eval-after-load 'latex '(wjh-latex/setup-keybinds))
(defvar wjh-latex/beamer-section-hierarchy 
  '("\\begin{block}" "\\begin{frame}" "\\subsection" "\\section" "\\maketitle" "\\documentclass")
  )
(defun wjh-latex/set-beamer-section-hierarchy ()
  "This still doesn't work very well"
  (interactive)
  (setq latex/section-hierarchy wjh-latex/beamer-section-hierarchy)
  )


;; 12 Oct 2013 - try projectile
(wjh-add-to-load-path "projectile") ;; try and get my version
(projectile-global-mode)
(setq projectile-enable-caching nil)
(setq projectile-require-project-root nil)
(setq projectile-switch-project-action 'projectile-dired)
;; (defadvice projectile-current-project-dirs (around wjh/add-top-level activate)
;;   "Include top-level dir in `projectile-current-project-dirs'."
;;   (setq ad-return-value (append '("./") ad-do-it)))
;; (setq projectile-switch-project-action 'projectile-find-dir)
;; (setq projectile-switch-project-action 'projectile-recentf)
;; (setq projectile-switch-project-action 'projectile-find-file)
;; (setq projectile-switch-project-action 'projectile-find-file-dwim)
(setq projectile-remember-window-configs t) 
(setq projectile-find-dir-includes-top-level t)
(define-key projectile-mode-map [?\s-d] 'projectile-find-dir)
(define-key projectile-mode-map [?\s-p] 'projectile-switch-project)
(define-key projectile-mode-map [?\s-f] 'projectile-find-file)
(define-key projectile-mode-map [?\s-g] 'projectile-grep)

;; projectile recommends use of flx-ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)


;; 18 Apr 2013 - try fancy bullets
(require 'org-bullets)
;; http://nadeausoftware.com/articles/2007/11/latency_friendly_customized_bullets_using_unicode_characters
;; Reserve list: 
;; "✸" "◰" "►" "★" "⬓" "☀" "☛" "☼" "⚛" "☯" "⬡"
;; "➽" "⚀" "⚁" "⚂" "⚃" "⚄" "⚅"
;; ◐ ◑ ◒ ◓
;; ♣ ♥ ♦ ♠ ♧ ♡ ♢ ♤
(add-hook 'org-mode-hook (lambda () 
			   (setq org-bullets-bullet-list
				 '("⚀" "⚁" "⚂" "⚃" "⚄" "⚅" "♧" "♡" "♢" "♤" "♣" "♥" "♦" "♠"))
			   (org-bullets-mode 1)
			   ))


;; 17 Apr 2013 - markdown mode installed with package manager
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; 18 Apr 2013 - ace-jump-mode installed with package manager
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; Stop org-mode from stomping on that key binding
(add-hook 'org-mode-hook 
	  (function (lambda ()
		      (local-unset-key (kbd "C-c SPC")))))

;; SVG mode line (works on new laptop - 30 Apr 2013 - yeah!)
;; (require 'svg-mode-line-themes)
;; (require 'wjh-svg-mode-line-themes)
;; (smt/enable)
;; (smt/set-theme 'wjh)
;; (set-face-attribute 'mode-line nil :box nil)
;; (set-face-attribute 'mode-line-inactive nil :box nil)


;; 31 Aug 2012: Magit is magic!
(wjh-add-to-load-path "magit")
;; 30 Apr 2013 - note that on iris we use magit from package manager
(require 'magit)
(require 'magit-svn)
(define-key global-map "\C-ci" 'magit-status)

(setq magit-emacsclient-executable 
      (expand-file-name "../../../bin/emacsclient" invocation-directory))


;; 06 Nov 2013 - try this
(add-hook 'git-commit-mode-hook 'git-commit-training-wheels-mode)


;; 30 Apr 2013 - not using powerline any more, since we are using svg-mode-line-themes
;;
;; 09 Sep 2012 make the modeline fancier
;; (wjh-add-to-load-path "emacs-powerline")
;; ;; This is using my own patch to poweline.el to work with bigger fonts
;; (setq powerline-arrow-shape 'arrow20)
;; (require 'powerline)

;; Note that the mode line face settings have been moved to the wjh-misc-appearance theme
;; because they need to be loaded after the zenburn theme
;; Except that still does not work for the firat frame :(
;;

;; (set-face-attribute 'mode-line nil
;;                     :background "azure3"
;; 		    :foreground "black"
;; 		    :height 1.0
;;                     :box nil)
;; (set-face-attribute 'mode-line-inactive nil
;; 		    :height 1.0
;;                     :box nil)



;; 22 Sep 2011 - move python config to the beginning so the GNU python file is never loaded
;; All my setup for python stuff
;; (load "wjh-python-github-config") ; this is the new version 2011 by fgallina
;; (load "wjh-python-config")

;; Trying something new 10 Mar 2013: https://github.com/jorgenschaefer/elpy/wiki
(load "wjh-python-elpy-config")
;; And also try out emacs ipython notebook
(load "wjh-python-ein-config")



;; 22 Sep 2011 - also put org early on
;; Let's use org-mode!
(load "wjh-org-config")
;; (load "wjh-org-config-debug")

;; 06 Jan 2013 - try a new mailer
;; (load "wjh-mu4e-config")


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


;; 11 Sep 2011 anything
;; (wjh-add-to-load-path "anything-config")
;; (require 'anything-config)


;; egg is a fork of magit
;; 31 Aug 2012 - which I never got on with :) so turn it off
;; (wjh-add-to-load-path "egg")
;; (require 'egg)


;; 30 May 2011 auto-complete
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/emacs/lisp//ac-dict")
;; (ac-config-default)


;; workgroups - see https://github.com/tlh/workgroups.el 
;; With Workgroups, you can:
;; - Store an unlimited number of window configs
;; - Save window configs to disk, and load them from disk
;; - Kill and yank window configs

;; 04 Nov 2011: So, it turns out that I didn't like workgroups much :(
;; (wjh-add-to-load-path "workgroups")
;; (require 'workgroups)
;; (workgroups-mode 1)
;; (wg-load (concat wjh-local-lisp-dir "/lisp/workgroups/myworkgroups"))

;; miscellaneous single-file packages

(wjh-add-to-load-path "fold-dwim")
(require 'fold-dwim)
(wjh-add-to-load-path "fold-dwim-org")
(require 'fold-dwim-org)


;; setup for shell-based modes (also IPython)
(require 'comint)
(define-key comint-mode-map [(meta p)]
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(meta n)]
  'comint-next-matching-input-from-input)
;; (define-key comint-mode-map [(control meta n)]
;;    'comint-next-input)
;; (define-key comint-mode-map [(control meta p)]
;;    'comint-previous-input)


;; WJH 
;; (require 'session)
;; (add-hook 'after-init-hook 'session-initialize)

;; (autoload 'igrep "igrep"
;;    "*Run `grep` PROGRAM to match REGEX in FILES..." t)
;; (autoload 'igrep-find "igrep"
;;    "*Run `grep` via `find`..." t)
;; (autoload 'igrep-visited-files "igrep"
;;    "*Run `grep` ... on all visited files." t)
;; (autoload 'dired-do-igrep "igrep"
;;    "*Run `grep` on the marked (or next prefix ARG) files." t)
;; (autoload 'dired-do-igrep-find "igrep"
;;    "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)
;; (autoload 'Buffer-menu-igrep "igrep"
;;   "*Run `grep` on the files visited in buffers marked with '>'." t)
;; (autoload 'igrep-insinuate "igrep"
;;   "Define `grep' aliases for the corresponding `igrep' commands." t)



;; 31 Aug 2012 - Yasnippet is something else that I never liked much
;; 29 Nov 2010 - YASnippet
;; (add-to-list 'load-path
;;                   "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet) ;; not yasnippet-bundle
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
;; (setq yas/root-directory "~/.emacs.d/mysnippets")
;; (yas/load-directory yas/root-directory)
;; (setq yas/wrap-around-region 'cua)

;; ;; 29 Nov 2010 - Interaction of org-mode with YASnippet
;; ;; Copied from http://eschulte.github.com/emacs-starter-kit/starter-kit-org.html
;; (defun yas/org-very-safe-expand ()
;;   (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             ;; yasnippet (using the new org-cycle hooks)
;;             (make-variable-buffer-local 'yas/trigger-key)
;;             (setq yas/trigger-key [tab])
;;             (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
;;             (define-key yas/keymap [tab] 'yas/next-field)
;;             ))



;; (wjh-add-to-load-path "textmate.el")
;; (require 'textmate)
;; (textmate-mode)

;; emacs-nav seems a more lightweight version of speedbar 
;; Initial trying-out 02 Feb 2010
;; (wjh-add-to-load-path "emacs-nav")
;; (require 'nav)

;; ;; Big Brother Database
;; (wjh-add-to-load-path "bbdb")
;; (require 'bbdb)
;; (bbdb-initialize)

;; isearch-symbol (added 03 Oct 2006)
;; (require 'isearch-symbol)
;; (global-set-key [f6] 'isearch-current-symbol)
;; (global-set-key [(control f6)] 'isearch-backward-current-symbol)
;; ;; Subsequent hitting of the keys will increment to the next
;; ;; match--duplicating `C-s' and `C-r', respectively.
;; (define-key isearch-mode-map [f6] 'isearch-repeat-forward)
;; (define-key isearch-mode-map [(control f6)] 'isearch-repeat-backward)

;; ee (added 03 Oct 2006)
;; (wjh-add-to-load-path "ee")
;; (require 'ee-autoloads)

;; CEDET
;; Removed 2009-09-17 - too slow and never worked properly
;; (wjh-add-to-load-path "cedet/common")
;; (load "cedet")
;; (global-ede-mode t)
;; (semantic-load-enable-gaudy-code-helpers)
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
;; (semantic-add-system-include "/Library/Frameworks/Python.framework/Versions/2.5/lib/python2.5/site-packages/")

;; Talcum (added 30 Sep 2006)
;; Removed 2009-09-17 - never use this
;; (wjh-add-to-load-path "talcum")
;; (autoload 'talcum-mode "talcum")
;; (add-hook 'latex-mode-hook 'talcum-mode)

;; W3M
;; (wjh-add-to-load-path "emacs-w3m")
;; (require 'w3m-load)

;; NXML mode
;; (wjh-add-to-load-path "nxml")
;; (load "rng-auto")

;; Bibtex stuff
;; (wjh-add-to-load-path "Beebe")


;; Synonyms
(setq synonyms-file (concat wjh-local-lisp-dir "/etc/synonyms/mthesaur.txt"))
(setq synonyms-cache-file (concat wjh-local-lisp-dir "/etc/synonyms/mthesaur.txt.cache"))
(require 'synonyms)


;; constants
(autoload 'constants-insert "constants" "Insert constants into source." t)
(autoload 'constants-get "constants" "Get the value of a constant." t)
(autoload 'constants-replace "constants" "Replace name of a constant." t)
(define-key global-map "\C-cci" 'constants-insert)
(define-key global-map "\C-ccg" 'constants-get)
(define-key global-map "\C-ccr" 'constants-replace)
(setq constants-unit-system 'cgs)   ;  this is the default

;; Use "cc" as the standard variable name for speed of light,
;; "bk" for Boltzmann's constant, and "hp" for Planck's constant
(setq constants-rename '(("cc" . "c") ("bk" . "k") ("hp" . "h")))

;; A default list of constants to insert when none are specified
(setq constants-default-list "cc,bk,hp")


;; Anything
;; (require 'anything-config)
;; (global-set-key "\C-cb" 'anything)


;; RefTeX needs extra help to find files that are not in the current
;; directory (added 07 Jul 2008)
(setq reftex-use-external-file-finders t)
(setq reftex-external-file-finders
      '(("tex" . "kpsewhich -format=.tex %f")
	("bib" . "kpsewhich -format=.bib %f")))


;; Enhanced selection facilities (added 22 Aug 2008)
;;
;; Use some of Drew Adams' stuff
;; (eval-after-load "thingatpt" '(require 'thingatpt+))
;; (require 'thing-cmds)
;; (global-set-key [(control meta ? )] 'mark-thing) ; vs `mark-sexp'
;; (require 'mark-woo)
;; ;; (global-set-key [(meta ?@)] 'cycle-thing-region) ; vs `mark-word'
;; (global-set-key [(meta ?@)] 'mark-a-word-or-thing) ; vs `mark-word'


;; TSV mode for Cloudy files and others
;; 05 Mar 2014 - add more features and auto-detect .tab and .tsv files
(autoload 'tsv-mode "tsv-mode" "A mode to edit table like file" t)
(autoload 'tsv-normal-mode "tsv-mode" "A minor mode to edit table like file" t)
(add-hook 'tsv-mode-hook
	  (lambda ()
	    ;; Use the first line to define the column names
	    (tsv-first-line-as-header)
	    ;; Set a reasonable default for the columns
	    (tsv-set-all-column-width 8)
	    ))
(add-to-list 'auto-mode-alist '("\\.tsv\\'" . tsv-mode))
(add-to-list 'auto-mode-alist '("\\.tab\\'" . tsv-mode))

;;

;; these lines enable the use of gnuplot mode
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
(setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.gnuplot$" . gnuplot-mode)) auto-mode-alist))


;; Following mention in this blog post
;; http://emacs-fu.blogspot.com/2010/04/navigating-kill-ring.html
(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings)
  (setq browse-kill-ring-quit-action 'save-and-restore))


(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))


;; 29 Nov 2010 dired-x
(require 'dired-x)
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil)
	    (setq dired-omit-verbose nil)
	    ))
;; 28 Jul 2014 - I don't like the "... omitting ..." messages.  They get in the way.
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    (dired-omit-mode 1)
	    (auto-revert-mode)
	    ))

;; 08 Dec 2014 - Installed GNU coreutils from Homebrew - try using ls from that
(when (executable-find "gls")
  (setq insert-directory-program "gls"))

(setq dired-guess-shell-alist-user      ;quess shell command by file ext
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
(global-set-key (kbd "M-6") 'wjh/dired-jump)



;; WJH 01 Feb 2012 - try out predictive
;; see http://www.dr-qubit.org/predictive/
;; predictive install location
(add-to-list 'load-path "~/.emacs.d/predictive/")
;; dictionary locations
(add-to-list 'load-path "~/.emacs.d/predictive/f90/")
(add-to-list 'load-path "~/.emacs.d/predictive/english/")
(add-to-list 'load-path "~/.emacs.d/predictive/c/")
(add-to-list 'load-path "~/.emacs.d/predictive/elisp/")
(add-to-list 'load-path "~/.emacs.d/predictive/latex/")
(add-to-list 'load-path "~/.emacs.d/predictive/texinfo/")
(add-to-list 'load-path "~/.emacs.d/predictive/html/")
;; load predictive package
(autoload 'predictive-mode "~/.emacs.d/predictive/predictive"
  "Turn on Predictive Completion Mode." t)

(setq ido-enable-flex-matching t)
(ido-mode)
(setq ido-file-extensions-order 
      '(".org" ".tex" ".py" ".f90" ".xml" ".el"))


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
(setq eshell-highlight-prompt nil)

;; Other eshell customization, based on the "Mastering Eshell" tutorial 
(require 'em-smart)
(require 'em-rebind)


;; 23 Apr 2013 - Try out shell switcher
;; See https://github.com/DamienCassou/shell-switcher
;; 6 Jan 2015 - MELPA version is broken, so use mine
(wjh-add-to-load-path "shell-switcher")
(require 'shell-switcher)
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


;; 24 Apr 2013 - Try out keyfreq package, which compiles statistics on
;; use of keys.  To see them, use "M-x keyfreq-show".  See
;; https://github.com/dacap/keyfreq and Xah Lee's page at
;; http://ergoemacs.org/emacs/command-frequency.html, which has a
;; python script for analysing the results
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)


;; 24 Apr 2013 - Try out git-gutter - See
;; https://github.com/syohex/emacs-git-gutter This adds marks to the
;; gutter indicating diff status of source lines with respect to the
;; last commit
(require 'git-gutter)
;; If you enable global minor mode
(global-git-gutter-mode t)
;; If you enable git-gutter-mode for some modes
;; (add-hook 'ruby-mode-hook 'git-gutter-mode)
;; WJH 24 Apr 2013 - I am changing all the key bindings to use "C-c g" prefix
(global-set-key (kbd "C-c gg") 'git-gutter:toggle)
(global-set-key (kbd "C-c g=") 'git-gutter:popup-hunk)
;; Jump to next/previous hunk
(global-set-key (kbd "C-c gp") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-c gn") 'git-gutter:next-hunk)
;; Revert current hunk
(global-set-key (kbd "C-c gr") 'git-gutter:revert-hunk)
;; Further git-gutter config
(setq git-gutter:lighter " GG")		; reduce modeline clutter
;; WJH 24 Apr 2013 - more peaceful, subdued colors
(set-face-foreground 'git-gutter:modified "orange3")
(set-face-foreground 'git-gutter:added "DarkSeaGreen")
(set-face-foreground 'git-gutter:deleted "orange3")
(set-face-inverse-video-p 'git-gutter:modified nil)
(set-face-inverse-video-p 'git-gutter:added nil)
(set-face-inverse-video-p 'git-gutter:deleted nil)
(setq git-gutter:window-width nil)
;; WJH 24 Apr 2013 - dots are perfectly fine
(setq git-gutter:modified-sign ".")
(setq git-gutter:added-sign ".")
(setq git-gutter:deleted-sign "-")


;; 09 May 2013 - Try Nic Ferrier's pinboard.el
;;
;; Installed via package-manager.  Note that it has dependencies on
;; other packages: web, creole-mode, kv, which have to be installed
;; too (this is not automatic - why not?).  Also, it seems to be
;; missing an explicit load or require of kv.
(require 'kv)				
(require 'pinboard)
;; To use, first "M-x customize-group pinboard" to set user url. 
;; Then "M-x pinboard-latest" to get (default 10) latest posts. 


;; 09 May 2013 - Try out undo-tree - a better version of undo
;;
;; Installed via package-manager. 
(require 'undo-tree)
(global-undo-tree-mode)
;; Basic Usage: 
;; + "C-/" undo
;; + "C-?" redo
;; + "C-x u" visualize (use arrows to navigate tree)



;; 09 May 2013 - dired-details
;; Toggle with "(" and ")"
(require 'dired-details)
(dired-details-install)
