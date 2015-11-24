(provide 'paredit-settings)

(defun my-paredit-nonlisp()
  "turn on paredit mode for non lisps"
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimeter-predicates)
       '((lamda (endp delimiter) nil)))
  (paredit-mode 1))

;;(add-hook 'js2-mode-hook 'my-paredit-nonlisp)
