;;; Basic setup for python-mode.el instead of python.el
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(require 'python-mode)
;; (autoload 'python-mode "python-mode" "Python editing mode." t)


;; IPython setup - copied from http://richardriley.net/projects/emacs/dotprogramming
(require 'ipython)
(setq py-python-command "ipython")
(setq py-python-command-args '( "-colors" "LightBG"))
;; this coped from http://www.emacswiki.org/emacs/PythonMode
(setq ipython-completion-command-string "print(';'.join(__IP.Completer.all_completions('%s')))\n")

;; Not sure why this is necessary, but it is. Otherwise we keep getting *Python*
;; buffer filling the whole window. I still don't know what is adding "*Python*" to
;; same-window-buffer-names. It doesn't happen if I start Aquamacs without customisations
(setq same-window-buffer-names (delete "*Python*" same-window-buffer-names))


;; 30 May 2011 PyMacs
(wjh-add-to-load-path "Pymacs")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; 30 May 2011 Ropemacs
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport 't)
(setq ropemacs-autoimport-modules '("os" "shutil" "pyx" "numpy" "argparse" "scipy"))
