(require 'editorconfig)
(editorconfig-mode t)
(setq editorconfig-get-properties-function
    'editorconfig-core-get-properties-hash)
