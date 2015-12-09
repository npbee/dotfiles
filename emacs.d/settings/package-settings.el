(provide 'package-settings)
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))


;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(ensure-package-installed 'evil
                          'evil-leader
                          'evil-surround
                          'key-chord
                          'helm
                          'helm-ag
                          'projectile
                          'helm-projectile
                          'base16-theme
                          'yasnippet
                          'js2-mode
                          'flycheck
                          'auto-complete
                          'paredit
                          'magit
                          'diminish
                          )

;; Specific package settings
(require 'evil-settings)
(require 'helm-settings)
(require 'projectile-settings)
(require 'theme-settings)
(require 'snippet-settings)
(require 'js2-mode-settings)
(require 'flycheck-settings)
(require 'auto-complete-settings)
(require 'paredit-settings)
(require 'modeline-settings)
