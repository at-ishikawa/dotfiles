;;; Code:

;; Uncompress a zip file by unzip.
(eval-after-load "dired-aux"
  '(add-to-list 'dired-compress-file-suffixes
		'("\\.zip\\'" ".zip" "unzip")))

;;; 10_dired-mode.el ends here
