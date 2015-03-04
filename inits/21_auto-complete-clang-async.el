;;; Code:

(require 'auto-complete-clang-async)
(setq ac-clang-complete-executable
      (init-conf-path 'bin "clang-complete"))
;; (init-get-conf-path 'lisp "auto-complete-clang-async" "clang-complete"))
(setq ac-sources '(ac-source-clang-async))
(setq ac-clang-cflags (append
		       (mapcar (lambda (path)(concat "-I" (expand-file-name path)))
			       (list
				"~/lib/boost_1_52_0/boost"
				)) ac-clang-cflags ))
(ac-clang-launch-completion-process)
;; The next line is to fix an error to jump to a error line after make,
;; but it does not work.
(setenv "LC_ALL" "C")



;;; 21_auto-complete-clang-async.el ends here
