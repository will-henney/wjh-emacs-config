;;; wjh-emacs-wiki-config.el --- Personal setup for emacs-wiki and associated modes

;;; Commentary:
;; 
;; 

;;; History:
;; 
;;      19 Apr 2006 - added planner-cyclic (config in ~/.diary.cyclic-tasks)
;;      10 May 2005 - add variables for splitting my wiki up into sub-wikis
;;      2 May 2005 - copied over customization from XEmacs

;;; Code:

;; Load all the packages

;; emacs-wiki
(wjh-add-to-load-path "emacs-wiki")
(require 'emacs-wiki)
(require 'emacs-wiki-menu)
;; planner
(wjh-add-to-load-path "planner")
(require 'planner-auto)
(require 'planner-id)
(require 'planner-cyclic)
(setq planner-cyclic-diary-nag nil)

;; remember
(wjh-add-to-load-path "remember")
(require 'remember)
(require 'remember-planner)
(setq remember-handler-functions '(remember-planner-append))
(setq remember-annotation-functions planner-annotation-functions)


;; Original customization (copied from xemacs files 02 May 2005)
(setq
 emacs-wiki-directories (quote ("~/Wiki"))
 emacs-wiki-maintainer "mailto:w.henney@astrosmo.unam.mx"
 emacs-wiki-publishing-header "<?xml version=\"1.0\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"xhtml11.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\">
  <head>
    <title><lisp>(emacs-wiki-page-title)</lisp></title>
    <meta name=\"generator\" content=\"emacs-wiki.el\" />
    <meta http-equiv=\"<lisp>emacs-wiki-meta-http-equiv</lisp>\"
          content=\"<lisp>emacs-wiki-meta-content</lisp>\" />
    <link rev=\"made\" href=\"<lisp>emacs-wiki-maintainer</lisp>\" />
    <link rel=\"home\" href=\"<lisp>(emacs-wiki-published-name
                                     emacs-wiki-home-page)</lisp>\" />
    <link rel=\"index\" href=\"<lisp>(emacs-wiki-published-name
                                      emacs-wiki-index-page)</lisp>\" />
    <lisp>emacs-wiki-style-sheet</lisp>
  </head>
  <body>

    <h1 id=\"top\"><lisp>(emacs-wiki-page-title)</lisp></h1>

    <lisp>(funcall emacs-wiki-menu-factory)</lisp>

    <!-- Page published by Emacs Wiki begins here -->
"
 emacs-wiki-menu-default "<div class=\"menu\">
       <div class=\"menuitem\"><a href=\"../Intro/WelcomePage.html\">Home</a></div>
       <div class=\"menuitem\"><a href=\"../Science/WelcomePage.html\">Science</a></div>
       <div class=\"menuitem\"><a href=\"../Compu/WelcomePage.html\">Compu</a></div>
       <div class=\"menuitem\"><a href=\"../Personal/WelcomePage.html\">Personal</a></div>
       <div class=\"menuitem\"><a href=\"../Plans/WikiIndex.html\">Plan</a></div>
       <div class=\"menuitem\"><a href=\"../Blog/WelcomePage.html\">Blog</a></div>
    </div>
"
 emacs-wiki-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"wjh-wiki.css\" />"
 emacs-wiki-menu-factory (quote emacs-wiki-menu-fixed)
 ;; emacs-wiki-verbatim-face ((t (:foreground "gray30"))) ;;emacs only?
 )


;; 
;; Splitting my wiki up into projects 09 May 2005
;; 

;; helper function based on idea from Michael Allan Dorkman
;; http://www.emacswiki.org/cgi-bin/wiki/EmacsWikiMode
(defun subwiki (project)
  "Set up default values for variables of the PROJECT sub-wiki."
  (list project
	(list 'emacs-wiki-directories (concat "~/Wiki/" project))
	(cons 'emacs-wiki-home-page "WikiIndex.html")
	(cons 'emacs-wiki-publishing-directory (concat "~/WebWiki/" project))
	(cons 'emacs-wiki-project-server-prefix (concat "../" project "/"))))
;; I use add-to-list just for a laugh
(defun add-subwiki (project)
  "Add PROJECT to `emacs-wiki-projects' with default values for variables."
  (add-to-list 'emacs-wiki-projects (subwiki project)))
(add-subwiki "Intro")
(add-subwiki "Science")
(add-subwiki "Compu")
(add-subwiki "Personal")

;; Planner has its own mechanism for changing things
(setq planner-publishing-directory "~/WebWiki/Plans")
(planner-update-wiki-project)




;; Other contributed packages 
(wjh-add-to-load-path "emacs-wiki-contrib")
; Inline LaTex
(load-library "latex2png")
(push '("latex" t t t gs-latex-tag) emacs-wiki-markup-tags) 
(setq gs-latex2png-scale-factor 1.5)
; my own improved version of plog.el
(load-library "wjh-ew-image")
(push '("thumb" t t t gs-emacs-wiki-thumbnail-tag) emacs-wiki-markup-tags) 

;; journal 
(require 'journal)




(provide 'wjh-emacs-wiki-config)

;;; wjh-emacs-wiki-config.el ends here
