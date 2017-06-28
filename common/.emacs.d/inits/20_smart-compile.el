;;; Code:

;; smart-compile
(require 'smart-compile)
(add-to-list 'smart-compile-alist
	     '(
	       ("\\.jj\\'" . "javacc %f")
	       ("\\.jjt\\'" . "jjtree %f")
	       ("\\.scala\\'" . "fsc %f && scala %n")
	       ))
;; (add-to-list 'smart-compile-alist local-smart-compile-alist)
(setq compilation-window-height 15)

(define-key menu-bar-tools-menu [compile] '("Compile..." . smart-compile))
