;;
;; INIT.EL
;;

(set 'lib-dir
      (expand-file-name "lib" user-emacs-directory))
(add-to-list 'load-path lib-dir)

(require 'settings)
(require 'fn)
(require 'bindings)
(require 'packages)
