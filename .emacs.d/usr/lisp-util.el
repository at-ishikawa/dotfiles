;;; lisp-util.el --- The utility functions for Emacs lisp.
;; Keywords: lisp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; List operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;###autoload
(defun empty (var)
  (not var))

;;;###autoload
(defun sublist(list size)
  "Get a list whose size is SIZE from the first SIZE number of the LIST."
  (if (<= (length list) size)
      list
    (sublist (cdr list) size)
    )) ; end sublist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; String operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;###autoload
(defun trim (str)
  "trim the whitespace of the head and tail from a STR."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'" str)
    (setq str (replace-match "" t t str)))
  str)

;;;###autoload
(defun join (separator list)
  "Concatenate the LIST and get the string which inserts the SEPARATOR between each element of the LIST"
  (mapconcat 'identity list separator)
  ) ; end join

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Operations for configurations of the system
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; See http://hke7.wordpress.com/2011/11/15/define-key-%E3%82%84-global-set-key-%E3%82%92%E3%81%BE%E3%81%A8%E3%82%81%E3%82%8B/ in more details. (Japanese)

;;;###autoload
(defmacro define-keys (mode-map &rest body)
  "Configure some keys for mode-map simultanously.

;; Before use this
(define-key any-mode-map (kbd \"C-x\") 'any-function)
(define-key any-mode-map (kbd \"M-a\") 'hoge-function)

;; After use this
(define-keys any-mode-map
  ((kbd \"C-x\") 'any-function)
  ((kbd \"M-a\") 'hoge-function))
"
  `(progn
     ,@(mapcar #'(lambda (arg)
                   `(define-key ,mode-map ,@arg)) body)))

;;;###autoload
(defmacro global-set-keys (&rest body)
  "Configure some `global-set-key' at the same time.
See `define-keys' in more details."
  `(progn
     ,@(mapcar #'(lambda (arg)
                   `(global-set-key ,@arg)) body)))

;;;###autoload
(defun add-list-to-environment (list environment-variable-name)
  "An environment variable is the string, so join the LIST into the environment variable"
  (setenv environment-variable-name
	  (join path-separator
		(append list (list (getenv environment-variable-name))))))

;;;###autoload
(defmacro add-list-to-list (elements dst)
  `(setq ,dst (append ,elements ,dst)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Library operations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; See autoload-if-found in http://d.hatena.ne.jp/jimo1001/20090921/1253525484 (Japanese).
(defun autoload-if-found (functions file &optional docstring interactive type)
  "autoload iff FILE was found.
FUNCTIONS can be either the symbol of a function or the list of the symbols of functions."
  (if (not (locate-library file))
      (message (concat "Cannot load a file: " file))
    (if (not (listp functions))
	(setq functions (list functions)))
    (mapc #'(lambda(f) (autoload f file docstring interactive type)) functions)
    t))
;;    (dolist (function functions)
;;      (autoload function file docstring interactive type))
;;    t)) ; end defun autoload-if-found

;; AFTER cannot be binded after loading a file,
;; so we need to make the LAZYLOAD function as a macro.
;; See http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html in more details (Japanese).
;;;###autoload
(defmacro lazyload (after functions file &optional docstring interactive type)
  `(when (autoload-if-found ,functions ,file ,docstring ,interactive ,type)
     (when ,after
       (eval-after-load ,file
	 '(funcall ,after)
	 )) ; end eval-after-load
     t))
;; (defun lazyload (before after functions file
;; 			   &optional docstring interactive type)
;;   "Autoload and evaluates function"
;;   (when (autoload-if-found functions file docstring interactive type)
;;     (when before
;;       (funcall before))
;;     (when after
;;       (eval-after-load file
;; 	'(progn
;; 	   (funcall after))
;; 	)) ; end eval-after-load
;;     t))

(defcustom slow-loading-time 100
  "The time which is considered to be slow for loading a file."
  :type 'integerp
  ) ; end defcustom

(defmacro process-time(func)
  `(let* ((before (current-time))
	  (funcall ,func)
	  (after (current-time))
	  (time (+ (* (- (nth 1 after) (nth 1 before)) 1000)
		   (/ (- (nth 2 after) (nth 2 before)) 1000))))
     time
     ) ; end let
  ) ; end defmacro

(provide 'lisp-util)
