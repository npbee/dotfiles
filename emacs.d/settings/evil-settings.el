(provide 'evil-settings)
(require 'evil-leader)
(require 'evil)

;; Start with evil mode
(global-evil-leader-mode)
(evil-mode t)

;; Leader as comma
(evil-leader/set-leader ",")

;; Open a split window
(evil-leader/set-key "w" 'split-window-horizontally)

;; Buffer Movement
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

;; Map 'ii' to escape from insert mode
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "ii" 'evil-normal-state)
(key-chord-mode 1)


;; Vim Vinegar-style
(define-key evil-normal-state-map (kbd "-") 'dired-jump)
