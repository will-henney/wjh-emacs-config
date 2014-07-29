;;; Use colors for identifiers instead of keywords
;;; Copied mainly from Amit Patel's blog
;;; http://amitp.blogspot.mx/2014/04/emacs-rainbow-identifiers.html


(defun wjh/decolorize-prog-faces ()
  "Replace the syntax highlight colors with some subtle font changes"
  (face-remap-add-relative 'font-lock-constant-face 'default)
  (face-remap-add-relative 'font-lock-constant-face :underline t)
  (face-remap-add-relative 'font-lock-type-face 'default)
  (face-remap-add-relative 'font-lock-function-name-face 'default)
  (face-remap-add-relative 'font-lock-function-name-face :weight 'bold)
  (face-remap-add-relative 'font-lock-variable-name-face 'default)
  (face-remap-add-relative 'font-lock-keyword-face 'default)
  (face-remap-add-relative 'font-lock-keyword-face :slant 'italic)
  (face-remap-add-relative 'font-lock-builtin-face 'default)
  (face-remap-add-relative 'font-lock-builtin-face :slant 'italic)
)

;; remove pre-existing colors (except comments and strings)
(add-hook 'prog-mode-hook 'wjh/decolorize-prog-faces)
;; do the same for Org mode for the sake of code blocks
(add-hook 'org-mode-hook 'wjh/decolorize-prog-faces)

(setq
 color-identifiers:num-colors 30
 color-identifiers:color-luminance 0.75
 color-identifiers:min-color-saturation 0.2
 color-identifiers:max-color-saturation 0.4
)

;; Turn it on everywhere where we can
(global-color-identifiers-mode)


