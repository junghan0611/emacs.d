(require 'package)
    (add-to-list 'package-archives '("elpa"      . "https://tromey.com/elpa/")            t)
    (add-to-list 'package-archives '("org"       . "http://orgmode.org/elpa/")            t)
    (add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/")  t)
    (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
    (package-initialize)
    (unless (and (package-installed-p 'delight)
                 (package-installed-p 'use-package))
        (package-refresh-contents)
        (package-install 'delight t)
        (package-install 'use-package t))
    (setq-default
        use-package-always-defer t
        use-package-always-ensure t)
(package-initialize)
(use-package org :ensure t
    :init (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
    :mode ("\\.org\\'" . org-mode)
    :config
    (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
    (evil-leader/set-key
        "o l" 'org-store-link
        "o a" 'org-agenda
        "o c" 'org-captur 
        "o b" 'org-iswitchb
    )
) 
(garbage-collect)
(put 'narrow-to-region 'disabled nil)
