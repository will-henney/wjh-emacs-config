;; Wjh 2025-10-15 - new python setup using eglot mode, uv, and pyright

;;
;; Fly-make uses ruff linter to mark errors or bad practices
;; 
(use-package flymake-ruff
  :ensure t
  :hook (python-base-mode . flymake-ruff-load)
  :custom
  (flymake-ruff-executable "uvx")
  (flymake-ruff-args '("ruff"))
  )

;;
;; Then also use ruff re-formatter to fix style on buffer save
;; 
(use-package reformatter
  :ensure t
  :config
  (reformatter-define ruff-format
    :program "uvx" :args '("ruff" "format" "-"))
  :hook (python-base-mode . ruff-format-on-save-mode)
  )

;; Automatically activate enclosing virtual environment
(defun wjh/pyvenv-auto-activate ()
  "Activate nearest .venv for this buffer."
  (when-let* ((root (locate-dominating-file default-directory ".venv"))
	      (venv (expand-file-name ".venv" root)))
    (pyvenv-activate venv)))
(add-hook 'python-base-mode-hook #'wjh/pyvenv-auto-activate)

;; Eglot + Pyrefly for autocomplete, etc
(use-package eglot
  :hook
  (python-base-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(python-base-mode . ("uvx" "pyrefly" "lsp")))
  )

;; Completions UI
(use-package corfu
  :ensure t
  :hook prog-mode
  :custom
  (corfu-auto t "auto popup")
  (corfu-auto-delay 0.2 "Default is 0.2")
  (corfu-auto-prefix 2 "Default value is 3")
  (corfu-preview-current nil)
  (corfu-quit-no-match 'separator)
  )

;; Documentation in echo area and on demand in separate buffer
(use-package eldoc
  :custom
  ;; (eldoc-echo-area-use-multiline-p t "Unconditionally expand to fit docs")
  (eldoc-echo-area-use-multiline-p 3)
  ;; (eldoc-echo-area-use-multiline-p nil "Keep things compact")
  (eldoc-echo-area-display-truncation-message t)
  :hook eglot-managed-mode)

;; 
(use-package eglot-signature-eldoc-talkative
  :ensure t
  :config
  (advice-add #'eglot-signature-eldoc-function
	      :override #'eglot-signature-eldoc-talkative)
  )

;; (use-package eldoc-box
;;   :ensure t
;;   ;; WJH 2025-10-16 - this was a bit too much
;;   ;; :hook (eglot-managed-mode . eldoc-box-hover-mode)
;;   )
