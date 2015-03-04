;;; Code:

(require 'arduino-mode)

(add-hook 'arduino-mode-hook
	  #'(lambda()

;;; TODO
(global-flycheck-mode)
;; Flycheck checker for arduino projects.
(flycheck-define-checker arduino-checker
  ""
  :command ("make" "-f" "Arduino.mk" )
  :error-patterns
;;   ((error line-start (1+ nonl) ":" line ":" (message) line-end))
  ((error line-start (file-name) ":" line ":"
	  (message
	   (one-or-more not-newline)
	   (optional (optional "\r") "\n" (file-name) ":" (one-or-more (not (category digit)) ":"))
	   )
	  line-end)
   )
  :modes (arduino-mode))


	      (flycheck-select-checker 'arduino-checker)
	      (flycheck-mode)
	      (run-hooks 'c-mode-common-hook)
	      )
)

(setq ac-modes
      (append ac-modes '(arduino-mode)))


;;; 50_arduino-mode.el ends here
