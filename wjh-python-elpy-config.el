(elpy-enable)
(setq python-check-command "pyflakes")
(elpy-use-ipython)
(elpy-clean-modeline)
;; WJH 08 Nov 2013 - we prefer to use these for smartscan
(define-key elpy-mode-map (kbd "M-n") nil)
(define-key elpy-mode-map (kbd "M-p") nil)
;; Use the fn key instead
(define-key elpy-mode-map (kbd "H-n") 'elpy-nav-forward-definition)
(define-key elpy-mode-map (kbd "H-p") 'elpy-nav-backward-definition)
