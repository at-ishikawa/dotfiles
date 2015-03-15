;; See www.emacswiki.org/emacs/RevertBuffer for more details.
;; revert-buffer without any confirmation
(defun reload-buffer ()
  "Revert buffer without confirmation."
  (interactive)
  (revert-buffer t t)
  )

;; Revert buffers when files are changed
(global-auto-revert-mode)

(setq inhibit-startup-message t)

(column-number-mode t)

;; for auto newline
(setq fill-column 80)

;; delete whitespaces of the end of each line before save.
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
