(require 'helm-config)
(lazyload nil 'helm-c-yas-complete "helm-c-yasnippet")

(helm-mode t)
(setq helm-idle-delay 0.1
      helm-input-idle-delay 0.1
      helm-candidate-number-limit 20
      helm-c-yas-space-match-any-greedy t)

;; Store a history file for commands.
(when (boundp 'extended-command-history)
  (defconst helm-command-history
    (History "HelmCommand"
	     :variable 'extended-command-history
	     :file-path (init-conf-path 'tmp "extended-command-history"))
    )
  (history-init helm-command-history)
  )
