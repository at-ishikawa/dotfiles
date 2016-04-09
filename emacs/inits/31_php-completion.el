(add-hook 'php-mode-hook
	  #'(lambda()
	      (require 'php-completion)
	      (php-completion-mode t)
	      (add-to-list 'ac-sources 'ac-source-php-completion)
	      )
	  )
