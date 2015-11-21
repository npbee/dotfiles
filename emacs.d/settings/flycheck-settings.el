(provide 'flycheck-settings)

(require 'flycheck)

;; turn on flycheck globally
(add-hook 'after-init-hoot #'global-flycheck-mode)

;; disable jshint
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))

;; use eslint
(flycheck-add-mode 'javascript-eslint 'js-mode)
