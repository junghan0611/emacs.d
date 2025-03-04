;;; +lua.el --- Summery
;;; -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package lua-mode
    :ensure-system-package (luafmt . "npm install --global lua-fmt")
    :mode ("\\.lua\\'" . lua-mode)
    :hook (lua-mode . lsp-deferred)
    )

(provide '+lua)
;;; +lua.el ends here
