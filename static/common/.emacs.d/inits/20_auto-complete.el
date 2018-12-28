;; Show candidates by popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)

;;; auto-complete
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
	       (concat (init-conf-path 'lisp) "/ac-dict"))
  (ac-config-default)
;;  (setq ac-quick-help t)
  (setq ac-quick-help-delay 0.8)
  (setq ac-use-menu-map t) ; can select candidates by C-n/C-p
  ;; (setq ac-auto-start 0.5)
  (setq ac-modes
  	(append ac-modes '(js2-mode
   			   ;; malabar-mode
   			   nxml-mode
   			   sql-mode
			   text-mode
			   org-mode)))
  (setq ac-comphist-file (concat temporary-file-directory "/ac-comphist.dat"))
  (ac-flyspell-workaround) ; To avoid delay with flyspell together.
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  ;; (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  )
