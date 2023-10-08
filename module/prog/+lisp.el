;;; +git.el --- Summery
;;; -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package emacs-lisp :no-require t :after general :elpaca nil
    :general (leader "le" '(eval-print-last-sexp :wk "Elisp Evaluate"))
    :hook (emacs-lisp-mode . (lambda () (setq format-all-formatters '(("Emacs Lisp")))))
    :config
    ;; Do not indent single ; comment characters
    (add-hook 'emacs-lisp-mode-hook (lambda () (setq-local comment-column 0)))
    )

(use-package scratch-comment
    :general (:keymaps 'lisp-interaction-mode-map "C-j" 'scratch-comment-eval-sexp)
    )

(use-package slime :disabled
    :commands slime
    :config
    (setq inferior-lisp-program (or (executable-find "sbcl")
                                    (executable-find "/usr/bin/sbcl")
                                    (executable-find "/usr/sbin/sbcl" )))
    (require 'slime-autoloads)
    (slime-setup '(slime-fancy))
    )

(use-package elisp-slime-nav :diminish elisp-slime-nav-mode
    :hook ((emacs-lisp-mode ielm-mode) . elisp-slime-nav-mode)
    )

(use-package prettify-symbols :no-require t :elpaca nil
    :hook ((emacs-lisp-mode lisp-mode org-mode) . prettify-symbols-mode)
    )

;;; clojure

(use-package clojure-mode)

(use-package cider)

;; (use-package clojure-mode :elpaca nil
;;   :general (leader "le" '(eval-print-last-sexp :wk "Elisp Evaluate"))
;;   :hook (emacs-lisp-mode . (lambda () (setq format-all-formatters '(("Emacs Lisp")))))
;;   :mode (("\\.cljs\\'" . clojurescript-mode)
;;          ("\\.\\(clj\\|dtm\\|edn\\)\\'" . clojure-mode)
;;          ("\\.cljc\\'" . clojurec-mode)
;;          ("\\(?:build\\|profile\\)\\.boot\\'" . clojure-mode))
;;   :config
;;   (require 'cider)
;;   ;; (require 'flycheck)
;;   ;; (require 'flycheck-clj-kondo)
;;   ;; (require 'clojure-mode-extra-font-locking)
;;   ;;(add-hook 'cider-repl-mode-hook #'company-mode)
;;   ;;(add-hook 'cider-mode-hook #'company-mode)
;;   (add-hook 'clojure-mode-hook #'cider-mode)
;;   ;;(add-hook 'clojure-mode-hook #'clj-refactor-mode)
;;   (add-hook 'clojurec-mode-hook #'cider-mode)
;;   ;;(add-hook 'clojurec-mode-hook #'clj-refactor-mode)
;;   (add-hook 'clojurescript-mode-hook #'cider-mode)
;;   ;;(add-hook 'clojurescript-mode-hook #'clj-refactor-mode)
;;   )

;; (use-package cider
;;   :functions tramp-dissect-file-name
;;   :custom ((cider-clojure-cli-command "clojure")
;;            (nrepl-use-ssh-fallback-for-remote-hosts t)
;;            (nrepl-sync-request-timeout 100))
;;   :config
;;   ;;(setq cider-interactive-eval-output-destination 'output-buffer)
;;   (defun nrepl--ssh-tunnel-command (ssh dir port)
;;     "Command string to open SSH tunnel to the host associated with DIR's PORT."
;;     (with-parsed-tramp-file-name dir v
;;       ;; this abuses the -v option for ssh to get output when the port
;;       ;; forwarding is set up, which is used to synchronise on, so that
;;       ;; the port forwarding is up when we try to connect.
;;       (format-spec
;;        "%s -v -N -L %p:localhost:%p %u'%h' %x"
;;        `((?s . ,ssh)
;;          (?p . ,port)
;;          (?h . ,v-host)
;;          (?u . ,(if v-user (format "-l '%s' " v-user) ""))
;;          (?x . "-o \"ProxyCommand=nc -X connect -x 127.0.0.1:1080 %h %p\""))))))

;; (use-package ob-clojure
;;   :ensure org
;;   :custom (org-babel-clojure-backend 'cider)
;;   :config
;;   (add-to-list 'org-src-lang-modes '("clojure" . clojure)))

(provide '+lisp)
;;; +lisp.el ends here
