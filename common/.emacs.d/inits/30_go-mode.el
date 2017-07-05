(when (lazyload nil '(go-mode)
        "go-mode" "Major mode for go lang" t)
  (add-hook 'go-mode-hook
    (lambda()
      (add-hook 'before-save-hook 'gofmt-before-save)
      )
    )

  ;; go get -u github.com/nsf/gocode is required for go-autocomplete
  (require 'go-autocomplete)
  )
