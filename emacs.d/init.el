;;
;; INIT.EL
;;
;; This file is for setting other directories into the load path for emacs
;; and some other basic default stuff.
;; Most other stuff will live in a separate file or directory.
;; Pretty much stolen from https://github.com/magnars/.emacs.d/blob/master/init.el

;; Bring the 'settings' directory into the load path
(set 'settings-dir
      (expand-file-name "settings" user-emacs-directory))
(set 'spaceline-dir
      (expand-file-name "github/spaceline" user-emacs-directory))

(add-to-list 'load-path settings-dir)
(add-to-list 'load-path spaceline-dir)

;; DEFAULTS
(require 'default-settings)

;; APPEARANCE
(require 'appearance-settings)

;; EDITING
(require 'editing-settings)

;; PACKAGES
(require 'package-settings)

;; Key Bindings
(require 'key-bindings)


