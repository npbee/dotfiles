(provide 'auto-complete-settings)

(require 'auto-complete-config)

;; Set the dictionary location
(set 'ac-dict
     (expand-file-name "ac-dict" user-emacs-directory))
(add-to-list 'ac-dictionary-directories ac-dict)

(ac-config-default)
(global-auto-complete-mode t)

;; Use tab for auto complete
;; Snippets will use C-Tab
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

