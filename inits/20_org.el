
(add-list-to-list '(
		    ("\\.txt$" . org-mode)
		) auto-mode-alist)
(setq org-log-done 'time)

(setq org-directory (expand-file-name "~/share/Dropbox/schedule"))
(setq org-agenda-files (list org-directory))
(setq diary-file (concat org-directory "/diary"))
(setq org-agenda-include-diary t)

(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "CANCELED(c)" "DONE(d)"))
      org-todo-keyword-faces '(
			       ("DONE" . (:foreground "green"))
			       ("WAIT" . shadow)
			       ("CANCELED" . (:foreground "blue"))
			       )
      ) ; end setq

(setq org-export-html-validation-link nil)
