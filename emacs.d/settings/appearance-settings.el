(provide 'appearance-settings)

;; Set the font face
(set-face-attribute 'default nil
		    :family "Essential PragmataPro"
		    :height 120)

;; Custom theme directory
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; show whitespace
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)
