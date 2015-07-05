;; Let M-DIGIT be useful
;;
;; We already have C-DIGIT for digit-argument, so we don't need
;; M-DIGIT as well.  Instead, we can use the digits to do something
;; more useful, based on their shifted symbol (assuming a US keyboard)

(defun wjh/magit-status ()
  "Save project buffers and call `magit-status'"
  (interactive)
  (projectile-save-project-buffers)
  (magit-status))

(defun wjh/safe-constants-replace ()
  (interactive)
  (with-demoted-errors (constants-replace)))

;; `:~ (Mnemonic: BACKTICK analogy with frame switching)
;; Switch to other window symmetry with 
(global-set-key (kbd "M-`") 'other-window)
;; 1:! (Mnemonic: BANG for magic git!)
;; Magit status on current project
(global-set-key (kbd "M-1") 'wjh/magit-status)
;; 2:@ (Mnemonic: AT project)
;; Switch to another project using projectile
(global-set-key (kbd "M-2") 'projectile-switch-project)
;; 3:# (Mnemonic: HASH sign for numbers)
;; Replace physical constants before point if possible
(global-set-key (kbd "M-3") 'wjh/safe-constants-replace)
;; 4:$ (Mnemonic: DOLLAR sign for shell prompt)
;; Unconditionally open new shell in current dir
(global-set-key (kbd "M-4") 'shell-switcher-new-shell)
;; 5:% (Mnemonic: PERCENT analogy with `C-M-%')
;; Interactive search and replace with regular expressions
(global-set-key (kbd "M-5") 'query-replace-regexp)
;; 6:^ (Mnemonic: CARET by analogy with dired buffer binding)
;; Go to dired buffer of enclosing directory
(global-set-key (kbd "M-6") 'wjh/dired-jump)
;; 7:& (Mnemonic: AMPERSAND starts with same letter)
;; Regexp search through emacs functions, variables, etc
(global-set-key (kbd "M-7") 'apropos)
;; 8:* (Mnemonic: STAR multiplication symbol)
;; Math calculation in minibuffer
(global-set-key (kbd "M-8") 'quick-calc)
;; 9:( (Mnemonic: OPEN PAREN analogy with RefTeX `C-c (')
;; Save current line for use as a link target from an org-mode file
(global-set-key (kbd "M-9") 'org-store-link)
;; 0:) (Mnemonic: CLOSE PAREN looks a bit like an arrowhead)
;; Look for files with spotlight (I have `locate-command' set to mdfind)
(global-set-key (kbd "M-0") 'locate)
;; -:_

