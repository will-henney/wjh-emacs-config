;; 03 Nov 2006

;; org-mode comes included with recent emacsen 
;; - but let's just use a new version
;; (wjh-add-to-load-path "org")
;; 02 Jan 2009 - now tracking development git repo, which installs here
;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/org")
;; 01 Apr 2014 - we now use org from Org ELPA repo 


;; Make sure that certain things are fixed pitch in org mode
(defun my-adjoin-to-list-or-symbol (element list-or-symbol)
  (let ((list (if (not (listp list-or-symbol))
                  (list list-or-symbol)
                list-or-symbol)))
    (require 'cl-lib)
    (cl-adjoin element list)))
(eval-after-load "org"
  '(mapc
    (lambda (face)
      (set-face-attribute
       face nil
       :inherit
       (my-adjoin-to-list-or-symbol
        'fixed-pitch
        (face-attribute face :inherit))))
    (list 'org-code 'org-block 'org-table ;; 'org-block-background
	  )))
;; org-block-backround was removed 2014-07-28 in this commit:
;; http://orgmode.org/cgit.cgi/org-mode.git/commit/?id=f8b42e8eb
;; It only showed up on the ELPA version 2015-08 (or maybe 07, I was on holiday)


;; These need to get set before org is loaded
;; Add support for @ to give beamer alert font
(setq org-emphasis-alist (quote (("*" bold "<b>" "</b>")
                                ("/" italic "<i>" "</i>")
                                ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
                                ("=" org-code "<code>" "</code>" verbatim)
                                ("~" org-verbatim "<code>" "</code>" verbatim)
                                ("@" org-warning "<b>" "</b>")))
     org-export-latex-emphasis-alist (quote
                                      (("*" "\\textbf{%s}" nil)
                                       ("/" "\\emph{%s}" nil)
                                       ("_" "\\underline{%s}" nil)
                                       ("=" "\\verb" nil)
                                       ("~" "\\verb" t)
                                       ("@" "\\alert{%s}" nil)))
     )

;; 18 Nov 2016 - try to allow emphasis in middle of a word
(setq org-emphasis-regexp-components
      '("[:space:][:cntrl:]('\"{}"          ;; Allowed prematch
	"[:space:][:cntrl:]-.,:!?;'\")}\\[" ;; Allowed postmatch
	"[:space:][:cntrl:]"		    ;; Forbidden in border 
	"."				    ;; Allowed body
	1				    ;; Max number of newlines
	))

