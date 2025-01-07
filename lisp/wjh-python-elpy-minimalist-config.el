
(use-package elpy
  :ensure t
  ;; :pin elpy
  :config
  (elpy-enable)
  ;; WJH 2024-12-31 - this is the homebrew version of python in /opt/homebrew/bin
  (setq elpy-rpc-python-command "python3")
  (setq python-shell-interpreter "jupyter"
	python-shell-interpreter-args "console --simple-prompt"
	;; python-shell-interpreter-args "--pylab=osx --pdb --nosep --classic"
	;; python-shell-prompt-regexp ">>> "
	;; python-shell-prompt-output-regexp ""
	python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
	python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
	python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"
	)
  ;; WJH 08 Nov 2013 - we prefer to use these for smartscan
  (define-key elpy-mode-map (kbd "M-n") nil)
  (define-key elpy-mode-map (kbd "M-p") nil)
  ;; Use the Shift-Meta key instead 
  (define-key elpy-mode-map (kbd "M-N") 'elpy-nav-forward-definition)
  (define-key elpy-mode-map (kbd "M-P") 'elpy-nav-backward-definition)

  ;; WJH 11 Dec 2014 - fix conflict with smartparens
  (define-key elpy-mode-map (kbd "C-<right>") nil)
  (define-key elpy-mode-map (kbd "C-<left>") nil)
  (define-key elpy-mode-map (kbd "S-C-<right>") 'elpy-nav-forward-block)
  (define-key elpy-mode-map (kbd "S-C-<left>") 'elpy-nav-backward-block))


