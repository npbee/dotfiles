(provide 'appearance-settings)

;; Set the font face
(set-face-attribute 'default nil
		    :family "Essential PragmataPro"
		    :height 120)

;; Custom theme directory
(setq custom-theme-directory (concat user-emacs-directory "themes"))
