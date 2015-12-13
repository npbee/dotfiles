(deftheme circa-1985 "My own personal take on tomorrow-night-eighties")

(let ((base00 "#2d2d2d")
      (base01 "#393939")
      (base02 "#515151")
      (base03 "#747369")
      (base04 "#a09f93")
      (base05 "#d3d0c8")
      (base06 "#e8e6df")
      (base07 "#f2f0ec")
      (base08 "#F47678")
      (base09 "#FB9150")
      (base0A "#FFCD5D")
      (base0B "#98CD97")
      (base0C "#61CCCD")
      (base0D "#6498CE")
      (base0E "#CD98CD")
      (base0F "#D47B4E"))
  (custom-theme-set-faces
   'circa-1985
   ;; DEFAULT STUFF
   
   ;; Background and text
   `(default ((t (:background ,base01 :foreground ,base05))))
   `(border ((t (:background ,base03))))

   ;; Duh, the cursor
   `(cursor ((t (:background ,base08))))

   ;; The stuff between the line numbers and buffer
   `(fringe ((t (:background ,base02))))

   `(highlight ((t (:background ,base01))))

   `(link ((t (:foreground ,base0D))))
   `(link-visited ((t (:foreground ,base0E))))

   ;; Modeline background
   `(mode-line ((t (:background ,base02 :foreground ,base04 :box nil))))

   ;; Modeline buffer name
   `(mode-line-buffer-id ((t (:foreground ,base0E :background nil :weight
                                          bold))))
   
   `(minibuffer-prompt ((t (:foreground ,base0D))))

   `(region ((t (:background ,base02))))

   `(secondary-selection ((t (:background ,base03))))
   
   `(error ((t (:foreground ,base08 :weight bold))))
   `(warning ((t (:foreground ,base09 :weight bold))))
   `(success ((t (:foreground ,base0B :weight bold))))

   ;; FONT LOCK
   `(font-lock-builtin-face ((t (:foreground ,base0C))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,base02))))
   `(font-lock-comment-face ((t (:foreground ,base03))))
   `(font-lock-constant-face ((t (:foreground ,base09))))
   `(font-lock-doc-face ((t (:foreground ,base04))))
   `(font-lock-doc-string-face ((t (:foreground ,base03))))
   `(font-lock-function-name-face ((t (:foreground ,base0D))))
   `(font-lock-keyword-face ((t (:foreground ,base0E))))
   `(font-lock-negation-char-face ((t (:foreground ,base0B))))
   `(font-lock-preprocessor-face ((t (:foreground ,base0D))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,base0A))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,base0E))))
   `(font-lock-string-face ((t (:foreground ,base0B))))
   `(font-lock-type-face ((t (:foreground ,base0A))))
   `(font-lock-variable-name-face ((t (:foreground ,base0C))))
   `(font-lock-warning-face ((t (:foreground ,base08))))

   ;; linum-mode
   `(linum ((t (:background ,base01 :foreground ,base03))))

   ;; HELM
   `(helm-M-x-key ((t (:foreground ,base0C))))
   `(helm-action ((t (:foreground ,base05))))
   `(helm-buffer-directory ((t (:foreground ,base04 :background nil :weight bold))))
   `(helm-buffer-file ((t (:foreground ,base0C))))
   `(helm-buffer-not-saved ((t (:foreground ,base08))))
   `(helm-buffer-process ((t (:foreground ,base03))))
   `(helm-buffer-saved-out ((t (:foreground ,base0F))))
   `(helm-buffer-size ((t (:foreground ,base09))))
   `(helm-candidate-number ((t (:foreground ,base00 :background ,base09))))
   `(helm-ff-directory ((t (:foreground ,base04 :background nil :weight bold))))
   `(helm-ff-executable ((t (:foreground ,base0B))))
   `(helm-ff-file ((t (:foreground ,base0C))))
   `(helm-ff-invalid-symlink ((t (:foreground ,base00 :background ,base08))))
   `(helm-ff-prefix ((t (:foreground nil :background nil))))
   `(helm-ff-symlink ((t (:foreground ,base00 :background ,base0C))))
   `(helm-grep-cmd-line ((t (:foreground ,base0B))))
   `(helm-grep-file ((t (:foreground ,base0C))))
   `(helm-grep-finish ((t (:foreground ,base00 :background ,base09))))
   `(helm-grep-lineno ((t (:foreground ,base03))))
   `(helm-grep-match ((t (:foreground ,base0A))))
   `(helm-grep-running ((t (:foreground ,base09))))
   `(helm-header ((t (:foreground ,base0A :background ,base00 :underline nil))))
   `(helm-match ((t (:foreground ,base0A))))
   `(helm-moccur-buffer ((t (:foreground ,base0C))))
   `(helm-selection ((t (:foreground nil :background ,base02 :underline nil))))
   `(helm-selection-line ((t (:foreground nil :background ,base02))))
   `(helm-separator ((t (:foreground ,base02))))
   `(helm-source-header ((t (:foreground ,base05 :background ,base01 :weight bold))))
   `(helm-visible-mark ((t (:foreground ,base00 :background ,base0B))))

   
   ))


(provide-theme 'circa-1985)
