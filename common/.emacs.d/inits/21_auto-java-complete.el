;; ajc-java-complete
(when (lazyload #'(lambda()
;; 		   (setq ajc-tag-file-list
;; 			 (list
;; 			  (init-conf-path 'conf "ajc" "android.tag")
;; 			  (init-conf-path 'conf "ajc" "jdk.tag")
;; 			  ))
		   (setq ajc-method-table-cache-dir temporary-file-directory)
		   (local-set-key (kbd "C-c i") 'ajc-import-all-unimported-class)
		   (local-set-key (kbd "C-c m") 'ajc-import-class-under-point)
;;		   (local-set-key (kbd "C-x C-c r") 'ajc-reload)
		   )
		'(ajc-java-complete-mode ajc-4-jsp-find-file-hook) "ajc-java-complete-config" "Autoload auto-java-complete")
  (add-hook 'jsp-mode 'ajc-java-complete-mode)
  (add-hook 'java-mode-hook 'ajc-java-complete-mode)
  (add-hook 'find-file-hook 'ajc-4-jsp-find-file-hook)
  )