;; make sure it gets loaded on .org files
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; global binding for saving a link to the current file
(define-key global-map "\C-cl" 'org-store-link)
;; global binding for agenda
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cC" 'org-capture)


;; WJH 04 Oct 2017 - I got fed up of typing C-u C-c C-v C-t C-c C-v
;; C-n C-c C-c all of the time!
(defun wjh/tangle-this-then-execute-next-src-block ()
  "Tangle the current block, then run the next one.
This supports the workflow of saving each python script to a
file, then running it with a shell command in the following
block."
  (interactive)
  ;; Make sure we have exited the dedicated source buffer
  (when org-src-mode (org-edit-src-exit))
  ;; Tangle only the current block - we do this by simulating a single C-u prefix
  (org-babel-tangle '(4))
  ;; Assume the next block is the shell command to run the current block's tangled file
  (org-babel-next-src-block)
  (org-babel-execute-src-block))
(global-set-key (kbd "C-c x") 'wjh/tangle-this-then-execute-next-src-block)




;; Toggling various features
(global-set-key "\C-ctp" 'org-toggle-pretty-entities)
(global-set-key "\C-cti" 'org-toggle-inline-images)


;; 17 Apr 2015: Unlinkify an org link (replace by description)
;; Taken from Andrew Swann's answer on emacs stackexchange
;; http://emacs.stackexchange.com/a/10714/1980
(defun afs/org-replace-link-by-link-description ()
    "Replace an org link by its description or if empty its address"
  (interactive)
  (if (org-in-regexp org-bracket-link-regexp 1)
      (let ((remove (list (match-beginning 0) (match-end 0)))
        (description (if (match-end 3) 
                 (org-match-string-no-properties 3)
                 (org-match-string-no-properties 1))))
    (apply 'delete-region remove)
    (insert description))))
(add-hook 'org-mode-hook
	  (define-key org-mode-map (kbd "C-c DEL")
	    'afs/org-replace-link-by-link-description))

;; 10 Nov 2016: Better M-/ completion for noweb references This
;; modifies the syntax table so that << and >> are treated as
;; delimiters, rather than part of the symbol
(modify-syntax-entry ?< "(>" org-mode-syntax-table)
(modify-syntax-entry ?> ")<" org-mode-syntax-table)

;; (defun org-src-block-names--completion-function (str pred action)
;;   (let ((tbl (org-babel-src-block-names)))
;;     (pcase action
;;       (`nil (try-completion   str tbl pred))
;;       (`t   (all-completions  str tbl pred))
;;       (`metadata
;;        '(metadata (annotation-function . org-src-block-names--get-lang))))))

;; (defun org-src-block-names--get-lang (lang)
;;   (concat " " (car-safe (org-babel-lob--src-info lang))))

;; (defun org-src-block-names-completion-at-point-function ()
;;   (when (and (looking-back "<<\\([-a-z]+\\)")
;;              (eq (org-element-type (org-element-at-point)) 'src-block))
;;     (list
;;      (match-beginning 1)
;;      (point)
;;      'org-src-block-names--completion-function
;;      :exclusive 'no
;;      :annotation-function 'org-src-block-names--get-lang)))


;; (add-to-list 'hippie-expand-try-functions-list 'org-src-block-names--completion-function)


;; 27 Feb 2015: Improve table export and give it a key binding
(defun wjh-org-table-export ()
  "Avoid loading tsv-mode since it causes problems"
  (interactive)
  (let (auto-mode-alist) (org-table-export))
  )
(global-set-key "\C-cte" 'wjh-org-table-export)

;; where to keep all the files
(setq org-directory "~/Dropbox/Org/")

;; Make sure that links to image files are opened by "open" not by emacs
;; This can be overridden with C-u
(setq org-file-apps 
      '((auto-mode . emacs)
	(directory . emacs)
	("\\.x?html?\\'" . default)
	("pdf" . default)
	("png" . default)
	("jpg" . default)))

		 

;; 18 Apr 2013 - note that some of my org config is done via customize
;; See custom-nonaquamacs.el

;; 29 Nov 2010 - turn on fontification of source blocks
(setq org-src-fontify-natively t)
;; 29 Nov 2010 - this should speed things up
(setq font-lock-verbose nil)

;; 15 Aug 2014 we now have separate faces for begin/end source blocks
;; Let's take advantage
;; 
(set-face-attribute 'org-special-keyword nil
		    :weight 'light)
(set-face-attribute 'org-date nil
		    :weight 'light)
(set-face-attribute 'org-meta-line nil
		    :inherit nil :foreground "#b0a0a0" :weight 'light)
(set-face-attribute 'org-block-begin-line nil
		    :inherit 'org-block-background
		    :underline nil :overline nil
		    :foreground "gray60" :weight 'light)
(set-face-attribute 'org-block-end-line nil
		    :inherit 'org-block-background
		    :underline nil :overline nil
		    :foreground "gray60" :weight 'light)

;; 2020-10-23 Revert the changed default in org 9.4
(setq org-fontify-done-headline nil)

;;iimage
(use-package iimage
  :ensure t
  :config
  (setq iimage-mode-image-search-path (expand-file-name "~/"))
  ;;Match org file: links
  (add-to-list 'iimage-mode-image-regex-alist
	       (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
			     "\\)\\]")  1)))


;; (require 'htmlize)

;; ;; setup for integration between remember and org-mode
;; (org-remember-insinuate)
;; (setq org-default-notes-file (concat org-directory "/notes.org"))
;; (define-key global-map "\C-cx" 'org-remember)
;; (setq org-remember-templates
;;       '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/TODO.org" "Tasks")
;;         ("Journal" ?j "* %U %?\n\n  %i\n  %a" "~/org/JOURNAL.org")
;;         ("Idea" ?i "* %^{Title}\n  %i\n  %a" "~/org/JOURNAL.org" "New Ideas")
;; 	("AppleScript remember" ?y "* %:shortdesc\n%:initial\nSource: %u, %c\n\n%?" (concat org-directory "inbox.org") "Remember")
;; 	("AppleScript note" ?z "* %?\n\nDate: %u\n" (concat org-directory "inbox.org") "Notes")
;; 	))

(setq org-agenda-start-on-weekday nil)
(setq org-agenda-include-diary t)
;; integration with calendar/diary

;; Export to iCal - In iCal.app subscribe to http://localhost/orgmode.ics
(setq org-combined-agenda-icalendar-file "/Library/WebServer/Documents/orgmode.ics")
(setq org-icalendar-store-UID t)

;; turn on logging
(setq org-log-done t)
;; prettier formatting 
;; (setq org-hide-leading-stars t)
(setq org-startup-folded 'content)

;; footnotes
(setq org-footnote-auto-label nil)	; always prompt for label

;; inline tasks - make one with C-c C-x t
(use-package org-inlinetask)

;; export latex equations
(setq org-export-with-LaTeX-fragments t)

;; 2020-10-24 - finally get round to disabling cdlatex - I never use
;; it and it just gets in the way
;; ;; minor mode for editing LaTeX
;; (add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; (setq org-export-latex-packages-alist '(( "" "arev" t )))
;; This uses a tt font - we want to change it to Monaco eventually, see TODO.org
(setq org-format-latex-header "\\documentclass{article}
\\usepackage[usenames]{color}
\\usepackage{amsmath}
\\usepackage[T1]{fontenc}
\\usepackage[nomath]{lmodern}
\\renewcommand{\\rmdefault}{lmvtt}
\\usepackage[eulergreek]{mathastext}
\\MathastextEulerScale{0.92}
\\usepackage[mathscr]{eucal}
\\AtBeginDocument{\\boldmath\\large}
\\pagestyle{empty}             % do not remove
\[PACKAGES]
\[DEFAULT-PACKAGES]
% The settings below are copied from fullpage.sty
\\usepackage{geometry}
\\geometry{letterpaper,margin=1in}
")


;;; Support for magit links in org buffers
;;; https://github.com/magit/orgit (updated 30 Jan 2020)
(use-package orgit
  :ensure t)
;; (wjh-add-to-load-path "org-magit")
;; (require 'org-magit)


;; ;; Using RefTeX in org buffers - copied from blog post by Mario Fasold
;; ;; http://www.mfasold.net/blog/2009/02/using-emacs-org-mode-to-draft-papers/
;; (defun org-mode-reftex-setup ()
;;   (load-library "reftex")
;;   (and (buffer-file-name)
;;        (file-exists-p (buffer-file-name))
;;        (reftex-parse-all))
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;;   )
;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)


;; Export to HTML
;; The following is modified from a mailing message from Ken.Williams@thomsonreuters.com
(setq org-export-html-style
"<style type=\"text/css\">
   <!--/*--><![CDATA[/*><!--*/
     .src             { background: #F5FFF5; position: relative; margin-top: 12px; padding-top: 24px; }
     .src:before      { position: absolute; top: 0px; left: 0px; 
                        background: #ffffff; padding: 2px; 
                        border-right: 1px solid black; border-bottom: 1px solid black;
                        font-size: 70%; font-family: sans-serif; font-weight: bold;}
     .src-sh:before   { content: 'sh'; }
     .src-bash:before { content: 'sh'; }
     .src-R:before    { content: 'R'; }
     .src-python:before    { content: 'Python'; }
     .src-perl:before { content: 'Perl'; }
     .src-sql:before  { content: 'SQL'; }
     .src-f90:before  { content: 'Fortran'; }
     .example         { background-color: #FFF5F5; }
   /*]]>*/-->
</style>")


;; Following is copied from a blog post: 
;; http://definitelyaplug.b0.cx/post/custom-inlined-css-in-org-mode-html-export/
;; It inlines the contents of org-style.css into exported HTML
;; Can be over-ridden by style.css in local folder
(defun my-org-inline-css-hook (exporter)
  "Insert custom inline css"
  (when (eq exporter 'html)
    (let* ((dir (ignore-errors (file-name-directory (buffer-file-name))))
           (path (concat dir "style.css"))
           (homestyle (or (null dir) (null (file-exists-p path))))
           (final (if homestyle "~/.emacs.d/org-style.css" path)))
      (setq org-html-head-include-default-style nil)
      (setq org-html-head (concat
                           "<style type=\"text/css\">\n"
                           "<!--/*--><![CDATA[/*><!--*/\n"
                           (with-temp-buffer
                             (insert-file-contents final)
                             (buffer-string))
                           "/*]]>*/-->\n"
                           "</style>\n")))))

(eval-after-load 'ox
  '(progn
     (add-hook 'org-export-before-processing-hook 'my-org-inline-css-hook)))


;; exporting projects to HTML
(setq org-publish-project-alist
      '(("temarios-html"
	 :base-directory "~/Org/temarios"
	 :publishing-directory "/ssh:will@crya:/http/pub/will"
	 :publishing-function org-publish-org-to-html
	 :section-numbers nil
	 :table-of-contents nil
	 :style "<link rel=stylesheet
                     href=\"temarios.css\"
                     type=\"text/css\">"
	 )
	("temarios-css"
	 :base-directory "~/Org/temarios"
	 :publishing-directory "/ssh:will@crya:/http/pub/will"
;; 	 :publishing-directory "~/WebOrg"
	 :base-extension "css"
	 :publishing-function org-publish-attachment
	 )
	("temarios" :components ("temarios-html" "temarios-css"))
	("mhd-html"
	 :base-directory "~/Org/pub-mhd"
	 :publishing-directory "/ssh:will@crya:/http/pub/will/mhd"
	 :publishing-function org-publish-org-to-html
	 :section-numbers nil
	 :table-of-contents nil
	 :style "<link rel=stylesheet
                     href=\"will-org.css\"
                     type=\"text/css\">"
	 )
	("mhd-css"
	 :base-directory "~/Org/pub-mhd"
	 :publishing-directory "/ssh:will@crya:/http/pub/will/mhd"
	 :base-extension "css"
	 :publishing-function org-publish-attachment
	 )
	("mhd-images"
	 :base-directory "~/Org/pub-mhd/images"
	 :publishing-directory "/ssh:will@crya:/http/pub/will/mhd/images"
	 :base-extension "jpg\\|png"
	 :publishing-function org-publish-attachment
	 )
	("mhd-movies"
	 :base-directory "~/Org/pub-mhd/movies"
	 :publishing-directory "/ssh:will@crya:/http/pub/will/mhd/movies"
	 :base-extension "avi\\|mpg"
	 :publishing-function org-publish-attachment
	 )
	("mhd" :components ("mhd-html" "mhd-css" "mhd-movies" "mhd-images"))
	))

(require 'org-inlinetask)

;; 14 Sep 2009 - try out org-babel (see http://orgmode.org/worg/org-contrib/babel/org-babel.php)
;; (wjh-add-to-load-path "org-mode/contrib/babel/lisp/langs")
;; (require 'org-babel-init) 
;; 9 Aug 2010 - babel now integrated in orgmode - above no longer necessary
;; Some changes needed to config
;; (require 'ob-R)
;; requires R and ess-mode
;; active Babel languages
(use-package ob-ipython :ensure t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ruby . t)
   (python . t)
   (gnuplot . t)
   (latex . t)
   (shell . t)
   (calc . t)
;;   (ipython . t)
   (jupyter . t)
   ))

;; 28 Jul 2014 - Finally get round to turning off confirmation
;;        
;; NOTE: THIS IS A POTENTIAL SECURITY RISK - NEVER EXECUTE CODE BLOCKS
;;       IN UNTRUSTED FILES!
(setq org-confirm-babel-evaluate nil)

;; 15 Nov 2009 - new speed commands in 6.33
(setq org-use-speed-commands t)

;; 17 Apr 2019 - replacement for the templates triggered by "<"
;; 30 Jan 2020 - REMOVED (I don't use this any more)
;; (require 'org-tempo)
;; (tempo-define-template "org-src_python"
;; 		       '("#+begin_src python" p  n
;; 			 n "#+end_src" )
;; 		       "<p" "Insert Python Block" 'org-tempo-tags)
;; (tempo-define-template "org-src-named-python"
;; 		       '("#+name: " p  n
;; 			 "#+begin_src python"   n
;; 			 n "#+end_src" )
;; 		       "<P" "Insert Named Python Block" 'org-tempo-tags)

;; 15 Nov 2009 - ubiquitous org entry
;; (require 'org-mac-protocol)

;; 23 Apr 2010 - automatically sync with iPod
;; (run-at-time "00:59" 3600 'org-mobile-push)
;; (run-at-time "00:29" 3600 'org-mobile-pull)


;; copied from http://www.mfasold.net/blog/2009/02/using-emacs-org-mode-to-draft-papers/
;; (defun org-mode-reftex-setup ()
;;   (load-library "reftex")
;;   (and (buffer-file-name)
;;        (file-exists-p (buffer-file-name))
;;        (reftex-parse-all))
;;   ;; the standard key of "C-c ]" clashes with org
;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;;   )
;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)

;; 11 Jun 2010 Previous turns out not to be necessary - it is integrated in
;; org-mode. Keybinding is `C-c C-x [' to inserta a new citation using reftex
;; 18 Feb 2013 - org-exp-bibtex no longer exists it seems
;; (wjh-add-to-load-path "org-mode/contrib/lisp")
;; (require 'org-exp-bibtex)


(setq org-indent-mode-turns-on-hiding-stars nil)
(setq org-indent-indentation-per-level 1)

;; ;; 29 May 2011 - Integration of Org mode with GitHub Issues
;; 30 May 2013  - dead project
;; (wjh-add-to-load-path "org-ghi")
;; (require 'org-ghi)

;; 29 May 2011 - Presentations in Emacs -- based on Org-mode 
;; https://github.com/eschulte/epresent
;; (wjh-add-to-load-path "epresent")
;; (require 'epresent)

;; ;; 20 Feb 2013 - Show how many subheadings
;; ;; https://github.com/pinard/org-weights
;; (wjh-add-to-load-path "org-weights")
;; (autoload 'org-weights-mode "org-weights" nil t)
;; (define-key org-mode-map "\C-cow" 'org-weights-mode)

;; 29 Apr 2013 - try out org-mac-link-grabber
;; (require 'org-mac-link-grabber)
(add-hook 'org-mode-hook
	  (lambda ()
	    ;; (define-key org-mode-map (kbd "C-c gl") 'omlg-grab-link)
	    (define-key org-mode-map
	      [(control meta return)] 'org-insert-heading-respect-content)
	    ;; 17 Apr 2019 Remove this hydra binding, since the
	    ;; functionality has changed and it now is probably
	    ;; unnecessary
	    ;; 
	    ;; (define-key org-mode-map "<"
	    ;;   (lambda () (interactive)
	    ;;     (if (looking-back "^")
	    ;; 	  (hydra-org-template/body)
	    ;; 	(self-insert-command 1))))
	    ))

;; 13 Oct 2013 - no, I didn't like this
;; ;; 12 Aug 2013 - try out Org-Trello integration
;; ;; see http://ardumont.github.io/org-trello/
;; (require 'org-trello)

;; 23 Sep 2016 - try out integration with org bookmarks
;; and turned on org-bookmark-jump-indirect 
(use-package org-bookmark-heading :ensure t)

(defun wjh/up-heading (arg)
  "Like `outline-up-heading` but for heading at top of window"
  (interactive "p")
  (move-to-window-line 0)
  (outline-up-heading arg)
  (recenter 0)
  )
(defun wjh/this-heading (arg)
  "Like `wjh/up-heading` but go to the current heading, not parent"
  (interactive "p")
  (wjh/up-heading 0)
  )
(defun wjh/backward-heading (arg)
  "Like `org-backward-heading-same-level` but for heading at top of window"
  (interactive "p")
  (move-to-window-line 0)
  (org-backward-heading-same-level arg)
  (recenter 0)
  )
(defun wjh/forward-heading (arg)
  "Like `org-forward-heading-same-level` but for heading at top of window"
  (interactive "p")
  (move-to-window-line 0)
  (org-forward-heading-same-level arg)
  (recenter 0)
  )
(defun wjh/next-heading (arg)
  "Like `org-next-visible-heading` but for heading at top of window"
  (interactive "p")
  (move-to-window-line 0)
  (org-next-visible-heading arg)
  (recenter 0)
  )

;; 03 May 2017 - This is to get things to look nice for
;; org-sticky-header-mode.  We use a condensed font so as to be able
;; more of the reversed path on the screen
(set-face-attribute 'header-line nil
		    :background "#2B2B2B"
		    :foreground "#F0DFAF"
		    :box '(:line-width 5 :color "#2B2B2B")
		    :slant 'italic
		    :height 0.95
		    :family "Input Mono Condensed"
		    :underline nil :overline nil
		    )


;; 02 May 2017 - Makes header stick around
(use-package org-sticky-header :ensure t
  :config
  (setq org-sticky-header-full-path 'reversed)
  (setq org-sticky-header-heading-star "⸭")
  (setq org-sticky-header-outline-path-reversed-separator " 🚦 ")
  :init
  (add-hook 'org-mode-hook (lambda () (org-sticky-header-mode 1)))
  :bind
  (([header-line swipe-left] . wjh/backward-heading)
   ([header-line swipe-right] . wjh/forward-heading)
   ([header-line swipe-up] . wjh/up-heading)
   ([header-line swipe-down] . wjh/next-heading)
   ([header-line down-mouse-1] . wjh/this-heading)
   )
  )


;; 09 Jun 2017 - bindings to make source block navigation and editing
;; more frictionless, suggested by Grant Rettke
;; mailplane://whenney%40gmail.com/#label/_lists%2Forg/15c7e59721ea3fa1
;; https://mail.google.com/mail/?authuser=whenney%40gmail.com&pcd=2#label/_lists%2Forg/15c7e59721ea3fa1
(define-key org-mode-map (kbd "s-j") #'org-babel-next-src-block)
(define-key org-mode-map (kbd "s-k") #'org-babel-previous-src-block)
(define-key org-mode-map (kbd "s-l") #'org-edit-src-code)
(define-key org-src-mode-map (kbd "s-l") #'org-edit-src-exit)

;; 16 Jun 2017 - extra space above and below headings
(defun wjh/propertize-newline-of-next-org-heading ()
  (interactive)
  (outline-next-heading)
  (setq start (point))
  (end-of-line)
  (setq end (1+ (point)))
  (put-text-property start end 'line-height '(1.7 2.0))
  )
(bind-key "H-e" 'wjh/propertize-newline-of-next-org-heading)


;; 23 Jun 2017 - try and improve workflow

;; Allow refile to more places (from Sacha Chua
;; http://sachachua.com/blog/2015/02/learn-take-notes-efficiently-org-mode/)
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))


;;  Org capture templates 
(setq org-capture-templates
      '(("l" "A link, for reading later." entry
	 (file+headline "notes.org" "Reading List")
	 "* %:description\n%U\n\n%a\n\n%:initial"
	 :empty-lines 1)
	("t" "Todo" entry (file+headline "notes.org" "Tasks")
	 "* TODO %?\n:LOGBOOK:\n- Created on %U\n:END:\n%i\n%a")
	("j" "Journal" entry (file+datetree "JOURNAL.org")
	 "* %?\nEntered on %U\n%i\n%A")))


;; 26 Jun 2017

;; use ivy to insert a link to a heading in the current document
;; based on `worf-goto`
(defun bjm/worf-insert-internal-link ()
  "Use ivy to insert a link to a heading in the current `org-mode' document. Code is based on `worf-goto'."
  (interactive)
  (let ((cands (worf--goto-candidates)))
    (ivy-read "Heading: " cands
              :action 'bjm/worf-insert-internal-link-action)))


(defun bjm/worf-insert-internal-link-action (x)
  "Insert link for `bjm/worf-insert-internal-link'"
  ;; go to heading
  (save-excursion
    (goto-char (cdr x))
    ;; store link
    (call-interactively 'org-store-link)
    )
  ;; return to original point and insert link
  (org-insert-last-stored-link 1)
  ;; org-insert-last-stored-link adds a newline so delete this
  (delete-backward-char 1)
  )

(use-package worf
  :ensure t
  :config
  
  :bind
  (("s-[" . bjm/worf-insert-internal-link))
  )
