(provide 'js2-mode-settings)

;; Always use js2-mode for .js files
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
