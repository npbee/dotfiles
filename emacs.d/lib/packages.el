(provide 'packages)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


(use-package diminish
  :ensure t
  )
  

;; EVIL MODE
(use-package evil
  :ensure t
  :init
  (progn

    (use-package evil-leader
      :ensure t
      :init (global-evil-leader-mode)
      :config
      (progn
        (evil-leader/set-leader ",")
        (evil-leader/set-key
          "w" 'split-window-horizontally
          "a" 'helm-ag
          "g" 'magit-status)))

    (use-package evil-surround
      :ensure t
      :init (global-evil-surround-mode 1))

    (use-package evil-commentary
      :ensure t
      :init (evil-commentary-mode))

    (use-package key-chord
      :ensure t
      :init
      (progn
        (setq key-chord-two-keys-delay 0.5)
        (key-chord-mode 1))
      :config
      (progn
        (key-chord-define evil-insert-state-map "ii" 'evil-normal-state)))

    (evil-mode 1))
  :config
  (progn
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    (define-key evil-normal-state-map (kbd "-") 'dired-jump)))





;; HELM
(use-package helm
  :ensure t
  :init
  (progn

    (use-package helm-ag
      :ensure t)

    (use-package helm-projectile
      :ensure t)

    (helm-mode 1)))



;; PROJECTILE
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (progn
    (projectile-global-mode)
    (setq projectile-completion-system 'helm)
    (helm-projectile-on)))


;; MAGIT
(use-package magit
  :ensure t)


;; JS2 MODE
(use-package js2-mode
  :ensure t
  :init
  (progn
    (add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))
    ))


;; SNIPPETS
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand))


;; FLYCHECK
(use-package flycheck
  :diminish flycheck-mode
  :ensure t
  :init
  (global-flycheck-mode)
  (setq-default flycheck-disabled-checkers
                (append flycheck-disabled-checkers
                        '(javascript-jshint)))
  (flycheck-add-mode 'javascript-eslint 'js2-mode))


;; AUTOCOMPLETE
(use-package auto-complete
  :diminish auto-complete-mode
  :ensure t
  :init
  (require 'auto-complete-config)
  (set 'ac-dict
       (expand-file-name "ac-dict" user-emacs-directory))
  (add-to-list 'ac-dictionary-directories ac-dict)

  (ac-config-default)
  (global-auto-complete-mode t)
  :config

  ;; Use tab for auto complete
  ;; Snippets will use C-Tab
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>"))


;; SPACELINE
(use-package spaceline
  :ensure t
  :init
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))
