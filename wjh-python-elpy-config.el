;; Make sure we use the new version
(load-file "/Users/will/.emacs.d/lisp4elpy/elpy/elpy.el")
(setq elpy-rpc-pythonpath "/Users/will/.emacs.d/lisp4elpy/elpy/")

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

;; I decided I didn't like this
(highlight-indentation-mode 0)
