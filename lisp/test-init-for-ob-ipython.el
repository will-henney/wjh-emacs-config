;; This is a minimal init config that will get ob-ipython working

;; (add-to-list 'load-path "/Users/will/.emacs.d/.cask/24.5.4/elpa/ob-ipython-20150613.135")
;; (add-to-list 'load-path "/Users/will/.emacs.d/.cask/24.5.4/elpa/dash-20150513.1027")
;; (add-to-list 'load-path "/Users/will/.emacs.d/.cask/24.5.4/elpa/dash-functional-20150311.2358")
;; (add-to-list 'load-path "/Users/will/.emacs.d/.cask/24.5.4/elpa/s-20140910.334")
;; (add-to-list 'load-path "/Users/will/.emacs.d/.cask/24.5.4/elpa/f-20150217.328")
;; (require 'ob-ipython)

;; Alternative version
(require 'cl)
(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(package-initialize)
(require 'ob-ipython)
