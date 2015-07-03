;; Make sure we use the new version
;; (load-file "/Users/will/.emacs.d/lisp4elpy/elpy/elpy.el")
;; (setq elpy-rpc-pythonpath "/Users/will/.emacs.d/lisp4elpy/elpy/")

(elpy-enable)
(setq python-check-command "pyflakes")
;; IPython used to cause problems in earlier versions of elpy
;; I should check if it works again in 1.5
(elpy-use-ipython)

;; 08 Aug 2014 WJH Choose a backend
;; Jedi works fine but is not so good at documentation lookup
;;(setq elpy-rpc-backend "jedi")
;; Rope is supposedly better in that regard - so let's try it
;; 08 Aug 2014 WJH - problems with hanging in large dirs
(setq elpy-rpc-backend "rope")

;; WJH 08 Nov 2013 - we prefer to use these for smartscan
(define-key elpy-mode-map (kbd "M-n") nil)
(define-key elpy-mode-map (kbd "M-p") nil)
;; Use the fn key instead
(define-key elpy-mode-map (kbd "H-n") 'elpy-nav-forward-definition)
(define-key elpy-mode-map (kbd "H-p") 'elpy-nav-backward-definition)

;; WJH 11 Dec 2014 - fix conflict with smartparens
(define-key elpy-mode-map (kbd "C-<right>") nil)
(define-key elpy-mode-map (kbd "C-<left>") nil)
(define-key elpy-mode-map (kbd "H-<right>") 'elpy-nav-forward-block)
(define-key elpy-mode-map (kbd "H-<left>") 'elpy-nav-backward-block)

;; Will's fancy new auto-switcher for virtual environments
(defvar wjh/elpy-virtual-environment nil 
  "The python virtual environment to use for the current buffer.

Should be set as a file- or directory-local variable 
using \\[add-file-local-variable] or \\[add-dir-local-variable].")
(make-variable-buffer-local 'wjh/elpy-virtual-environment)

(defun wjh/elpy:pre-command-hook ()
  "Ensure we are in the correct virtual environment for this buffer. 

This checks the value of `wjh/elpy-virtual-environment' against the 
result of (getenv \"VIRTUAL_ENV\") and if they are not the 
same calls `pyvenv-activate' or `pyvenv-deactivate' as appropriate.
It is designed to be added to `pre-command-hook'."
  (let ((current-venv (getenv "VIRTUAL_ENV"))
        (desired-venv (when wjh/elpy-virtual-environment
                        (expand-file-name wjh/elpy-virtual-environment))))
    (unless (equal 'current-venv 'desired-venv)
      (if desired-venv 
          (pyvenv-activate desired-venv)
        (pyvenv-deactivate)))))

;; No longer necessary 30 Oct 2014
;; (add-hook 'python-mode-hook
;;           '(lambda ()
;;              ;; fourth arg to add-hook means buffer-local only
;;              (add-hook 'pre-command-hook 'wjh/elpy:pre-command-hook nil t)))
