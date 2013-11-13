;; eliminate UI annoyances
(scroll-bar-mode -1) ; hmm, inconsistent with the others: 0 is true here
(blink-cursor-mode 0)
(tool-bar-mode 0) 
(show-paren-mode 0)

;; Suggested by bbatsov
;; https://github.com/bbatsov/projectile/issues/187
(setq inhibit-startup-screen t)
