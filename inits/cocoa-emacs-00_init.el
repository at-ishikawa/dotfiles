(defcustom path-separator ":"
  "")

(setq dired-guess-shell-alist-user
      (append
       '(("\\.asta\\'" "open -n"))
       (mapcar #'(lambda(extension)
		   `(,extension "open")
		   )
	       '("\\.pdf\\'"
		 "\\.dmg\\'"
		 "\\.pkg\\'"
		 "\\.jpg$"
		 "\\.png$"
		 "\\.key$"
		 "\\.xlsx?$"
		 "\\.docx?$"
		 "\\.pptx?$"
		 "\\.odg$"
		 ))
       ))
