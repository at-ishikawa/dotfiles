;; recentf files
(setq recentf-save-file (init-conf-path 'tmp "recentf")
      recentf-exclude '("tmp"
			"recentf")
      recentf-max-saved-items 500
      recentf-auto-cleanup 10)
(require 'recentf-ext)
(run-with-idle-timer 30 t 'recentf-save-list)
(recentf-load-list)
(recentf-mode t)
