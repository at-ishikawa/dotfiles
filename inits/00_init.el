;; func
(defun init-add-subdirs-to-load-path (directory)
  "Add sub directories of the DIRECTORY to load-path."
  (let ((default-directory directory))
    (add-to-list 'load-path default-directory)
    ;; (normal-top-level-add-subdirs-to-load-path)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	(normal-top-level-add-subdirs-to-load-path))
    )
  )

(defun init-conf-path(type &rest files)
  "A path to a emacs directory or file for a configuration.
type must be one of 'tmp
"
  (if (or (eq type 'tmp) (eq type 'root))
      (concat (if (eq type 'tmp)
		  temporary-file-directory
		user-emacs-directory
		)
	      (join "/" files))
    (let* ((dir-name (cond ((eq type 'lisp) "site-lisp")
			   ((eq type 'user-lisp) "usr")
			   ((eq type 'init) "inits")
			   ((eq type 'bin) "bin")
			   ((eq type 'conf) "etc")
			   ((eq type 'info) "info")
			   ((eq type 'icon) "icons")
			   ((eq type 'private) "private")
			   (t nil)))
	   (path (if files
		     (join "/" files)
		   ""))
	   ) ; end let
      (if (not dir-name)
	  (error "There is no type.")
	(concat user-emacs-directory dir-name "/" path))
      )
    )
  )

;; Set a directory to store temporary files
(setq temporary-file-directory (concat user-emacs-directory "tmp/"))

(setq user-init-file (concat user-emacs-directory "init.el"))

;; Load environment variables
(require 'exec-path-from-shell)
(setq exec-path-from-shell-variables
      '("PATH"
	"MANPATH"
	"TEMPLATE_DIR"
	"USER_FULL_NAME"
	"USER_MAIL_ADDRESS"))
(exec-path-from-shell-initialize)

;; Show an error trace after init.
(setq debug-on-error t)

;; path
(init-add-subdirs-to-load-path (init-conf-path 'user-lisp))
(init-add-subdirs-to-load-path (init-conf-path 'lisp))

(require 'file-util)
(require 'lisp-util)
(require 'history)

;;; make a temporary directory if needed
(unless (file-exists-p temporary-file-directory)
  (make-directory temporary-file-directory))

;;; auto-save config
(let ((backup-directory (init-conf-path 'tmp "backup")))
  ;; make directory if necessary
  (unless (file-exists-p backup-directory)
    (make-directory backup-directory))

  ;; change auto-save-list directory in a temporary directory
  (setq backup-directory-alist `(("\\.*$" . ,backup-directory))
	auto-save-file-name-transforms `((".*" ,backup-directory t))
	auto-save-list-file-prefix (init-conf-path 'tmp "auto-save-list" ".saves-"))

  (message "Deleting old backup files...")

  ;; delete old auto-save-files
  (let ((month (* 60 60 24 7 4))
	(current (float-time (current-time))))
    (dolist (file (directory-files backup-directory t))
      (when (and (backup-file-name-p file)
		 (> (- current (float-time (nth 5 (file-attributes file))))
		    month))
	(message "%s" file)
	(delete-file file))))
  )

;; abbrev file name
(setq abbrev-file-name (init-conf-path 'conf "abbrev_defs.el"))

;; delete whitespaces of the end of each line before save.
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; Enable eval on a local file.
(setq enable-local-eval t)

;; Gradle
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.gradle$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("gradle" . groovy-mode))
