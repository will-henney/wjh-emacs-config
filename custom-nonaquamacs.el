(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight light :height 130 :width normal :foundry "nil" :family "Source Code Pro"))))
 '(TeX-fold-folded-face ((t (:foreground "#8faeb0"))))
 '(ace-jump-face-background ((t (:foreground "gray60"))))
 '(ace-jump-face-foreground ((t (:foreground "orange"))))
 '(avy-lead-face ((t (:background "#3F3F3F" :foreground "lemon chiffon" :inverse-video nil :weight bold))))
 '(avy-lead-face-0 ((t (:background "#3F3F3F" :foreground "orange" :inverse-video nil :weight ultra-bold))))
 '(aw-leading-char-face ((t (:foreground "gold" :weight ultra-bold :height 1.5))))
 '(button ((t (:underline nil :slant oblique :weight semi-bold))))
 '(col-highlight ((t (:background "#603838"))))
 '(custom-button ((((type x w32 mac) (class color)) (:background "lightgrey" :foreground "black" :box (:line-width 2 :color "gray95")))))
 '(custom-button-mouse ((((type x w32 mac) (class color)) (:background "#ddc4bf" :foreground "black" :box (:line-width 2 :color "gray95")))))
 '(custom-button-pressed ((((type x w32 mac) (class color)) (:background "#ddc4bf" :foreground "black" :box (:line-width 2 :style pressed-button)))))
 '(emacs-wiki-header-1 ((t (:inherit nil :weight bold :height 1.15))) t)
 '(emacs-wiki-header-2 ((t (:inherit nil :weight bold :height 1.1))) t)
 '(emacs-wiki-header-3 ((t (:inherit nil :weight bold :height 1.05))) t)
 '(emacs-wiki-header-4 ((t (:inherit nil :weight bold :height 1.0))) t)
 '(emacs-wiki-header-5 ((t (:inherit italic :weight normal :height 1.0))) t)
 '(emacs-wiki-header-6 ((t (:inherit nil :weight normal :height 1.0))) t)
 '(emacs-wiki-link-face ((t (:foreground "blue4" :underline "blue4" :weight bold))) t)
 '(emacs-wiki-verbatim-face ((t (:foreground "gray60"))) t)
 '(fixed-pitch ((t nil)))
 '(font-latex-bold-face ((t (:inherit bold))))
 '(font-latex-italic-face ((t (:inherit italic))))
 '(font-latex-math-face ((t (:inherit fixed-pitch :foreground "#cceeee"))))
 '(font-latex-script-char-face ((t (:foreground "LightPink1"))))
 '(font-latex-sectioning-5-face ((t (:inherit monospace :foreground "#dda090" :weight demibold))))
 '(font-latex-sedate-face ((t (:inherit fixed-pitch :foreground "LightGray"))))
 '(font-latex-slide-title-face ((t (:inherit font-latex-sectioning-5-face :weight bold :height 1.2))))
 '(font-latex-title-1-face ((t (:inherit font-latex-title-2-face :height 1.05))) t)
 '(font-latex-title-2-face ((t (:inherit font-latex-title-3-face :height 1.05))) t)
 '(font-latex-title-3-face ((t (:inherit font-latex-title-4-face :height 1.05))) t)
 '(font-latex-warning-face ((t (:foreground "#e5786d" :weight normal))))
 '(font-lock-comment-face ((t (:foreground "ivory3" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "#cFfBcF"))))
 '(font-lock-function-name-face ((t (:inherit fixed-pitch :foreground "#cccccc" :weight normal))))
 '(font-lock-keyword-face ((t (:inherit fixed-pitch :foreground "SlateGray2" :weight normal))))
 '(font-lock-string-face ((t (:foreground "pale goldenrod" :slant italic))))
 '(font-lock-type-face ((t (:foreground "#ccdddd" :weight light))))
 '(font-lock-variable-name-face ((t (:inherit fixed-pitch :foreground "#ffcf8f"))))
 '(fringe ((t (:background "#484848" :foreground "gray50"))))
 '(git-gutter:added ((t (:foreground "#7F9F7F" :weight bold))))
 '(git-gutter:deleted ((t (:foreground "#CC9393" :weight bold))))
 '(git-gutter:modified ((t (:foreground "#DC8CC3" :weight bold))))
 '(git-gutter:unchanged ((t (:background "yellow" :foreground "#DCDCCC" :weight bold))))
 '(helm-selection ((t (:background "#204060" :foreground "white" :underline nil :weight bold))) nil "Third attempt at getting this right.  Inverse video wasn't working; made me thing it was a heading.  Hopefully this will be easier to spot.")
 '(helm-source-header ((t (:background "#2B2B2B" :foreground "seashell4" :inverse-video t :box nil :underline nil :weight bold))))
 '(highlight ((t (:background "coral4"))))
 '(highlight-indentation-current-column-face ((t (:background "gray30"))) t)
 '(highlight-indentation-face ((t (:underline "gray40"))) t)
 '(hl-line ((t (:inherit highlight :background "#603838"))))
 '(imenu-list-entry-face ((t (:height 0.6 :width expanded))))
 '(imenu-list-entry-face-0 ((t (:inherit imenu-list-entry-face :foreground "gray90"))))
 '(imenu-list-entry-face-1 ((t (:inherit imenu-list-entry-face :foreground "gray70"))))
 '(imenu-list-entry-face-2 ((t (:inherit imenu-list-entry-face :foreground "gray60"))))
 '(imenu-list-entry-face-3 ((t (:inherit imenu-list-entry-face :foreground "gray50"))))
 '(link ((t (:foreground "light steel blue" :underline t :weight semi-bold))))
 '(linum ((t (:background "#3F3F3F" :foreground "#9FC59F" :height 0.7))))
 '(markdown-bold-face ((t (:weight bold))))
 '(markdown-header-face ((t (:inherit org-level-1 :weight bold))))
 '(markdown-italic-face ((t (:slant italic))))
 '(markdown-link-face ((t (:inherit org-link))))
 '(markdown-url-face ((t (:inherit font-lock-string-face :foreground "dark gray" :height 0.6))))
 '(menu ((t (:background "#00000" :foreground "#808080"))))
 '(minibuffer-prompt ((t (:foreground "LightBlue1"))))
 '(mode-line ((t (:inherit variable-pitch :background "#201010" :foreground "white" :inverse-video nil :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t (:inherit sml/filename :weight bold))))
 '(mode-line-inactive ((t (:inherit mode-line :background "gray20" :inverse-video nil :box nil :weight light :height 1.0))))
 '(nxml-element-local-name ((t (:inherit font-lock-function-name-face :foreground "lemon chiffon" :slant italic :weight bold))))
 '(org-block ((t (:inherit fixed-pitch :background "gray27" :weight ultra-light :height 1.0))))
 '(org-block-background ((t (:inherit fixed-pitch :background "gray18"))))
 '(org-date ((t (:inherit org-table :foreground "#c2a9c2" :underline t))))
 '(org-formula ((t (:inherit org-table :foreground "LightSalmon1"))))
 '(org-indent ((t (:foreground "#3f3f3f"))))
 '(org-level-1 ((t (:inherit bold :foreground "#fffacd" :height 1.2))))
 '(org-level-2 ((t (:inherit bold :foreground "#fefad4" :height 1.2))))
 '(org-level-3 ((t (:inherit bold :foreground "#fdf9db" :height 1.2))))
 '(org-level-4 ((t (:inherit bold :foreground "#fcf9e2" :height 1.2))))
 '(org-level-5 ((t (:inherit bold :foreground "#fbf9ea" :height 1.2))))
 '(org-level-6 ((t (:inherit bold :foreground "#faf9f1" :height 1.2))))
 '(org-level-7 ((t (:inherit bold :foreground "#f9f8f8" :height 1.2))))
 '(org-level-8 ((t (:inherit bold :foreground "#f8f8ff" :height 1.2))))
 '(org-link ((t (:foreground "#D0BF8F" :underline "#888" :slant italic))))
 '(org-meta-line ((t (:inherit (fixed-pitch org-block-background) :foreground "gray60" :weight light))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-ref-cite-face ((t (:inherit org-link :foreground "medium sea green"))))
 '(org-ref-label-face ((t (:inherit org-link :foreground "indian red"))))
 '(org-special-keyword ((t (:inherit (font-lock-keyword-face fixed-pitch) :foreground "#a5a565" :slant italic :weight normal))))
 '(org-table ((t (:inherit (fixed-pitch unspecified) :family "Victor Mono Thin" :foreground "PaleTurquoise1" :height 1.0))))
 '(org-tag ((t (:foreground "gray60" :slant italic :weight thin :height 1.0))))
 '(planner-completed-task-face ((t (:foreground "gray50" :strike-through t))) t)
 '(popup-menu-mouse-face ((t (:background "#D0BF8F" :foreground "#000000"))))
 '(popup-tip-face ((t (:background "gray40" :foreground "DarkOliveGreen1" :height 0.8))))
 '(region ((t (:background "gold4" :foreground "#dcdccc"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:background "#fed"))))
 '(sh-heredoc ((t (:foreground "tan1"))))
 '(sh-heredoc-face ((t (:foreground "tan4"))) t)
 '(sml/filename ((t (:inherit sml/global :foreground "white" :weight bold))))
 '(sp-pair-overlay-face ((t (:weight bold))))
 '(sp-show-pair-enclosing ((t (:background "black" :weight bold))))
 '(sp-show-pair-match-face ((t (:background "#3f3f3f" :foreground "gold" :weight bold))))
 '(speedbar-highlight-face ((((class color) (background light)) (:background "#aaffaa"))))
 '(stripe-highlight ((t (:background "#333333"))))
 '(tooltip ((t (:inherit variable-pitch :background "lightyellow" :foreground "black" :weight extra-bold :height 0.7))))
 '(variable-pitch ((t (:height 1.1 :width normal :family "San Francisco"))))
 '(w3m-anchor ((t (:foreground "gray70" :underline t :weight bold))) t)
 '(w3m-arrived-anchor ((t (:foreground "gray60" :underline t :weight normal))) t)
 '(w3m-tab-selected-face ((((type x w32 mac) (class color)) (:inherit variable-pitch :background "Gray85" :foreground "black" :box (:line-width -1 :style released-button)))) t)
 '(w3m-tab-selected-retrieving-face ((((type x w32 mac) (class color)) (:inherit w3m-tab-selected-face :foreground "red"))) t)
 '(w3m-tab-unselected-face ((((type x w32 mac) (class color)) (:inherit w3m-tab-selected-face :foreground "Gray70"))) t)
 '(w3m-tab-unselected-retrieving-face ((((type x w32 mac) (class color)) (:inherit w3m-tab-unselected-face :foreground "#ffaaaa"))) t)
 '(whitespace-tab ((t (:background "LightSteelBlue4"))))
 '(whitespace-trailing ((t (:background "MistyRose4"))))
 '(widget-field ((((class grayscale color) (background light)) (:background "#b0f0a0")))))






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
 '(TeX-command-list
   '(("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     (#("LaTeX" 0 1
	(idx 1))
      "%`%l%(mode)%' %t" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     (#("BibTeX" 0 1
	(idx 2))
      "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
     (#("View" 0 1
	(idx 3))
      "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     (#("Print" 0 1
	(idx 4))
      "%p" TeX-run-command t t :help "Print the file")
     (#("Queue" 0 1
	(idx 5))
      "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     (#("File" 0 1
	(idx 6))
      "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
     (#("Index" 0 1
	(idx 7))
      "makeindex %s" TeX-run-command nil t :help "Create index file")
     (#("Check" 0 1
	(idx 8))
      "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     (#("Spell" 0 1
	(idx 9))
      "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     (#("Clean" 0 1
	(idx 10))
      "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     (#("Clean All" 0 1
	(idx 11))
      "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     (#("Other" 0 1
	(idx 12))
      "" TeX-run-command t t :help "Run an arbitrary command")))
 '(TeX-font-list
   '((98 "{\\bf " "}")
     (99 "{\\sc " "}")
     (101 "{\\em " "\\/}")
     (105 "{\\it " "\\/}")
     (114 "{\\rm " "}")
     (115 "{\\sl " "\\/}")
     (116 "{\\tt " "}")
     (100 "" "" t)))
 '(TeX-view-program-list '(("osx-open" ((output-pdf "open %o")))))
 '(TeX-view-program-selection
   '(((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "osx-open")
     (output-html "xdg-open")))
 '(ag-arguments '("--smart-case" "--stats" "--search-zip"))
 '(blink-matching-paren nil)
 '(calendar-date-style 'european)
 '(csv-align-style 'auto)
 '(cua-enable-cua-keys nil)
 '(cua-enable-cursor-indications nil)
 '(cua-enable-region-auto-help t)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "cdc7555f0b34ed32eb510be295b6b967526dd8060e5d04ff0dce719af789f8e5" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "f080eafb23304ce479fd2dd7fc4ea079c13f6cbbc812efb0f81cdecb7fdc850d" "82ea16d601b12a905c2927e8035581bb4f70a2f890033409cae7fbe30a1b5526" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" "fdaf58f82897097e57726ef42c8905416feab1b2be9449a44ca7bb039229a7ed" "146d24de1bb61ddfa64062c29b5ff57065552a7c4019bee5d869e938782dfc2a" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "b1471d88b39cad028bd621ae7ae1e8e3e3fca2c973f0dfe3fd6658c194a542ff" "cd70962b469931807533f5ab78293e901253f5eeb133a46c2965359f23bfb2ea" "a53714de04cd4fdb92ed711ae479f6a1d7d5f093880bfd161467c3f589725453" "16248150e4336572ff4aa21321015d37c3744a9eb243fbd1e934b594ff9cf394" "8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" "31bfef452bee11d19df790b82dea35a3b275142032e06c6ecdc98007bf12466c" "2f80d6ea18d147a6b4e5b54801317b7789531c691edecfa2ab0d2972bee6b36d" "216e6d0d3576e5c35785e68ca07b1c71f01ee4f3d80cb3b4da0ba55827bb3e5e" "d63e19a84fef5fa0341fa68814200749408ad4a321b6d9f30efc117aeaf68a2e" "427234e4b45350b4159575f1ac72860c32dce79bb57a29a196b9cfb9dd3554d9" "c5207e7b8cc960e08818b95c4b9a0c870d91db3eaf5959dd4eba09098b7f232b" "fc6e906a0e6ead5747ab2e7c5838166f7350b958d82e410257aeeb2820e8a07a" "4dacec7215677e4a258e4529fac06e0231f7cdd54e981d013d0d0ae0af63b0c8" "d7ea49a3541da1d2126ff82c5d785a91e1e4080d099deac4ae99a53be83480a5" "8bf124ada2acde39522584c4812cc3cc2aa755ba51aba1caa2906bbe0561876d" "1f8173499e6d20877e1bebe5dd38dd2d3fbabd639470fe167721310faf2d4176" "4dc62e151057bb86841266fbed96a8fe747526f4bffdd5a78f925636a6f97111" "dcf7981c260909e2c8ddf3a53c4e743d41dc7aee34672f716b950811ce452494" "24f5020c993255d839cfe4862abd1ca449bc08bb85b31b3b86e74e3a582157c4" "c44f55c9f3a1a22a04c79e8d9913cf253a636df001c38708959e1b088f66bbc6" "6ab401bc31eb56952f730431d5d170626a6473168ae3804993d7a3c6c63deccb" "94627767d7efa55450a01de9fc3f5dbdc2bbf5fefdb9e349d3104f73aa887983" "b9a15b6eeb68376185b844f79296bde16715f9dc7e2bf1086d53e84511257caa" "576582232148f332cc982731bea66111d2a5a62700b112a9571e7c5c3c3f986f" "b2c734313e61f23b7b098d92f76c1ab88f1f7b9e5b6abecb18f0d609c83b1164" "1318f8cbd4472f9bc8e7f8207db1c20416afd613a3d96ca8f240306acff18a97" "edeb867d8f2b9066ca06710934f3acd821c34a2e52236e8f5a0e80940f9b61bc" "3a23f53fd596e2519b3a192ec2a6dc6ffeacb6029be882132dd37c389325f00a" "b21f0693bcc8167ff9486a42a3d2cd167c53bcf2c57628f2843c7c664786bd67" "f92dcb95f019f51dba87fdabf1b1382b3ddfcd048f35fc9f555754c8331d38d8" "b6ae47764c75989bb5129de903d21fb7630eeabc559cd65cb30ee213bf6b1646" "93815fc47d9324a7761b56754bc46cd8b8544a60fca513e634dfa16b8c761400" default))
 '(debug-on-error t)
 '(default-input-method "spanish-prefix")
 '(diary-file "~/.emacs.d/diary")
 '(dired-omit-verbose nil)
 '(easy-kill-alist
   '((94 backward-line-edge "
