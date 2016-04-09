(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-hook 'web-mode-hook
	  #'(lambda()
	      (setq web-mode-markup-indent-offset 2)
	      (setq web-mode-css-indent-offset 2)
	      (setq web-mode-code-indent-offset 2)
	      ))

;; (setq web-mode-engine-file-regexps
;;      '(("django" . "\\.tpl\\'")))
