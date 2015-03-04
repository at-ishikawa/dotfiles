;;; history.el --- History class by eieio

;; Copyright (C) 2014

;;; Code:

(require 'eieio)
(require 'lisp-util)
(require 'file-util)

(defclass History ()
  ((variable :initarg :variable
	     :initform nil
	     :type symbol)
   (file-path :initarg :file-path
	      :type string
	      :custom string
	      :documentation "The file path of a history file.")
   (duration :initarg :duration
	     :initform 600
	     :type integer
	     :custom integer
	     :documentation "Each time in which the history file is stored.")
   (size :initarg :size
	 :initform 100
	 :type integer
	 :custom integer
	 :documentation "The number of the elements of the list."))
  "A history object for a variable"
  )

(defmethod history-save-history ((instance History))
  (let ((history (eval (oref instance variable)))
	)
    (write-string-to-file
     (concat "(setq "
	     (symbol-name (oref instance variable))
	     " '(\""
	     (join "\" \""
		   (reverse (sublist
			     (reverse history)
			     (oref instance size))))
	     "\"))")
     (oref instance file-path)
     )
    ) ; end let
  )

(defmethod history-init ((instance History))
  (let ((command-history-file (oref instance file-path)))
    (if (file-exists-p command-history-file)
	(load command-history-file)
      )) ; end let
  (run-with-idle-timer
   (oref instance duration)
   t
   #'(lambda(instance)
      (history-save-history instance))
   instance)
  )

(provide 'history)
;;; history.el ends here
