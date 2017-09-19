;; 08 Nov 2013 - Rationalize modifier keys


;; ;; Main thing: option is meta
;; (setq mac-option-modifier 'meta)
;; ;; Set up the Cmd key as super - then define a handful of mac-ish bindings
;; (setq mac-command-modifier 'super)

;; WJH 20 Nov 2013 - try out a completely new system!
;; WJH 06 Mar 2014 - Now doing it system-wide instead
(require 'wjh-emacs-mac-unremap)



;; WJH 22 Nov 2013 - some convenience keys, to humor my muscle memory.
;; I keep pressing Ctl-A, which is bound to "s-a", when I mean to
;; press "Cmd-A", which is bound to "C-a"

;; WJH 24 Sep 2016 - removed these - not a mistake I ever make these days
;; (global-set-key (kbd "s-a") 'move-beginning-of-line)
;; (global-set-key (kbd "s-e") 'move-end-of-line)




;; Add in the Cmd-C, Cmd-V, Cmd-A, etc bindings like in aquamacs
;; This function copied from http://unix.stackexchange.com/questions/20849/emacs-how-to-copy-region-and-leave-it-highlighted
(defun kill-ring-save-keep-highlight (beg end)
  "Keep the region active after the kill"
  (interactive "r")
  (prog1 (kill-ring-save beg end)
    (setq deactivate-mark nil)))
(global-set-key (kbd "s-c") 'kill-ring-save-keep-highlight)
(global-set-key (kbd "s-v") 'cua-paste)
(global-set-key (kbd "s-a") 'mark-whole-buffer)

;; we already have C-` set to this, but bind it to ⌘-` as well, for
;; consistency with other apps
(global-set-key (kbd "s-`") 'other-frame)

;; emacs-25.2-mac-6.6 (2017-08-24) adds mac-send-action function
;; 19 Sep 2017: Use it to implement ⌘ H and ⎇ ⌘ H functionality
(when (functionp 'mac-send-action)
  (defun wjh/mac-hide-emacs ()
    "Hide the Emacs application"
    (interactive)
    (mac-send-action 'hide))
  (defun wjh/mac-hide-others ()
    "Hide all the other applications"
    (interactive)
    (mac-send-action 'hideOtherApplications))
  (global-set-key (kbd "s-h") 'wjh/mac-hide-emacs)
  (global-set-key (kbd "M-s-h") 'wjh/mac-hide-others))

;; Thirdly - use Fn key as hyper
(setq mac-function-modifier 'hyper)
;; This is used for some bindings in wjh-smartparens-config.el
;; And restore some previous bindings 
(global-set-key (kbd "<H-left>") 'beginning-of-buffer)
(global-set-key (kbd "<H-right>") 'end-of-buffer)
(global-set-key (kbd "<H-up>") 'cua-scroll-down)
(global-set-key (kbd "<H-down>") 'cua-scroll-up)
(global-set-key (kbd "<H-backspace>") 'delete-char)

;; 14 Sep 2015 - new bindings for function key

;; Saving different points in the buffer, and returning to them These
;; are functions that are usually on the 'C-x r' map, but using the
;; function keys will make them easier to use, and might make me
;; actually use them!
(global-set-key (kbd "H-SPC") 'point-to-register)
(global-set-key (kbd "H-z") 'jump-to-register)
(global-set-key (kbd "H-m") 'bookmark-set)
(global-set-key (kbd "H-b") 'bookmark-jump)
(global-set-key (kbd "H-l") 'bookmark-bmenu-list)




;;
;; Customize the animations for 3-finger swiping left/right and up/down
;;
(defun wjh/previous-buffer (event)
  "Like `previous-buffer', but operate on the window where EVENT occurred."
  (interactive "e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window :type 'swipe :direction 'right)
    (with-selected-window window
      (previous-buffer))))

(defun wjh/next-buffer (event)
  "Like `next-buffer', but operate on the window where EVENT occurred."
  (interactive "e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window :type 'swipe :direction 'left)
    (with-selected-window window
      (next-buffer))))

(defun wjh/beginning-of-buffer (event)
  "Like `beginning-of-buffer' but with fancy animation"
  (interactive "^e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window :type 'swipe :direction 'up :duration 0.5)
    (with-selected-window window
      (beginning-of-buffer))))

(defun wjh/end-of-buffer (event)
  "Like `end-of-buffer' but with fancy animation"
  (interactive "^e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window :type 'swipe :direction 'down :duration 0.5)
    (with-selected-window window
      (end-of-buffer))))

(defun wjh/scroll-down (event)
  "Like `scroll-down' but animated and acting on window where mouse is"
  (interactive "^e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window
			 :type 'swipe
			 :direction 'down
			 :width 3
			 :opacity 0.5
			 :duration 0.4)
    (with-selected-window window
      (cua-scroll-down))))

(defun wjh/scroll-up (event)
  "Like `scroll-up' but animated and acting on window where mouse is"
  (interactive "^e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window
			 :type 'swipe
			 :direction 'up
			 :width 3
			 :opacity 0.5
			 :duration 0.4)
    (with-selected-window window
      (cua-scroll-up))))

(global-set-key [swipe-up] 'wjh/scroll-up)
(global-set-key [swipe-down] 'wjh/scroll-down)

(global-set-key [C-swipe-up] 'wjh/beginning-of-buffer)
(global-set-key [C-swipe-down] 'wjh/end-of-buffer)

(global-set-key [swipe-left] 'wjh/previous-buffer)
(global-set-key [swipe-right] 'wjh/next-buffer)

(defun wjh/drop-event (event)
  "Dummy replacement for `mac-mwheel-scroll' that does nothing

Bind to `wheel-left`, `wheel-right` so as to ignore 2-finger
left/right swipes"
  (interactive (list last-input-event))
  nil)
(global-set-key [wheel-left] 'wjh/drop-event)
(global-set-key [wheel-right] 'wjh/drop-event)

;; Sort out my PATH variables at last
;; Copied from this gist:
;; https://gist.github.com/bradleywright/2046593

;; This sets the Emacs "PATH" environment variable and the `exec-path` 
;; variable to the same value your login shell sees. The reason this 
;; is necessary is because of this:
;; 
;; http://developer.apple.com/library/mac/#qa/qa1067/_index.html
;;
;; Basically apps launched from Finder inherit their environment from
;; a .plist file rather than the shell environment.
(defun set-exec-path-from-shell-PATH ()
  "Sets the exec-path to the same value used by the user shell"
  (let ((path-from-shell
         (replace-regexp-in-string
          "[[:space:]\n]*$" ""
          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
;; call function now
(set-exec-path-from-shell-PATH)

;; 05 Mar 2014 - Clean up the menu-bar.  The idea here is to eliminate
;; top-level menus that I almost never would want to use.  The only
;; ones I leave are "Emacs", "Edit", "Help", plus any mode-specific
;; ones.  This should then leave loads of space in my menubar for all
;; my little OS X menubar items, which might otherwise disappear
(global-unset-key [menu-bar tools])
(global-unset-key [menu-bar options])
(global-unset-key [menu-bar buffer])
(global-unset-key [menu-bar file])
(global-unset-key (kbd "<menu-bar> <Virtual Envs>"))
(add-hook 'pyvenv-mode-hook
	  (lambda ()
	    (define-key
	      pyvenv-mode-map
	      (kbd "<menu-bar> <Virtual Envs>") 'nil)))
