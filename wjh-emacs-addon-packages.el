;; Third party add-on packages that are not shipped with Emacs 22 CVS

(defun wjh-add-to-load-path (pkg)
  "Add pkg directory to load path."
  (add-to-list 'load-path (concat wjh-local-lisp-dir "/lisp/" pkg)))

(add-to-list 'load-path (concat wjh-local-lisp-dir "/lisp"))

;; 03 Nov 2013 - try out smartparens
(require 'smartparens-config)
(load "wjh-smartparens-config")

;; 03 Nov 2013 - try out smartscan
;; (why does everything have to be smart these days?!)
;; This is sort of like occur or isearch, but different
;; M-n or M-p just jump to next or prev occurence of the word under point
;; Just like that, no fuss, no fancy UI or highlighting
(global-smartscan-mode 1)

;; 26 Oct 2013 - Try out smart-mode-line
(require 'smart-mode-line)
(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

;; 12 Oct 2013 - try latex-extra
(eval-after-load 'latex '(latex/setup-keybinds))

;; 12 Oct 2013 - try projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action 'projectile-dired)
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
(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs-mac/emacs-24.3-mac-4.3/bin/emacsclient")

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

(set-face-attribute 'mode-line nil
                    :background "azure3"
		    :foreground "black"
		    :height 1.0
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
		    :height 1.0
                    :box nil)


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


;; TSV mode for Cloudy files
(autoload 'tsv-mode "tsv-mode" "A mode to edit table like file" t)
(autoload 'tsv-normal-mode "tsv-mode" "A minor mode to edit table like file" t)


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
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    (dired-omit-mode 1)
	    (auto-revert-mode)
	    ))


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

;; 23 Apr 2013 - Try out shell switcher
;; See https://github.com/DamienCassou/shell-switcher
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
