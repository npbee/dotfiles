(provide 'key-bindings)

(defun my-shell-command-on-current-file (command &optional output-buffer error-buffer)
  "Run a shell command on the current file (or marked dired files).
In the shell command, the file(s) will be substituted wherever a '%' is."
  (interactive (list (read-from-minibuffer "Shell command: "
                                           nil nil nil 'shell-command-history)
                     current-prefix-arg
                     shell-command-default-error-buffer))
  (cond ((buffer-file-name)
         (setq command (replace-regexp-in-string "%" (buffer-file-name) command nil t)))
        ((and (equal major-mode 'dired-mode) (save-excursion (dired-move-to-filename)))
         (setq command (replace-regexp-in-string "%" (mapconcat 'identity (dired-get-marked-files) " ") command nil t))))
  (shell-command command output-buffer error-buffer))

(global-set-key (kbd "M-!") 'my-shell-command-on-current-file)
