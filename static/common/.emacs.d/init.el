;; Comment out to debug Unnecessary call to a function 'package-initialize' in init file
;; https://emacs.stackexchange.com/questions/51603/i-see-unnecessary-call-to-package-initialize-in-init-file-but-cant-find-the
;; (debug-on-entry 'package-initialize)
;; Quick fix: https://github.com/cask/cask/issues/463#issuecomment-794249642
(setq warning-suppress-log-types '((package reinitialization)))

;; package manager cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t) ;; write installed packages into Cask

;; Fix $PATH environment variables
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; helm configurations
(require 'helm-config)
(helm-mode t) ;; enable helm buffers
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "\C-c\C-r") 'helm-recentf)

;; recentf
(require 'recentf-ext) ;; store directories
(run-at-time nil (* 5 60) 'recentf-save-list) ;; save every 5 minutes
(setq recentf-max-saved-items 500)

;; Company mode: auto completion
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (setq company-idle-delay 0.1)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (company-flx-mode t) ;; for fuzzy search
  (require 'company-terraform) ;; for terraform
  (company-terraform-init)
  )

;; flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)

;; smartrep
(require 'smartrep)
(declare-function smartrep-define-key "smartrep")
(smartrep-define-key global-map "C-x" '(("o" . 'other-window)))

;; file editing
(require 'terraform-mode)
(require 'editorconfig)

;; On Mac OS X
;; swap a command key with a alt key.
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; Appearance
(load-theme 'misterioso) ; load theme
(tool-bar-mode -1) ; Hide the tool bar
(add-hook 'before-save-hook 'delete-trailing-whitespace) ; delete spaces in the end of each line

;; stop creating those #auto-save# files
(setq auto-save-default nil)
;; stop emacs from creating .#lock file links
(setq create-lockfiles nil)
;; disable emacs's automatic backup~ file
(setq make-backup-files nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
;; reload changed contents on disk
(global-auto-revert-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(php-mode exec-path-from-shell flycheck company-flx company company-terraform cask-mode yaml-mode terraform-mode smartrep recentf-ext protobuf-mode pallet markdown-mode magit helm fish-mode editorconfig dockerfile-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
