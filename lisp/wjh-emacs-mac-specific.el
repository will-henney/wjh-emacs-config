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
;; 2024-05-08 - add undo/redo bindings on Cmd-Z and Cmd-Shift-Z, but
;; do it in a way that is agnostic as to which undo system we are
;; using by looking up the current binding for C-/ and C-?
(global-set-key (kbd "s-z") (keymap-lookup (current-global-map) "C-/"))
(global-set-key (kbd "s-Z") (keymap-lookup (current-global-map) "C-?"))

;; we already have C-` set to this, but bind it to ⌘-` as well, for
;; consistency with other apps
(global-set-key (kbd "s-`") 'other-frame)

;; 2022-10-06 - Use Command key with numbers as an alias for C-x NUMBER
;; 2024-05-08 - Also add keypad number bindings explicitly, since they
;;              do not get translated automatically
(global-set-key (kbd "s-4") 'ctl-x-4-prefix)
(global-set-key (kbd "s-<kp-4>") 'ctl-x-4-prefix)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-<kp-1>") 'delete-other-windows)
(global-set-key (kbd "s-2") 'split-window-below)
(global-set-key (kbd "s-<kp-2>") 'split-window-below)
(global-set-key (kbd "s-3") 'split-window-right)
(global-set-key (kbd "s-<kp-3>") 'split-window-right)
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-<kp-0>") 'delete-window)

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



(defun wjh/dired-open-file-at-point ()
  "Run the shell command 'open' on the file at point in dired mode."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (if file
        (start-process "dired-open-file" nil "open" file)
      (message "No file at point"))))
(define-key dired-mode-map (kbd "s-o") 'wjh/dired-open-file-at-point)

;;
;; Customize the animations for 3-finger swiping left/right and up/down
;;
(defun wjh/previous-buffer (event)
  "Like `previous-buffer', but operate on the window where EVENT occurred.
This is the same as `mac-previous-buffer' in mac-win.el but with
a different animation style"
  (interactive "e")
  (let ((window (posn-window (event-start event))))
    (mac-start-animation window :type 'swipe :direction 'right)
    (with-selected-window window
      (previous-buffer))))

(defun wjh/next-buffer (event)
  "Like `next-buffer', but operate on the window where EVENT occurred.
This is the same as `mac-next-buffer' in mac-win.el but with
a different animation style."
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

;; WJH 2025-01-22 - I used chatgpt to help me write a more general
;; solution. I first asked "Can you help me write an emacs lisp macro
;; that will wrap an arbitrary function so that the function acts in
;; the window where the mouse pointer is", but I had to ask several
;; follow up questions to nudge it to give me something that worked
(defmacro with-event-window (event &rest body)
  "Execute BODY in the window corresponding to EVENT."
  `(let ((window (posn-window (event-start ,event)))) ; Get the window from the event
     (if (windowp window)
         (with-selected-window window
           ,@body)
       (message "Event did not occur over a valid window."))))

;; WJH 2025-01-21 = I never used these because they are confusing and ugly
;; (global-set-key [swipe-up] 'wjh/scroll-up)
;; (global-set-key [swipe-down] 'wjh/scroll-down)

;; Function by Ian Kelling from Stack Overflow
;; https://stackoverflow.com/questions/3393834/how-to-move-forward-and-backward-in-emacs-mark-ring
(defun unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
      (when mark-ring
        (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
        (set-marker (mark-marker) (car (last mark-ring)) (current-buffer))
        (when (null (mark t)) (ding))
        (setq mark-ring (nbutlast mark-ring))
        (goto-char (marker-position (car (last mark-ring))))))

;; Define a bunch of wrapped commands that work on the buffer under
;; the mouse pointer, rather than the selected buffer. This is so we
;; can use the swipe gestures in other windows without having to
;; explicitly click into them first.
(defun pop-to-mark-under-mouse (event)
  (interactive "e") (with-event-window event (pop-to-mark-command)))
(defun unpop-to-mark-under-mouse (event)
  (interactive "e") (with-event-window event (unpop-to-mark-command)))

  
;; WJH 2025-01-21 - vertical swipes to go back and forward in the mark ring
(global-set-key [swipe-up] 'pop-to-mark-under-mouse)
(global-set-key [swipe-down] 'unpop-to-mark-under-mouse)
;; TODO - port all the other functions to use the with-event-window macro


;; Shift swipes to go to top/bottom of buffer
(global-set-key [S-swipe-up] 'wjh/beginning-of-buffer)
(global-set-key [S-swipe-down] 'wjh/end-of-buffer)

;; Control swipes to go to enclosing folder in dired and return
(global-set-key [C-swipe-up] 'wjh/dired-jump)
(defun wjh/swipe-as-return ()
  "Call the function bound to the RET key."
  (interactive)
  (call-interactively (key-binding (kbd "RET"))))
;; (global-set-key [C-swipe-down] 'toggle-frame-fullscreen)
;; The idea is that this can be used in dired buffer to open file at
;; point, but it might also be useful in other contexts
(global-set-key [C-swipe-down] 'wjh/swipe-as-return)

;; Back and forth through buffers with swipe animations 
(global-set-key [swipe-left] 'wjh/previous-buffer)
(global-set-key [swipe-right] 'wjh/next-buffer)
;; Shifted version uses default sliding animations
(global-set-key [S-swipe-left] 'mac-previous-buffer)
(global-set-key [S-swipe-right] 'mac-next-buffer)


;; 19 Sep 2017 - THIS DOESN'T WORK
;; Try to get an animation on going to full screen
;; Unfortunately, you don't see anything

;; (defun wjh/animate-on-fullscreen (event)
;;   (interactive "e")
;;   (let ((window (posn-window (event-start event))))
;;     (mac-start-animation window :type 'dissolve ':duration 4.0)
;;     (mac-mouse-turn-on-fullscreen event)))
;; (global-set-key (kbd "<C-magnify-up>") 'wjh/animate-on-fullscreen)

(defun wjh/drop-event (event)
  "Dummy replacement for `mac-mwheel-scroll' that does nothing

Bind to `wheel-left`, `wheel-right` so as to ignore 2-finger
left/right swipes"
  (interactive (list last-input-event))
  nil)
(global-set-key [wheel-left] 'wjh/drop-event)
(global-set-key [wheel-right] 'wjh/drop-event)

;; 30 Jan 2020 OSOLETED by exec-path-from-shell.py - see wjh-emacs-use-package.el
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
;; (defun set-exec-path-from-shell-PATH ()
;;   "Sets the exec-path to the same value used by the user shell"
;;   (let ((path-from-shell
;;          (replace-regexp-in-string
;;           "[[:space:]\n]*$" ""
;;           (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))
;; ;; call function now
;; (set-exec-path-from-shell-PATH)

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


;; 2023-05-26 This is a more sensible default, so scrolling does not
;; get stuck in org mode buffers
(setq mac-mouse-wheel-smooth-scroll nil)

;; 2023-08-12 New drag options in 29.1 but I can't get them to work 🙁
(setq mouse-drag-and-drop-region-cross-program t)
(setq mouse-drag-mode-line-buffer t)
