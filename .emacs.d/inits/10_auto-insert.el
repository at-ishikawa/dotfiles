;; auto insert
(defun init-auto-insert-template ()
  (time-stamp)
  (mapc #'(lambda(c)
	    (progn
	      (goto-char (point-min))
	      ;; replace-string is used for only interactive
	      ;; from to delimited start end
	      ;; (replace-string (car c) (funcall (cdr c)))))
	      (perform-replace (car c) (funcall (cdr c)) nil nil nil)))
	init-auto-insert-template-replacement-alists)
  (goto-char (point-max))
  (message "done."))

(when (lazyload
       #'(lambda()
	   ;; A directory for templates
	   ;; switch templates for each file
	   (setq auto-insert-directory (concat (getenv "TEMPLATE_DIR") "/")
		 auto-insert-query nil
		 auto-insert-alist
		 (nconc
		  (let* ((template-directory (getenv "TEMPLATE_DIR"))
			 (template-files (directory-files template-directory))
			 (template-file-name-sans-extension "default")
			 )
		    ;;   (mapcar 'file-name-extension template-files)
		    (delq nil
			  (mapcar '(lambda(file-name)
				     (let ((extension (file-name-extension file-name))
					   )
				       (if (string= template-file-name-sans-extension (file-name-sans-extension file-name))
					   ;; (let ((pattern (concat "\\." extension "$")))
					   `(,(concat "\\." extension "$") . [,file-name init-auto-insert-template])
					 (unless (file-directory-p (expand-file-name file-name template-directory))
					   `(,(concat (replace-regexp-in-string "\\." "\\\\." file-name) "$") . [,file-name init-auto-insert-template])
					   )
					 )
				       )
				     ) template-files)
			  )
		    ) ; end let
		  auto-insert-alist)
		 )
	   )
       'auto-insert "autoinsert" "Auto insert templates") ; end lazyload
  (add-hook 'find-file-not-found-hooks 'auto-insert)
  ) ; end when

