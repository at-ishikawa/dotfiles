(load-theme 'misterioso)

;; Make the toolbar invisible
(tool-bar-mode -1)

;; Full screen 
(set-frame-parameter nil 'fullscreen 'maximized)

;; frame transparent mode
(defvar frame-current-transparency-mode nil)
(defvar frame-opaque-focused-alpha 100)
(defvar frame-opaque-unfocused-alpha 100)
(defvar frame-transparent-focused-alpha 85)
(defvar frame-transparent-unfocused-alpha 50)
(defun frame-transparency-mode ()
  (interactive)
  (let* ((elt (assoc 'alpha default-frame-alist))
	 (old (frame-parameter nil 'alpha))
	 (new (cond ((not (eq (car old) frame-transparent-focused-alpha))
		     `(,frame-transparent-focused-alpha
		       ,frame-transparent-unfocused-alpha))
		    (t
		     `(,frame-opaque-focused-alpha
		       ,frame-opaque-unfocused-alpha))
		    )))
    (if elt
	(setcdr elt new)
      (push `(alpha ,@new) default-frame-alist)
       )
    (set-frame-parameter nil 'alpha new)
    ))
(frame-transparency-mode)

