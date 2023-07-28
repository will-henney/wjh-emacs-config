;; puni is a mode like paredit and smartparens, but hopefully more suited to me
(use-package puni
  :ensure t
  :defer t
  ;; Extra key bindings
  :bind (("C-M-=" . puni-expand-region)
	 ("C-M-]" . puni-slurp-forward)
	 ("C-M-[" . puni-slurp-backward)
	 ("C-M-}" . puni-barf-forward)
	 ("C-M-{" . puni-barf-backward)
	 ("C-M-|" . puni-split)
	 ("C-M-^" . puni-splice)
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
		       ("q" . puni-squeeze)
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
