;; The nuclear option - use the command for control
;; This is the layour that is closest to what was intended in early emacs
(setq mac-command-modifier 'control)
(setq mac-option-modifier 'meta)
(setq mac-control-modifier 'super)
(setq mac-pass-command-to-system nil)

;; Problems with this are as follows: 
;; Some keys are still grabbed by the system:
;; Cmd-TAB, Cmd-SPACE (this is Alfred's fault)
;; + We could map s-tab to other-window
(global-set-key (kbd "<s-tab>") 'other-window)
;; + We could make Alfred use another key
;;   or we could use C-@ in emacs to set the mark.
;;   Decided to use Option-Cmd-SPACE for Alfred

;; C-# and C-$ are used for screen shots: Cmd-Shift-3, Cmd-Shift-4,
;; but this is OK since they are undefined in emacs

 (provide 'wjh-emacs-mac-remap)
