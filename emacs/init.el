;;; init.el --- The initial loaded file for this user.  -*- lexical-binding: t; -*-
;;; Code:

;; package management
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

;; init-loader
(require 'init-loader)
(setq user-emacs-directory (file-name-directory load-file-name))
(init-loader-load (concat user-emacs-directory "inits"))


;;; init.el ends here
