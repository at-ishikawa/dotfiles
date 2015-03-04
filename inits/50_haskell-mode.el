;;; Code:

(when (lazyload nil '(haskell-mode literate-haskell-mode)
		"haskell-mode" "Major mode for editing Haskell scripts." t)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

  ;;; ghc-mod
  ;; See http://d.hatena.ne.jp/kitokitoki/20111217/p1 for more details
  (when (lazyload nil 'ghc-init "ghc" nil t)

    (add-hook 'haskell-mode-hook 'ghc-init)

    ;; auto complete
    (defun my-ac-haskell-mode ()
      (setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod)))
    (add-hook 'haskell-mode-hook 'my-ac-haskell-mode)

    (defun my-haskell-ac-init ()
      (when (member (file-name-extension buffer-file-name) '("hs" "lhs"))
	(auto-complete-mode t)
	(setq ac-sources '(ac-source-words-in-same-mode-buffers ac-source-dictionary ac-source-ghc-mod))))

    (add-hook 'find-file-hook 'my-haskell-ac-init)

    ;;  (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
    (ac-define-source ghc-mod
      '((depends ghc)
	(candidates . (ghc-select-completion-symbol))
	(symbol . "s")
	(cache)))
    )

  )
;;; 50_haskell-mode.el ends here
