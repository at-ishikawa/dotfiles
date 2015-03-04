(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-?") 'help-command)
(global-set-key "\C-h" 'delete-backward-char)
;; smart-compile
(global-set-key "\C-cc" 'smart-compile)
(global-set-key "\C-c\C-s" 'sr-speedbar-toggle)

;; Helm
(global-set-keys
 ;;(,(kbd "C-r")   helm-for-files)
 ((kbd "C-^") 'helm-c-apropos)
 ((kbd "C-;") 'helm-resume)
 ((kbd "M-s") 'helm-occur)
;;  ((kbd "M-x") 'helm-M-x)
 ;;  ((kbd "C-x C-f") 'helm-find-files)
 ;;  ((kbd "C-x b") 'hew-kill-ring)
 ((kbd "M-y") 'helm-show-kill-ring)
 ((kbd "M-z") 'helm-do-grep)
 ;;(,(kbd "C-S-h") helm-descbinds)
 ;;	 ("\C-x\C-f" helm-find-file)
 ("\C-c\C-r" 'helm-recentf)
 ("\C-c\C-y" 'helm-c-yas-complete)
 )
(add-hook 'helm-after-initialize-hook
	  #'(lambda()
	      (define-key helm-map (kbd "C-k") 'kill-line)
	      (define-key shell-mode-map "\C-c\C-r" 'helm-recentf)
	      ;; 2013/09/16
	      ;; (define-key sh-mode-map "\C-c\C-r" 'helm-recentf)
	      ))
(eval-after-load "sh-script"
  '(progn
     (define-key sh-mode-map "\C-c\C-r" 'helm-recentf)
     ))

;; smartrep
(require 'smartrep) ; (require 'smartrep-autoloads)
(declare-function smartrep-define-key "smartrep")
(let ((window-operation-alist '(("C-j" . 'windmove-down)
				("C-k" . 'windmove-up)
				("C-h" . 'windmove-left)
				("C-l" . 'windmove-right)
				("o" . 'other-window)
				("O" . '(lambda() (other-window -1)))
				("0" . 'delete-window)
				("1" . 'delete-other-windows)
				("2" . 'split-window-below)
				("3" . 'split-window-right)))
      )
  (smartrep-define-key global-map
      "C-x 4" window-operation-alist)
  (smartrep-define-key global-map
      "C-x" window-operation-alist)
  )
(let ((window-operation-alist '(("o" . 'other-frame)
				("0" . 'delete-frame)
				("1" . 'delete-other-frame)))
      )
  (smartrep-define-key global-map
      "C-x 5" window-operation-alist)
  )

;; Org mode
(add-hook 'org-mode-hook
	  #'(lambda()
	      (define-keys org-mode-map
		("\C-c\C-r" 'helm-recentf)
		) ; define-keys

	      ))
