;; Configuration for zerolfx/copilot.el
;; Heavily based on https://github.com/rksm/copilot-emacsd
;;
;; The only changes I have made are as follows
;; - Removed all references to company mode
;; - Used quelpa to load the package from GitHub
;; - Modified key bindings to work with PgDn/PgUp on my keyboard
;; - Enabled compatibility with org-cycle.
;; - Changed the global binding to M-C-<tab> instead of M-C-<return>
;;   to avoid collision with org-insert-heading-respect-content

;; WJH 2023-03-27: It looks like the following function is never
;; called. Instead the command indent-for-tab-command is advised to
;; check copilot first. So I have extended the same treatment to
;; org-cycle. See bindings in the :config section at the bottom of
;; this file.
(defun rk/copilot-tab ()
  "Tab command that will complete with copilot if a completion is
available. Otherwise will tab-indent."
  (interactive)
  (or (copilot-accept-completion)
      (org-cycle)
      (indent-for-tab-command)))

(defun rk/copilot-complete-or-accept ()
  "Command that either triggers a completion or accepts one if one
is available. Useful if you tend to hammer your keys like I do."
  (interactive)
  (if (copilot--overlay-visible)
      (progn
        (copilot-accept-completion)
        (open-line 1)
        (next-line))
    (copilot-complete)))

(defun rk/copilot-quit ()
  "Run `copilot-clear-overlay' or `keyboard-quit'. If copilot is
cleared, make sure the overlay doesn't come back too soon."
  (interactive)
  (condition-case err
      (when copilot--overlay
        (lexical-let ((pre-copilot-disable-predicates copilot-disable-predicates))
          (setq copilot-disable-predicates (list (lambda () t)))
          (copilot-clear-overlay)
          (run-with-idle-timer
           1.0
           nil
           (lambda ()
             (setq copilot-disable-predicates pre-copilot-disable-predicates)))))
    (error handler)))

(defun rk/copilot-complete-if-active (next-func n)
  (let ((completed (when copilot-mode (copilot-accept-completion))))
    (unless completed (funcall next-func n))))

(defun rk/no-copilot-mode ()
  "Helper for `rk/no-copilot-modes'."
  (copilot-mode -1))

(defvar rk/no-copilot-modes '(shell-mode
                              inferior-python-mode
                              eshell-mode
                              term-mode
                              vterm-mode
                              comint-mode
                              compilation-mode
                              debugger-mode
                              dired-mode-hook
                              compilation-mode-hook
                              flutter-mode-hook
                              minibuffer-mode-hook)
  "Modes in which copilot is inconvenient.")

(defvar rk/copilot-manual-mode nil
  "When `t' will only show completions when manually triggered, e.g. via M-C-<tab>.")

(defvar rk/copilot-enable-for-org t
  "Should copilot be enabled for org-mode buffers?")



(defun rk/copilot-enable-predicate ()
  ""
  (and
   (eq (get-buffer-window) (selected-window))))

(defun rk/copilot-disable-predicate ()
  "When copilot should not automatically show completions."
  (or rk/copilot-manual-mode
      (member major-mode rk/no-copilot-modes)
      (and (not rk/copilot-enable-for-org) (eq major-mode 'org-mode))
      (company--active-p)))

(defun rk/copilot-change-activation ()
  "Switch between three activation modes:
- automatic: copilot will automatically overlay completions
- manual: you need to press a key (M-C-<return>) to trigger completions
- off: copilot is completely disabled."
  (interactive)
  (if (and copilot-mode rk/copilot-manual-mode)
      (progn
        (message "deactivating copilot")
        (global-copilot-mode -1)
        (setq rk/copilot-manual-mode nil))
    (if copilot-mode
        (progn
          (message "activating copilot manual mode")
          (setq rk/copilot-manual-mode t))
      (message "activating copilot mode")
      (global-copilot-mode))))

(defun rk/copilot-toggle-for-org ()
  "Toggle copilot activation in org mode. It can sometimes be
annoying, sometimes be useful, that's why this can be handly."
  (interactive)
  (setq rk/copilot-enable-for-org (not rk/copilot-enable-for-org))
  (message "copilot for org is %s" (if rk/copilot-enable-for-org "enabled" "disabled")))

;; load the copilot package
(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("dist" "*.el"))
  :diminish ;; don't show in mode line (we don't wanna get caught
	    ;; cheating, right? ;)
  :config
  ;; keybindings that are active when copilot shows completions
  (define-key copilot-mode-map (kbd "M-C-<next>") #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "M-C-<prior>") #'copilot-previous-completion)
  ;; Add versions of the above two that work with my keyboard
  (define-key copilot-mode-map (kbd "M-C-H-<down>") #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "M-C-H-<up>") #'copilot-previous-completion)
  (define-key copilot-mode-map (kbd "M-C-<right>") #'copilot-accept-completion-by-word)
  (define-key copilot-mode-map (kbd "M-C-<down>") #'copilot-accept-completion-by-line)

  ;; global keybindings that are always active
  (define-key global-map (kbd "M-C-<tab>") #'rk/copilot-complete-or-accept)
  (define-key global-map (kbd "M-C-<escape>") #'rk/copilot-change-activation)

  ;; Do copilot-quit when pressing C-g
  (advice-add 'keyboard-quit :before #'rk/copilot-quit)

  ;; complete by pressing right or tab but only when copilot completions are
  ;; shown. This means we leave the normal functionality intact.
  (advice-add 'right-char :around #'rk/copilot-complete-if-active)
  (advice-add 'indent-for-tab-command :around #'rk/copilot-complete-if-active)
  (advice-add 'org-cycle :around #'rk/copilot-complete-if-active)

  ;; deactivate copilot for certain modes
  (add-to-list 'copilot-enable-predicates #'rk/copilot-enable-predicate)
  (add-to-list 'copilot-disable-predicates #'rk/copilot-disable-predicate))

(eval-after-load 'copilot
  '(progn
     (global-copilot-mode)))

(copilot-login)
