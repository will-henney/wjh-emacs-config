(use-package flymake-ruff
  :ensure t
  :hook (python-base-mode . flymake-ruff-load)
  :custom
  (flymake-ruff-executable "uvx")
  (flymake-ruff-args '("ruff"))
  )

(use-package reformatter :ensure t)
(reformatter-define ruff-format
  :program "uvx" :args '("ruff" "format" "-"))
(add-hook 'python-base-mode-hook #'ruff-format-on-save-mode)

;; WJH 2025-10-15 - Combine elpy with uv
;; Automatically activate enclosing venv
(defun wjh/pyvenv-auto-activate ()
  "Activate nearest .venv for this buffer."
  (when-let* ((root (locate-dominating-file default-directory ".venv"))
	      (venv (expand-file-name ".venv" root)))
    (pyvenv-activate venv)))
(add-hook 'python-base-mode-hook #'wjh/pyvenv-auto-activate)

(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  ;; Make sure elpy does not try to use pip
  (advice-add 'elpy-insert--pip-button-value-create :around
              (lambda (orig &rest args)
                "Skip pip-install buttons gracefully if pip is unavailable."
                (if (executable-find "pip")
                    (apply orig args)
                  ;; No pip available: show placeholder instead of error
                  (widget-create
                   'item
                   :tag "pip not available (using uv)"))))
  
  ;; WJH 2025-10-15 - Ditch jupyter for interactive shell for now
  ;; See wjh-python-elpy-minimalist-config.el if we want it back
  
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



