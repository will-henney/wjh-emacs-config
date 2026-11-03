;; Make sure we use bash instead of fish
(setq shell-file-name (or (executable-find "bash") "/bin/sh")
      shell-command-switch "-lc")
