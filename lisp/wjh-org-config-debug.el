(defun wjh-add-to-load-path (pkg)
  "Add pkg directory to load path."
  (add-to-list 'load-path (concat wjh-local-lisp-dir "/" pkg)))

(defvar wjh-local-lisp-dir (expand-file-name "~/.emacs.d/lisp")
  "*Where I keep all my elisp files.")
(add-to-list 'load-path wjh-local-lisp-dir)


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
    (list 'org-code 'org-block 'org-table 'org-block-background)))



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


;; make sure it gets loaded on .org files
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; global binding for saving a link to the current file
(define-key global-map "\C-cl" 'org-store-link)
;; global binding for agenda
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cC" 'org-capture)


;; Toggling various features
(global-set-key "\C-ctp" 'org-toggle-pretty-entities)
(global-set-key "\C-cti" 'org-toggle-inline-images)

;; 27 Feb 2015: Improve table export and give it a key binding
(defun wjh-org-table-export ()
  "Avoid loading tsv-mode since it causes problems"
  (interactive)
  (let (auto-mode-alist) (org-table-export))
  )
(global-set-key "\C-cte" 'wjh-org-table-export)

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
(require 'org)

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

;;iimage
(require 'iimage)
(setq iimage-mode-image-search-path (expand-file-name "~/"))
;;Match org file: links
(add-to-list 'iimage-mode-image-regex-alist
            (cons (concat "\\[\\[file:\\(~?" iimage-mode-image-filename-regex
                          "\\)\\]")  1))



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
\\pagestyle{empty}             % do not remove
\[PACKAGES]
\[DEFAULT-PACKAGES]
% The settings below are copied from fullpage.sty
\\usepackage{geometry}
\\geometry{letterpaper,margin=1in}
")


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

(require 'org-inlinetask)


(require 'ob-R)         ;; requires R and ess-mode
(require 'ob-ruby)      ;; requires ruby, irb, ruby-mode, and inf-ruby
(require 'ob-python)    ;; requires python, and python-mode
(require 'ob-gnuplot)   ;; requires gnuplot, and gnuplot-mode
(require 'ob-latex)
(require 'ob-sh)
(require 'ob-calc) 

;; 28 Jul 2014 - Finally get round to turning off confirmation
;;        
;; NOTE: THIS IS A POTENTIAL SECURITY RISK - NEVER EXECUTE CODE BLOCKS
;;       IN UNTRUSTED FILES!
(setq org-confirm-babel-evaluate nil)

;; 15 Nov 2009 - new speed commands in 6.33
(setq org-use-speed-commands t)

(setq org-indent-mode-turns-on-hiding-stars nil)
(setq org-indent-indentation-per-level 1)

(add-hook 'org-mode-hook (lambda ()
  (define-key org-mode-map (kbd "C-c gl") 'omlg-grab-link)
  (define-key org-mode-map [(control meta return)] 'org-insert-heading-respect-content)
  ))

