(require 'whitespace)

;; faceで可視化
;; trailing: 行末
;; tabs: タブ
;; spaces: スペース
;; empty: 先頭/末尾の空行
;; space-mark: 表示のマッピング
(setq whitespace-style
      '(face
        trailing
        tabs
        spaces
        empty
space-mark
tab-mark
))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))


;; Visualize only for full space
(setq whitespace-space-regexp "\\(\u3000+\\)")
(global-whitespace-mode t)