")
     (36 forward-line-edge "
")
     (66 buffer "

")
     (60 buffer-before-point "

")
     (62 buffer-after-point "

")
     (70 string-up-to-char-forward "")
     (116 string-to-char-backward "")
     (84 string-up-to-char-backward "")
     (119 word " ")
     (115 sexp "
")
     (108 list "
")
     (102 filename "
")
     (100 defun "

")
     (68 defun-name " ")
     (101 line "
")
     (98 buffer-file-name nil)))
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-sane-defaults))
 '(elpy-syntax-check-command "black")
 '(fortune-dir "/usr/local/share/games/fortunes/")
 '(git-messenger:show-detail t)
 '(git-messenger:use-magit-popup t)
 '(line-spacing 4)
 '(magit-push-always-verify nil)
 '(org-agenda-files
   '("~/Dropbox/Teresa-Turtle/doc/teresa-turtle.org" "~/Work/Bowshocks/Jorge/bowshock-shape/Stellar-Bowshocks-2017/stellar-bowshocks.org" "~/Dropbox/Org/notes.org" "~/Dropbox/Notes/will-macbook-config.org" "~/Dropbox/Notes/workflow.org" "~/Dropbox/Notes/apple accounts.org" "~/Dropbox/Notes/paper projects 2015.org" "~/Dropbox/Org/pub-orion-atlas/index.org" "~/Dropbox/Family/Matthew-Money/matt-loan.org"))
 '(org-attach-directory "~/Dropbox/Org-Attach")
 '(org-attach-id-dir "~/Dropbox/Org-Attach")
 '(org-attach-method 'ln)
 '(org-bookmark-jump-indirect nil)
 '(org-clock-into-drawer "LOGBOOK")
 '(org-clock-string-limit 30)
 '(org-default-notes-file "~/Dropbox/Org/notes.org")
 '(org-display-internal-link-with-indirect-buffer t)
 '(org-emphasis-alist
   '(("*" bold "<b>" "</b>")
     ("/" italic "<i>" "</i>")
     ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
     ("=" org-code "<code>" "</code>" verbatim)
     ("~" org-verbatim "<code>" "</code>" verbatim)
     ("@" org-warning "<b>" "</b>")))
 '(org-export-babel-evaluate nil)
 '(org-export-backends '(ascii beamer html icalendar latex md org))
 '(org-export-dispatch-use-expert-ui t)
 '(org-export-use-babel nil)
 '(org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
 '(org-link-use-indirect-buffer-for-internals t)
 '(org-log-into-drawer t)
 '(org-mac-grab-Firefox-app-p nil)
 '(org-mac-grab-Mail-app-p nil)
 '(org-modules
   '(org-bbdb org-bibtex org-docview org-gnus org-id org-info org-inlinetask org-irc org-mhe org-protocol org-rmail))
 '(org-pretty-entities t)
 '(org-ref-completion-library 'org-ref-ivy-cite)
 '(org-ref-insert-cite-function 'org-ref-ivy-insert-cite-link)
 '(org-ref-insert-label-function 'org-ref-ivy-insert-label-link)
 '(org-ref-insert-link-function 'org-ref-insert-link)
 '(org-ref-insert-ref-function 'org-ref-ivy-insert-ref-link)
 '(org-special-ctrl-a/e t)
 '(org-special-ctrl-k t)
 '(org-startup-align-all-tables t)
 '(org-startup-indented t)
 '(org-tag-faces '(("noexport" . "#33bb44")))
 '(org-tags-column 50)
 '(package-selected-packages
   '(ox-gfm helpful ox-hugo org-roam org-sidebar org-ql map peg ov org-super-agenda ts ht exec-path-from-shell orgit edit-indirect magit-todos emacs-websocket jupyter org-ref ivy-prescient prescient python-docstring python-docstring-mode typo guess-language web-mode org-fstree org-dropbox header2 all-the-icons-ivy all-the-icons-dired all-the-icons counsel-projectile suggest e2wm org-extra org-contacts worf quelpa-use-package ag org-sticky-header ivy-hydra counsel mu4e org-pomodoro org-table-sticky-header org-edit-latex elfeed-org auto-org-md julia-mode zenburn-theme yaml-mode w3m virtualenv unfill undo-tree synonyms svg-mode-line-themes stripe-buffer spotlight sparkline smex smartparens smart-mode-line rainbow-mode projectile prodigy pinboard persistent-scratch paradox pallet org-trello org-plus-contrib org-magit org-dotemacs org-bullets org-bookmark-heading ob-ipython nose names multiple-cursors markdown-mode magithub magit-svn lispy latex-extra langtool key-chord idomenu ido-vertical-mode ibuffer-vc hungry-delete htmlize helm-dash helm-bibtex guide-key google-this golden-ratio god-mode gitty git-messenger git-gutter ggtags fuzzy fold-dwim-org flx-ido fancy-narrow expand-region esxml elpy elnode easy-kill-extras dired-details diminish deft csv-mode crosshairs creole-mode conda color-identifiers-mode bibslurp bf-mode auto-complete alert airplay ack-and-a-half achievements ace-jump-mode))
 '(paradox-automatically-star t)
 '(pinboard-url "http://feeds.pinboard.in/json/u:deprecated/?count=10")
 '(python-check-command "black")
 '(recentf-exclude
   '("/\\(\\(\\(COMMIT\\|NOTES\\|PULLREQ\\|TAG\\)_EDIT\\|MERGE_\\|\\)MSG\\|BRANCH_DESCRIPTION\\)\\'" "\\.cask"))
 '(recentf-max-menu-items 50)
 '(recentf-mode t)
 '(recentf-show-file-shortcuts-flag nil)
 '(rm-blacklist
   '(" hl-p" " Undo-Tree" " MRev" " Projectile" " Google" " Guide" " Helm" " Ind" " GG" " OCDL"))
 '(rm-excluded-modes
   '(" hl-p" " Undo-Tree" " MRev" " Projectile" " Google" " Guide" " Helm" " Ind" " GG" " OCDL"))
 '(safe-local-variable-values
   '((TeX-master . dusty-bow-wave)
     (eval when
	   (and
	    (buffer-file-name)
	    (file-regular-p
	     (buffer-file-name))
	    (string-match-p "^[^.]"
			    (buffer-file-name)))
	   (unless
	       (featurep 'package-build)
	     (let
		 ((load-path
		   (cons "../package-build" load-path)))
	       (require 'package-build)))
	   (package-build-minor-mode)
	   (set
	    (make-local-variable 'package-build-working-dir)
	    (expand-file-name "../working/"))
	   (set
	    (make-local-variable 'package-build-archive-dir)
	    (expand-file-name "../packages/"))
	   (set
	    (make-local-variable 'package-build-recipes-dir)
	    default-directory))
     (TeX-master . quadrics-bowshock)
     (eval add-hook 'find-file-hook
	   (lambda nil
	     (message "This file is part of ~/Dropbox/Referee tree"))
	   nil t)
     (encoding . utf-8)
     (wjh/elpy-virtual-environment . "~/anaconda/envs/py27")
     (eval pyvenv-deactivate)
     (eval quote
	   (pyvenv-activate
	    (expand-file-name "~/anaconda/envs/py27")))
     (eval pyvenv-activate
	   (expand-file-name "~/anaconda/envs/py27"))
     (lisp-backquote-indentation . t)
     (org-format-latex-options :foreground "black" :background "white" :matchers
			       '("begin")
			       :scale 1.0)
     (org-export-allow-bind-keywords . t)
     (eval font-lock-add-keywords nil
	   `((,(concat "("
		       (regexp-opt
			'("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl")
			t)
		       "\\_>")
	      1 'font-lock-variable-name-face)))
     (org-src-preserve-indentation . t)
     (org-use-property-inheritance . t)
     (system-time-locale . "en_GB.ISO8859-1")))
 '(show-paren-mode nil)
 '(shr-color-visible-distance-min 20)
 '(shr-color-visible-luminance-min 60)
 '(shr-use-fonts nil)
 '(use-dialog-box nil)
 '(visible-bell t))
