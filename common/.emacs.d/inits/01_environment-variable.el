;; Load environment variables
(require 'exec-path-from-shell)
(setq exec-path-from-shell-variables
      '("PATH"
	"MANPATH"
	"TEMPLATE_DIR"
	"USER_FULL_NAME"
	"USER_MAIL_ADDRESS"))
(exec-path-from-shell-initialize)

