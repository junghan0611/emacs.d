;;; +snippet.el --- Summery
;;; -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package consult-yasnippet :defer t)

;; https://github.com/joaotavora/yasnippet
;; :custom (yas-snippet-dirs '("~/.emacs.d/yas/"))
(use-package yasnippet
  :defer t
  ;; :general (leader  "hy"  '(:wk "Yasnippet")
  ;;                   "hyl" 'consult-yasnippet)
  :config
  ;; (setq yas-snippet-dirs (concat user-emacs-directory "yas/"))
  (yas-global-mode t)
  ;; (yas-reload-all t)
  )

(use-package yasnippet-snippets :after yasnippet)

;; https://github.com/abo-abo/auto-yasnippet
(use-package auto-yasnippet
  :after yasnippet
  :general (leader "hyc" 'aya-create
                 "hye" 'aya-expand)
)

(provide '+snippet)
;;; +snippet.el ends here
