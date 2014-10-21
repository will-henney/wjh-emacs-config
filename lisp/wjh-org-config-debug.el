
;; 03 Nov 2006

;; org-mode comes included with recent emacsen 
;; - but let's just use a new version
;; (wjh-add-to-load-path "org")
;; 02 Jan 2009 - now tracking development git repo, which installs here
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")


;; These need to get set before org is loaded
;; Add support for @ to give beamer alert font
(setq org-emphasis-alist (quote (("*" bold "<b>" "</b>")
                                ("/" italic "<i>" "</i>")
                                ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
                                ("=" org-code "<code>" "</code>" verbatim)
                                ("~" org-verbatim "<code>" "</code>" verbatim)
                                ("+" (:strike-through t) "<del>" "</del>")
                                ("@" org-warning "<b>" "</b>")))
     org-export-latex-emphasis-alist (quote
                                      (("*" "\\textbf{%s}" nil)
                                       ("/" "\\emph{%s}" nil)
                                       ("_" "\\underline{%s}" nil)
                                       ("+" "\\st{%s}" nil)
                                       ("=" "\\verb" nil)
                                       ("~" "\\verb" t)
                                       ("@" "\\alert{%s}" nil)))
     )


;; make sure it gets loaded on .org files
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; global binding for saving a link to the current file
(define-key global-map "\C-cl" 'org-store-link)
;; global binding for agenda
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; where to keep all the files
(setq org-directory "~/Org/")

;; Make sure that links to image files are opened by "open" not by emacs
;; This can be overridden with C-u
(setq org-file-apps 
      '((auto-mode . emacs)
	("\\.x?html?\\'" . default)
	("pdf" . default)
	("png" . default)
	("jpg" . default)))

		 

;; this now seems to be needed 03 Sep 2007
(require 'org-install)

;; 29 Nov 2010 - turn on fontification of source blocks
(setq org-src-fontify-natively t)
;; 29 Nov 2010 - this should speed things up
(setq font-lock-verbose nil)

;;iimage
(require 'iimage)
(setq iimage-mode-image-search-path (expand-file-name "~/"))
;;Match org file: links
(add-to-list 'iimage-mode-image-regex-alist
            (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                          "\\)\\]")  1))

;; ONE

;; setup for integration between remember and org-mode
(org-remember-insinuate)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cx" 'org-remember)
(setq org-remember-templates
      '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/TODO.org" "Tasks")
        ("Journal" ?j "* %U %?\n\n  %i\n  %a" "~/org/JOURNAL.org")
        ("Idea" ?i "* %^{Title}\n  %i\n  %a" "~/org/JOURNAL.org" "New Ideas")
	("AppleScript remember" ?y "* %:shortdesc\n%:initial\nSource: %u, %c\n\n%?" (concat org-directory "inbox.org") "Remember")
	("AppleScript note" ?z "* %?\n\nDate: %u\n" (concat org-directory "inbox.org") "Notes")
	))

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
(require 'org-inlinetask)

;; export latex equations
(setq org-export-with-LaTeX-fragments t)
;; minor mode for editing LaTeX
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

;; TWO

;; (setq org-export-latex-packages-alist '(( "" "arev" t )))
(setq org-format-latex-header-extra nil)
(setq org-format-latex-header "\\documentclass{article}
\\usepackage[usenames]{color}
\\usepackage{amsmath}
%% This clashes with arev
%% \\usepackage[mathscr]{eucal}
\\pagestyle{empty}             % do not remove
\[PACKAGES]
\[DEFAULT-PACKAGES]
% The settings below are copied from fullpage.sty
\\usepackage{geometry}
\\geometry{letterpaper,margin=1in}
")


;;; Support for magit links in org buffers
;;; https://github.com/sigma/org-magit
(wjh-add-to-load-path "org-magit")
(require 'org-magit)


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


;; THREE

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

;; FOUR

(require 'org-inlinetask)

;; 14 Sep 2009 - try out org-babel (see http://orgmode.org/worg/org-contrib/babel/org-babel.php)
;; (wjh-add-to-load-path "org-mode/contrib/babel/lisp/langs")
;; (require 'org-babel-init) 
;; 9 Aug 2010 - babel now integrated in orgmode - above no longer necessary
;; Some changes needed to config
(require 'ob-R)         ;; requires R and ess-mode
(require 'ob-ruby)      ;; requires ruby, irb, ruby-mode, and inf-ruby
(require 'ob-python)    ;; requires python, and python-mode
(require 'ob-gnuplot)   ;; requires gnuplot, and gnuplot-mode

;; FIVE - I

;; (require 'ob-latex)

;; FIVE - II

(require 'ob-sh)
(require 'ob-calc)
;;(org-babel-load-library-of-babel)

;; FIVE

;; ;; 15 Nov 2009 - new speed commands in 6.33
;; (setq org-use-speed-commands t)

;; ;; 15 Nov 2009 - ubiquitous org entry
;; ;; (require 'org-mac-protocol)

;; ;; 23 Apr 2010 - automatically sync with iPod
;; ;; (run-at-time "00:59" 3600 'org-mobile-push)
;; ;; (run-at-time "00:29" 3600 'org-mobile-pull)


;; ;; copied from http://www.mfasold.net/blog/2009/02/using-emacs-org-mode-to-draft-papers/
;; ;; (defun org-mode-reftex-setup ()
;; ;;   (load-library "reftex")
;; ;;   (and (buffer-file-name)
;; ;;        (file-exists-p (buffer-file-name))
;; ;;        (reftex-parse-all))
;; ;;   ;; the standard key of "C-c ]" clashes with org
;; ;;   (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
;; ;;   )
;; ;; (add-hook 'org-mode-hook 'org-mode-reftex-setup)

;; ;; 11 Jun 2010 Previous turns out not to be necessary - it is integrated in
;; ;; org-mode. Keybinding is `C-c C-x [' to inserta a new citation using reftex
;; (wjh-add-to-load-path "org-mode/contrib/lisp")
;; (require 'org-exp-bibtex)


;; (setq org-indent-mode-turns-on-hiding-stars nil)
;; (setq org-indent-indentation-per-level 1)

;; ;; 29 May 2011 - Integration of Org mode with GitHub Issues
;; (wjh-add-to-load-path "org-ghi")
;; (require 'org-ghi)

;; ;; 29 May 2011 - Presentations in Emacs -- based on Org-mode 
;; ;; https://github.com/eschulte/epresent
;; (wjh-add-to-load-path "epresent")
;; (require 'epresent)
