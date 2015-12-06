(provide 'default-settings)

;; Kill the startup message
(setq inhibit-startup-message t)

;; Kill the toolbar and menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Keep emacs custom settings in a separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Always display line and column numbers
(global-linum-mode t)

;; Line width
(setq-default fill-column 80)

;; Set auto-fill mode for all major modes
(setq-default auto-fill-function 'do-auto-fill)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Tab width
(setq tab-width 4);

;; Show the parens
(show-paren-mode 1)
