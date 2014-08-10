;; Load only elpy and its dependencies
(require 'cl-lib)
;; Make sure we use the new version
(defvar wjh-local-lisp-dir (expand-file-name "~/.emacs.d/lisp4elpy/"))
(cl-map 'list 
     '(lambda (x) (add-to-list 'load-path (concat wjh-local-lisp-dir x))) 
     '("elpy" "pyvenv" "company-mode" "yasnippet" "highlight-indentation"))
(require 'elpy)
(elpy-enable)
;; (pyvenv-activate (expand-file-name "~/anaconda/envs/py27"))
(setq elpy-rpc-backend "rope")

