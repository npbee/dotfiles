(provide 'appearance-settings)

;; Set the font face
(set-face-attribute 'default nil
		    :family "Essential PragmataPro"
		    :height 120)

;; Custom theme directory
(setq custom-theme-directory (concat user-emacs-directory "themes"))


;; show whitespace
(autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization." t)
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)
