
(deftheme wjh-org-misc
  "Miscellaneous tweaks to org-mode configuration")
(custom-theme-set-variables
 'wjh-org-misc
 '(org-disputed-keys (quote (([(control tab)] . [(control shift tab)]))))
 '(org-emphasis-alist (quote (("*" bold "<b>" "</b>") ("/" italic "<i>" "</i>") ("_" underline "<span style=\"text-decoration:underline;\">" "</span>") ("=" org-code "<code>" "</code>" verbatim) ("~" org-verbatim "<code>" "</code>" verbatim) ("@" org-warning "<b>" "</b>"))))
 '(org-enforce-todo-dependencies t)
 '(org-export-latex-packages-alist (quote (("" "siunitx" t))))
 '(org-log-into-drawer t)
 '(org-replace-disputed-keys t)
 )
(provide-theme 'wjh-org-misc)
