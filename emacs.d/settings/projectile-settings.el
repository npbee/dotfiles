(provide 'projectile-settings)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(add-to-list 'projectile-globally-ignored-directories "node_modules")
