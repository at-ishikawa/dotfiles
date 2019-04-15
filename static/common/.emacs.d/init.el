;;; init.el --- The initial loaded file for this user.  -*- lexical-binding: t; -*-
;;; Code:

;; package management

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; init-loader
(require 'init-loader)
(setq user-emacs-directory (file-name-directory load-file-name))
(init-loader-load (concat user-emacs-directory "inits"))

;;; init.el ends here