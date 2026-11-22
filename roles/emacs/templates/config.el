;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'leuven)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Fish isn't POSIX; Emacs subprocesses need a POSIX shell, terminals can keep fish.
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/usr/bin/fish")
(setq-default explicit-shell-file-name "/usr/bin/fish")

;; shell-mode only knows bash/ksh/zsh history files, so M-r, M-p and C-c C-l see
;; nothing from fish. Ask fish itself: its history file is not one-command-per-line.
(defun my/shell-load-fish-history-h ()
  (when (equal shell--start-prog "fish")
    (let ((cmds (with-temp-buffer
                  (call-process "fish" nil t nil "-c"
                                (format "builtin history search --null --max %d"
                                        comint-input-ring-size))
                  (split-string (buffer-string) "\0" t))))
      (setq comint-input-ring (make-ring comint-input-ring-size)
            comint-input-ring-index nil
            ;; Keep comint from ever writing its own format over fish_history.
            comint-input-ring-file-name nil)
      (dolist (cmd cmds)                ; fish lists newest first
        (ring-insert-at-beginning comint-input-ring cmd)))))
(add-hook 'shell-mode-hook #'my/shell-load-fish-history-h)

;; Markdown preview (SPC m p toggles grip-mode). Pin go-grip: it renders
;; locally, while the `grip' fallback uploads the file to the GitHub API.
;; Leave `grip-real-time-refresh' off; it writes FILE.md.temp.md beside the
;; file, which then shows up in git status.
(after! grip-mode
  (setq grip-command 'go-grip))

;; C-M-c replaces the default `exit-recursive-edit' binding; use C-] (abort-recursive-edit) instead.
(use-package! claude-code
  :bind-keymap ("C-M-c" . claude-code-command-map)
  :config
  (claude-code-mode)
  ;; Doom hides non-file buffers from SPC , and keeps them out of workspaces.
  (add-hook 'claude-code-start-hook
            (defun my/claude-code-show-in-workspace-h ()
              (doom-set-buffer-real (current-buffer) t)
              (when (bound-and-true-p persp-mode)
                (persp-add-buffer (current-buffer) (get-current-persp) nil nil))))
  (add-hook 'claude-code-start-hook
            (defun my/claude-code-mark-session-h ()
              (setq my/claude-session-p t)))
  ;; Frames opened by an emacsclient spawned from a Claude session carry its
  ;; CLAUDE_CODE_CHILD_SESSION marker, which turns off transcript saving.
  ;; A bare "VAR" entry unsets it; FORCE_SESSION_PERSISTENCE covers any other source.
  (add-hook 'claude-code-process-environment-functions
            (defun my/claude-code-keep-transcripts-env (_buffer-name _dir)
              '("CLAUDE_CODE_CHILD_SESSION"
                "CLAUDE_CODE_FORCE_SESSION_PERSISTENCE=1"))))

;; Claude sessions and plain shells are both eat buffers; group them separately
;; in a per-window tab-line, C-x <left>/<right> cycling, and C-x B narrowing.
(defvar-local my/claude-session-p nil
  "Set by `claude-code-start-hook'; keeps the group after the process exits.")

(defun my/claude-buffer-p (buf)
  "Non-nil if BUF is an eat terminal running claude (survives renaming)."
  (or (buffer-local-value 'my/claude-session-p buf)
      (when-let* ((proc (get-buffer-process buf)))
        (equal (car (last (process-command proc))) "claude"))))

(defun my/eat-group (claude)
  "Eat buffers that are (CLAUDE non-nil) or aren't Claude sessions, sorted by name."
  (sort (seq-filter (lambda (b)
                      (and (eq (buffer-local-value 'major-mode b) 'eat-mode)
                           (eq (and (my/claude-buffer-p b) t) claude)))
                    (buffer-list))
        (lambda (a b) (string< (buffer-name a) (buffer-name b)))))

(defun my/claude-buffers () (my/eat-group t))
(defun my/shell-buffers () (my/eat-group nil))

(defun my/eat-group-tabs ()
  (if (my/claude-buffer-p (current-buffer))
      (my/claude-buffers)
    (my/shell-buffers)))

(setq tab-line-switch-cycling t)
(add-hook 'eat-mode-hook
          (defun my/eat-group-tabs-h ()
            ;; Grouping is decided at redisplay: the process may not exist yet when this runs.
            (setq-local tab-line-tabs-function #'my/eat-group-tabs)
            (tab-line-mode 1)))

(after! eat
  (define-key eat-mode-map (kbd "C-x <right>") #'tab-line-switch-to-next-tab)
  (define-key eat-mode-map (kbd "C-x <left>")  #'tab-line-switch-to-prev-tab))

(after! consult
  (dolist (src `(("Claude" ?c ,#'my/claude-buffers)
                 ("Shell"  ?t ,#'my/shell-buffers)))
    (add-to-list 'consult-buffer-sources
                 (list :name (nth 0 src) :narrow (nth 1 src) :hidden t
                       :category 'buffer :state #'consult--buffer-state
                       :items (let ((f (nth 2 src)))
                                (lambda () (mapcar #'buffer-name (funcall f)))))
                 'append)))

;; Doom binds no multiple-cursors keys outside evil; these follow VS Code on Linux.
;; C-> stands in for VS Code's C-d, which Emacs keeps as delete-char. M-click replaces the secondary selection.
(defun my/mc-select-word-or-mark-next ()
  "Like VS Code's C-d (bound to C->): select the word first, then add the next match."
  (interactive)
  (if (region-active-p)
      (mc/mark-next-like-this 1)
    (mc--select-thing-at-point 'word)))

(defun my/mc-mark-all ()
  "Like VS Code's C-S-l: cursors on every match of the selection or word."
  (interactive)
  (unless (region-active-p)
    (mc--select-thing-at-point 'word))
  (mc/mark-all-like-this))

(after! multiple-cursors-core
  ;; Run these once; run for every cursor, each cursor adds its own cursor.
  (dolist (cmd '(my/mc-select-word-or-mark-next my/mc-mark-all
                 mc/mark-next-lines mc/mark-previous-lines))
    (add-to-list 'mc--default-cmds-to-run-once cmd))
  (define-key mc/keymap (kbd "<escape>") #'mc/keyboard-quit))

(global-unset-key (kbd "M-<down-mouse-1>"))
(map! "C->"        #'my/mc-select-word-or-mark-next
      "C-S-l"      #'my/mc-mark-all
      "M-S-<up>"   #'mc/mark-previous-lines
      "M-S-<down>" #'mc/mark-next-lines
      "C-S-<up>"   #'mc/mark-previous-lines
      "C-S-<down>" #'mc/mark-next-lines
      "M-I"        #'mc/edit-ends-of-lines
      "M-<mouse-1>" #'mc/add-cursor-on-click)

;; recentf.el has no autoload for it, and Doom loads recentf lazily.
(autoload 'recentf-open-files "recentf" nil t)
(map! "C-c C-r" #'recentf-open-files)

;; After C-x o, keep pressing o (O goes back); same for other repeatable keys.
(repeat-mode +1)

