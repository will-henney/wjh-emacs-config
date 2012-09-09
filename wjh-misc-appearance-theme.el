
  (deftheme wjh-misc-appearance
    "An attempt to de-uglify emacs")
  (custom-theme-set-variables
   'wjh-misc-appearance
   '(line-spacing 2 nil nil "Most modes look better with an extra 2 pixel padding between lines")
   '(fringe-mode (quote (4 . 0)) nil (fringe) "Fringe on left only, and half default width")
   '(indicate-buffer-boundaries (quote ((t) (top . left) (bottom . left) (up . left) (down . left))) nil nil "Put little glyphs in the fringe to show buffer boundaries")
   '(default-frame-alist (quote ((tool-bar-lines . 0) (vertical-scroll-bars . nil) (menu-bar-lines . 1) (internal-border-width . 0))))
   '(tabbar-mode nil nil (tabbar) "We don't want no stinking tab bars")
   '(show-paren-mode nil nil nil "Stop the blinking blinking")
   '(text-mode-hook (quote (smart-spacing-mode turn-on-word-wrap)))
   '(visual-line-mode nil t nil "Not sure what this is, but I don't think I want it")
   '(blink-cursor-mode nil nil nil "More blinking blinking - kill it")
   '(one-buffer-one-frame-mode nil nil nil "Sigh")
   '(size-indication-mode t nil nil "Gives buffer size in modeline after the % indicator")
   )
  (custom-theme-set-faces
   'wjh-misc-appearance
   '(echo-area ((t (:family "Monaco"))) nil "Make sure we don't use a proportional font here")
   '(custom-button ((default (:box 1))
                    (((class color) (background dark)) (:background "lightgrey" :foreground "black"))
                    ) nil "Begone horrible raised boxes!")
   '(custom-button-mouse ((t (:inherit custom-button :weight bold))) nil "Just embolden")
   '(custom-button-pressed ((t (:inherit custom-button :underline t :weight bold))) nil "Then underline too")
   '(mode-line ((t (:box nil :background "azure1" :foreground "black"))) nil "For powerline")
   '(mode-line-inactive ((t (:box nil))) nil "For powerline")
   )
  (provide-theme 'wjh-misc-appearance)
