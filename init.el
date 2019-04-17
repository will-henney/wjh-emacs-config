;;; .emacs --- Will Henney's GNU Emacs configuration
;; 

;;; Commentary:
;; 
;;  Will Henney's personal configuration file for Emacs (not XEmacs)
;;  This file just sets up some paths and file names. All the
;;  functionality is bundled into sub-files.

;;; History:
;; 
;;  WJH 04 May 2005 :: ran it through checkdoc (do I really want that
;;                     `provide' at the end?)
;;  WJH 03 May 2005 :: added customize section
;;  WJH 01 May 2005 :: initial version

;;; Code:
(defvar wjh-local-lisp-dir (expand-file-name "~/.emacs.d/lisp")
  "*Where I keep all my elisp files.")
(add-to-list 'load-path wjh-local-lisp-dir)

;; Put customize modifications in a separate file a la xemacs
(cond
 ((boundp 'aquamacs-version)
  ;;; need separate custom files since aquamacs may refer to vars that 
  ;;; do not exist in Emacs.app and vice versa
  (setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
;;   (setq custom-file (concat wjh-local-lisp-dir "/custom-empty.el"))
  )
 (t
  (setq custom-file (expand-file-name "~/.emacs.d/custom-nonaquamacs.el")))
 )
(load custom-file)

(require 'cl)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
;; (add-to-list 'package-archives
;;              '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(setq package-load-list '(all))
(package-initialize)


;; add in personal info directory as soon as possible
(add-to-list 'Info-default-directory-list 
	     (expand-file-name "~/.emacs.d/info/"))

 

(load "wjh-emacs-use-package")
(load "wjh-emacs-clean-gui")
(load "wjh-emacs-functions")
(load "wjh-emacs-misc-setup")

;; This comes last so as to be sure to override key bindings
(load "wjh-emacs-xemacs-emul")
(load "wjh-emacs-mac-specific")

;; These were added automatically at some point
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Load themes by hand instead of relying on custom, since that always messed up the priorities
;; '(custom-enabled-themes (quote (wjh-misc-appearance wjh-latex-faces wjh-org-misc wjh-redbox-cursor zenburn)))

(setq custom-theme-directory (expand-file-name "~/.emacs.d/themes"))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t)
  )
(load-theme 'wjh-latex-faces t)
(load-theme 'wjh-org-faces t)
(load-theme 'wjh-org-misc t)
(load-theme 'wjh-misc-appearance t)
(load-theme 'wjh-redbox-cursor t)


(setq fringes-outside-margins t)
(fringe-mode 4)


;; See discussion in Miscellaneous Appearance section of wjh-emacs-config.org
;; These need to come as late as possible so as they do not get overridden
;; (set-face-attribute 'mode-line nil
;; 		    :background "azure3"
;; 		    :foreground "black"
;; 		    :height 1.0
;; 		    :box nil)
;; (set-face-attribute 'mode-line-inactive nil
;; 		    :height 1.0
;; 		    :box nil)



(provide '.emacs)

;;; .emacs ends here

(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
