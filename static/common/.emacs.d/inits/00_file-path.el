;; init-conf-path
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

(defun init-add-subdirs-to-load-path (directory)
  "Add sub directories of the DIRECTORY to load-path."
  (let ((default-directory directory))
    (add-to-list 'load-path default-directory)
    ;; (normal-top-level-add-subdirs-to-load-path)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	(normal-top-level-add-subdirs-to-load-path))
    )
  )

;; Set a directory to store temporary files
(setq temporary-file-directory (concat user-emacs-directory "tmp/"))

(setq user-init-file (concat user-emacs-directory "init.el"))

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


