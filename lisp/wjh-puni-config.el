;; puni is a mode like paredit and smartparens, but hopefully more suited to me
(use-package puni
  :ensure t
  :defer t
  ;; These are the default puny bindings - see https://github.com/AmaiKinono/puni
  ;; 
  ;; Navigation
  ;; 
  ;; puni-forward-sexp	C-M-f
  ;; puni-backward-sexp	C-M-b
  ;; puni-beginning-of-sexp	C-M-a
  ;; puni-end-of-sexp	C-M-e
  ;; 
  ;; Deletion
  ;; 
  ;; puni-forward-delete-char	C-d
  ;; puni-backward-delete-char	DEL
  ;; puni-forward-kill-word	M-d
  ;; puni-backward-kill-word	M-DEL
  ;; puni-kill-line	C-k
  ;; puni-backward-kill-line	C-S-k
  ;; 
  ;; My personal extra key bindings
  :bind (("C-M-=" . puni-expand-region)	; similar to er/expand-region ("C-=")
	 ("C-M-]" . puni-slurp-forward)
	 ("C-M-[" . puni-slurp-backward)
	 ("C-M-}" . puni-barf-forward)
	 ("C-M-{" . puni-barf-backward)
	 ("C-M-|" . puni-split)
	 ("C-M-^" . puni-splice)
	 ("C-M-_" . puni-squeeze)
	 ("s-<backspace>" . puni-force-delete)
	 )
  :init
  ;; The autoloads of Puni are set up so you can enable `puni-mode` or
  ;; `puni-global-mode` before `puni` is actually loaded. Only after
  ;; you press any key that calls Puni commands, it's loaded.
  (puni-global-mode)
  (add-hook 'term-mode-hook #'puni-disable-puni-mode)
  ;; The following is based on a reddit comment from u/karthink
  ;; https://www.reddit.com/user/karthink/
  ;; https://www.reddit.com/r/emacs/comments/108bzwl/comment/j47oped/
  (defvar puni-navigation-map
    (let ((map (make-sparse-keymap)))
      (pcase-dolist (`(,k . ,f)
                     '(("u" . up-list)
		       ("U" . backward-up-list)
		       ("f" . puni-forward-sexp)
                       ("b" . puni-backward-sexp)
                       ("d" . down-list)
		       ("a" . puni-beginning-of-sexp)
		       ("e" . puni-end-of-sexp)
                       ("n" . puni-syntactic-forward-punct)
                       ("p" . puni-syntactic-backward-punct)
                       ("k" . puni-kill-line)
                       ("K" . puni-backward-kill-line)
		       ("=" . puni-expand-region)
		       ("_" . puni-squeeze)
                       ("]" . puni-slurp-forward)
                       ("[" . puni-slurp-backward)
                       ("}" . puni-barf-forward)
                       ("{" . puni-barf-backward)
                       ("r" . puni-raise)
                       ("C" . puni-convolute)
                       ("|" . puni-split)
                       ("^" . puni-splice)
                       ("\\" . indent-region)
                       ("x" . eval-defun)
                       ("t" . puni-transpose)))
        (define-key map (kbd k) f))
      map))
  (map-keymap
   (lambda (_ cmd)
   (put cmd 'repeat-map 'puni-navigation-map))
   puni-navigation-map))
