;;; file-util.el --- The utility functions in order to operate files.
;; Keywords: file

;; Execute M-x update-directory-autoloads

;;;###autoload
(defun parent-directory(file-name)
  "Get the parent directory of a specified file."
  (let ((current-directory-name
	 (file-name-directory (expand-file-name file-name))))
    (if (or (equal current-directory-name "/")
	    (equal current-directory-name "//"))
	nil
      (expand-file-name (concat current-directory-name ".."))
      ) ; end if
    ) ; end let
  ) ; end defun

;;;###autoload
(defun write-string-to-file (string file)
  (interactive "sEnter the string: \nFFile to save to: ")
  (with-temp-buffer
    (insert string)
    (when (file-writable-p file)
      (write-region (point-min)
		    (point-max)
		    file)
      t)))

;; (defun get-file-in-parent (file-name)
;;   "Get the file in the above directories."
;;   (if (file-exists-p file-name)
;;       file-name
;;     (if (parent-directory file-name)
;; 	(get-file-in-parent (concat (parent-directory file-name)
;; 				    "/"
;; 				    (file-name-nondirectory file-name)))
;;       ) ; end if
;;     ) ; end if
;;   ) ; end defun
;; (make-obsolete 'get-file-in-parent 'locate-dominating-file "2013/06/15")


;; Open a file with an external program
;;;###autoload
(defun find-file-generic-mode (&optional generic-mode)
  (if generic-mode
      (ad-enable-advice 'find-file 'around 'find-file-generic)
    (ad-disable-advice 'find-file 'around 'find-file-generic)
    )
  (ad-activate 'find-file)
  ) ; end defun

(defcustom find-file-external-program-associations nil
  "An association list of find file for generic mode."
  )
;;   :type 'alist)

;;;###autoload
(defadvice find-file (around find-file-generic (file-name &optional wildcards) activate)
  (unless
      (memq t (mapcar #'(lambda(element)
			  (let* ((pattern (car element))
				 (command-name (car (cdr element)))
				 (command (concat command-name " " file-name " &"))
				 )
			    (when (string-match pattern file-name)
			      (recentf-add-file file-name)
			      (call-process-shell-command command nil 0)
			      t
			      )
			    ) ; end let
			  ) dired-guess-shell-alist-user) ; end mapcar
	    ) ; end memq
    ad-do-it ; do the original find-file
    ) ; end unless
  ) ; end defadvice

;;;###autoload
(defun read-string-from-file(file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

;;;###autoload
(defun read-lines-from-file(file)
  (split-string (read-string-from-file file) "\n" t))

(provide 'file-util)
