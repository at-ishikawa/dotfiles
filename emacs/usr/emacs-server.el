(require 'server)

(defcustom emacs-server-client-path nil
  "The path to the binary file of emacs client."
  )

;; define function to shutdown emacs server instance
(defun emacs-server-stop ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(defun emacs-server-run-client()
  (interactive)
  (start-process "emacs client" "*Emacs Client*"
		 emacs-server-client-path
		 "-c")
  ;;  (shell-command (expand-file-name "~/software/Emacs.app/Contents/MacOS/bin/emacsclient -c &"))
  )

(defun emacs-server-start()
  (interactive)
  (if (fboundp 'server-running-p)
      (unless (server-running-p)
	(server-start)
	;;  (toggle-fullscreen)
	;;  (make-frame-command)
	;;  (display-buffer-other-frame)
	;; (suspend-frame)
	)
    ) ; end if
  ) ; end emacs-server-start

(provide 'emacs-server)
