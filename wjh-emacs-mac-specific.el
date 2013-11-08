;; 08 Nov 2013 - Rationalize modifier keys

;; Main thing: option is meta
(setq mac-option-modifier 'meta)
;; Set up the Cmd key as super - then define a handful of mac-ish bindings
(setq mac-command-modifier 'super)
;; Add in the Cmd-C, Cmd-V, Cmd-A, etc bindings like in aquamacs
(global-set-key (kbd "s-a") 'mark-whole-buffer)
;; This function copied from http://unix.stackexchange.com/questions/20849/emacs-how-to-copy-region-and-leave-it-highlighted
(defun kill-ring-save-keep-highlight (beg end)
  "Keep the region active after the kill"
  (interactive "r")
  (prog1 (kill-ring-save beg end)
    (setq deactivate-mark nil)))
(global-set-key (kbd "s-c") 'kill-ring-save-keep-highlight)
(global-set-key (kbd "s-v") 'cua-paste)

;; Thirdly - use Fn key as hyper
(setq mac-function-modifier 'hyper)
;; This is used for some bindings in wjh-smartparens-config.el
;; And restore some previous bindings 
(global-set-key (kbd "<H-left>") 'beginning-of-buffer)
(global-set-key (kbd "<H-right>") 'end-of-buffer)
(global-set-key (kbd "<H-up>") 'cua-scroll-down)
(global-set-key (kbd "<H-down>") 'cua-scroll-up)
(global-set-key (kbd "<H-backspace>") 'delete-char)


