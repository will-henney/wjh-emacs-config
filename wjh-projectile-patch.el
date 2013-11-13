(defadvice projectile-current-project-dirs (around wjh-p-c-p-d)
  "Include top-level dir in `projectile-current-project-dirs'."
  (append '("./") ad-do-it))

(defun wjh-projectile-find-dir (&optional arg)
   "Jump to a project's directory using completion.

With a prefix ARG invalidates the cache first."
  (interactive "P")
  (if arg
      (projectile-find-dir arg)
    (projectile-find-dir nil)
    )
)

(provide 'wjh-projectile-patch)
