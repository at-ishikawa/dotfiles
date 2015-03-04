;;; 20_auto-highlight-symbol.el ---                  -*- lexical-binding: t; -*-

;;; Code:

(add-hook 'prog-mode-hook
	  '(lambda()
	     (global-auto-highlight-symbol-mode t)
	     ))
