;; TODO lazyload
(when (require 'yasnippet nil t)
  (add-to-list 'yas-snippet-dirs
	       (init-conf-path 'conf "snippets"))
  (yas-initialize)
  )
