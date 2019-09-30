(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-?") 'help-command)
(global-set-key "\C-h" 'delete-backward-char)

(global-set-key (kbd "<f5>") 'reload-buffer)
;; smart-compile
(global-set-key "\C-cc" 'smart-compile)

;; Helm
(global-set-keys
 ;;(,(kbd "C-r")   helm-for-files)
 ((kbd "C-;") 'helm-resume)
 ((kbd "M-s") 'helm-occur)
 ((kbd "M-x") 'helm-M-x)
 ((kbd "C-x C-f") 'helm-find-files)
 ((kbd "M-y") 'helm-show-kill-ring)
 ((kbd "M-z") 'helm-do-grep-ag)
 ((kbd "C-c C-g") 'helm-git-grep)
 ("\C-c\C-r" 'helm-recentf)
 ("\C-c\C-y" 'helm-c-yas-complete)
 )
(add-hook 'helm-after-initialize-hook
	  #'(lambda()
	      (define-key helm-map (kbd "C-k") 'kill-line)
	      ))
(eval-after-load "sh-script"
  '(progn
     (define-key sh-mode-map "\C-c\C-r" 'helm-recentf)
     ))

;; expand-region
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region)

;; smartrep
(require 'smartrep)
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


;; php mode
(add-hook 'php-mode-hook
	 #'(lambda()
	     (define-keys php-mode-map
	       ("\C-c\C-r" 'helm-recentf)
	       )
	     ))

;; Org mode
(add-hook 'org-mode-hook
	  #'(lambda()
	      (define-keys org-mode-map
		("\C-c\C-r" 'helm-recentf)
		) ; define-keys

	      ))

;; multiple cursor & region bindings
;; See http://tam5917.hatenablog.com/entry/20130129/1359465171 for more details (Japanese)
(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)
