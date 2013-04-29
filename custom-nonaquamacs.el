(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "Courier Prime"))))
 '(TeX-fold-folded-face ((t (:foreground "cadet blue"))) t)
 '(ace-jump-face-background ((t (:foreground "gray60"))) t)
 '(ace-jump-face-foreground ((t (:foreground "orange"))) t)
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
 '(fixed-pitch ((t (:family "Source Code Pro"))))
 '(font-latex-sectioning-5-face ((t (:inherit monospace :foreground "IndianRed1" :weight bold))) t)
 '(font-latex-title-1-face ((t (:inherit font-latex-title-2-face :height 1.05))) t)
 '(font-latex-title-2-face ((t (:inherit font-latex-title-3-face :height 1.05))) t)
 '(font-latex-title-3-face ((t (:inherit font-latex-title-4-face :height 1.05))) t)
 '(font-lock-comment-face ((t (:foreground "ivory4" :slant italic))))
 '(font-lock-function-name-face ((t (:foreground "LightSkyBlue" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "SlateGray2"))))
 '(font-lock-string-face ((t (:foreground "pale goldenrod" :slant italic))))
 '(fringe ((t (:background "#4f4f4f" :foreground "gray50"))))
 '(highlight ((t (:background "coral4"))))
 '(link ((t (:foreground "light steel blue" :underline t))))
 '(minibuffer-prompt ((t (:foreground "LightBlue1"))))
 '(mode-line ((t (:background "#ddc4bf" :foreground "black" :box (:line-width 1 :color "DarkOrange4")))))
 '(mode-line-buffer-id ((t (:weight bold))))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey95" :foreground "grey40" :box (:line-width -1 :color "grey75") :weight light))))
 '(org-indent ((t (:stipple "" :underline "gray35"))) t)
 '(planner-completed-task-face ((t (:foreground "gray50" :strike-through t))) t)
 '(region ((t (:background "gold4" :foreground "#dcdccc"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:background "#fed"))))
 '(sh-heredoc ((t (:foreground "tan1"))))
 '(sh-heredoc-face ((t (:foreground "tan4"))) t)
 '(speedbar-highlight-face ((((class color) (background light)) (:background "#aaffaa"))))
 '(w3m-tab-selected-face ((((type x w32 mac) (class color)) (:inherit variable-pitch :background "Gray85" :foreground "black" :box (:line-width -1 :style released-button)))) t)
 '(w3m-tab-selected-retrieving-face ((((type x w32 mac) (class color)) (:inherit w3m-tab-selected-face :foreground "red"))) t)
 '(w3m-tab-unselected-face ((((type x w32 mac) (class color)) (:inherit w3m-tab-selected-face :foreground "Gray70"))) t)
 '(w3m-tab-unselected-retrieving-face ((((type x w32 mac) (class color)) (:inherit w3m-tab-unselected-face :foreground "#ffaaaa"))) t)
 '(widget-field ((((class grayscale color) (background light)) (:background "#b0f0a0")))))






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style (quote (("" "%(PDF)%(latex) -shell-escape %S%(PDFout)"))))
 '(TeX-command-list (quote (("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (plain-tex-mode texinfo-mode ams-tex-mode) :help "Run plain TeX") ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX") ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with Info output") ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil (texinfo-mode) :help "Run Makeinfo with HTML output") ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil (ams-tex-mode) :help "Run AMSTeX") ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt once") ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX nil (context-mode) :help "Run ConTeXt until completion") ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX") ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer") ("Print" "%p" TeX-run-command t t :help "Print the file") ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command) ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file") ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file") ("Check" "lacheck %s" TeX-run-compile nil (latex-mode) :help "Check LaTeX file for correctness") ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document") ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files") ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files") ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-view-program-list (quote (("osx-open" ((output-pdf "open %o"))))))
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "osx-open") (output-html "xdg-open"))))
 '(cua-enable-cua-keys nil)
 '(cua-enable-cursor-indications nil)
 '(cua-enable-region-auto-help t)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes (quote ("d7ea49a3541da1d2126ff82c5d785a91e1e4080d099deac4ae99a53be83480a5" "8bf124ada2acde39522584c4812cc3cc2aa755ba51aba1caa2906bbe0561876d" "1f8173499e6d20877e1bebe5dd38dd2d3fbabd639470fe167721310faf2d4176" "4dc62e151057bb86841266fbed96a8fe747526f4bffdd5a78f925636a6f97111" "dcf7981c260909e2c8ddf3a53c4e743d41dc7aee34672f716b950811ce452494" "24f5020c993255d839cfe4862abd1ca449bc08bb85b31b3b86e74e3a582157c4" "c44f55c9f3a1a22a04c79e8d9913cf253a636df001c38708959e1b088f66bbc6" "6ab401bc31eb56952f730431d5d170626a6473168ae3804993d7a3c6c63deccb" "94627767d7efa55450a01de9fc3f5dbdc2bbf5fefdb9e349d3104f73aa887983" "b9a15b6eeb68376185b844f79296bde16715f9dc7e2bf1086d53e84511257caa" "576582232148f332cc982731bea66111d2a5a62700b112a9571e7c5c3c3f986f" "b2c734313e61f23b7b098d92f76c1ab88f1f7b9e5b6abecb18f0d609c83b1164" "1318f8cbd4472f9bc8e7f8207db1c20416afd613a3d96ca8f240306acff18a97" "edeb867d8f2b9066ca06710934f3acd821c34a2e52236e8f5a0e80940f9b61bc" "3a23f53fd596e2519b3a192ec2a6dc6ffeacb6029be882132dd37c389325f00a" "b21f0693bcc8167ff9486a42a3d2cd167c53bcf2c57628f2843c7c664786bd67" "f92dcb95f019f51dba87fdabf1b1382b3ddfcd048f35fc9f555754c8331d38d8" "b6ae47764c75989bb5129de903d21fb7630eeabc559cd65cb30ee213bf6b1646" "93815fc47d9324a7761b56754bc46cd8b8544a60fca513e634dfa16b8c761400" default)))
 '(debug-on-error t)
 '(default-input-method "spanish-prefix")
 '(line-spacing 4)
 '(mac-command-modifier (quote super))
 '(mac-option-modifier (quote meta))
 '(org-agenda-files (quote ("~/Teaching/Tematicos/2013-enero/estelar-tematico-2013-enero.org")))
 '(org-clock-into-drawer "LOGBOOK")
 '(org-display-internal-link-with-indirect-buffer t)
 '(org-emphasis-alist (quote (("*" bold "<b>" "</b>") ("/" italic "<i>" "</i>") ("_" underline "<span style=\"text-decoration:underline;\">" "</span>") ("=" org-code "<code>" "</code>" verbatim) ("~" org-verbatim "<code>" "</code>" verbatim) ("@" org-warning "<b>" "</b>"))))
 '(org-export-babel-evaluate nil)
 '(org-id-link-to-org-use-id (quote create-if-interactive-and-no-custom-id))
 '(org-log-into-drawer t)
 '(org-mac-grab-Firefox-app-p nil)
 '(org-mac-grab-Mail-app-p nil)
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-id org-info org-inlinetask org-irc org-mhe org-protocol org-rmail)))
 '(org-pretty-entities t)
 '(org-startup-align-all-tables t)
 '(org-startup-indented t)
 '(recentf-mode t)
 '(safe-local-variable-values (quote ((org-use-property-inheritance . t) (system-time-locale . "en_GB.ISO8859-1"))))
 '(text-mode-hook nil)
 '(visible-bell t))
