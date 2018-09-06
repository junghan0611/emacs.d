;;; init.el --- initialization emacs
;;; Commentry:
;;; emacs init file 
;;; Code:
(package-initialize)

(load "~/.emacs.d/lisp/emacs-options.el")
(load "~/.emacs.d/lisp/tab.el")
(load "~/.emacs.d/lisp/toggle.el")

;;auto install packages
(load "~/.emacs.d/lisp/use-package.el")

(use-package which-key :ensure t :init (which-key-mode t) :config (which-key-enable-god-mode-support t))
;;test (use-package god-mode  :ensure t :init (god-mode-all))

;; vim key map load
(load "~/.emacs.d/lisp/evil.el")
;; linum setting load
(load "~/.emacs.d/lisp/linum/linum.el")
;; themes    
(load "~/.emacs.d/lisp/themes.el")

(use-package all-the-icons :ensure t)
(load "~/.emacs.d/lisp/neotree.el")
(load "~/.emacs.d/lisp/spaceline.el")

(load "~/.emacs.d/lisp/paren.el")

(use-package multi-term
    :ensure t
    :init 
        (add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil) ))
        (add-hook 'term-mode-hook (lambda () (setq term-buffer-maximum-size 10000)))
        (add-hook 'term-mode-hook (lambda () (linum-mode nil)))
    :config 
        (setq multi-term-program "/bin/zsh")
        (evil-leader/set-key "t" 'multi-term)
)

(use-package ace-window
    :ensure t
;    :bind ("C-x o" . ace-window) 
    :config 
    (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8))
    (evil-leader/set-key "wo" 'ace-window)
)

(use-package eyebrowse
    :ensure t
    :init
        (eyebrowse-mode t)
    :config 
        (evil-leader/set-key
            "w;" 'eyebrowse-last-window-config
            "w0" 'eyebrowse-close-window-config
            "w1" 'eyebrowse-switch-to-window-config-1
            "w2" 'eyebrowse-switch-to-window-config-2
            "w3" 'eyebrowse-switch-to-window-config-3
        )
)

(use-package iedit :ensure t)
(use-package evil-multiedit :ensure t)

(use-package org :ensure t
  :init
  (add-to-list 'auto-mode-alist '("'\\.org\\'" . org-mode))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
  (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
  (evil-leader/set-key
    "o l" 'org-store-link
    "o a" 'org-agenda
    "o c" 'org-captur 
    "o b" 'org-iswitchb
  )
)
;(use-package whitespace
;    :ensure t
;    :init
;        (setq whitespace-style '(tab-mark space))
;        (global-whitespace-mode)
;)

(use-package git-gutter
  :ensure t
  :init  (global-git-gutter-mode t)
  :config
    (setq git-gutter:lighter " gg")
    (setq git-gutter:window-width 1)
    (setq git-gutter:modified-sign ".")
    (setq git-gutter:added-sign "+")
    (setq git-gutter:deleted-sign "-")
    (set-face-foreground 'git-gutter:added "#daefa3")
    (set-face-foreground 'git-gutter:deleted "#FA8072")
    (set-face-foreground 'git-gutter:modified "#b18cce")
)

;(use-package prodigy
;    :ensure t
;    :config (evil-leader/set-key "C-p" 'prodigy)
;)

(use-package magit
    :ensure t
    :diminish auto-revert-mode
    :init
    (setq vc-handled-backends nil)
    :config
        (evil-leader/set-key "g s" 'magit-status)
)

; color code background color set
(use-package rainbow-mode
    :ensure t
    :init
        (add-hook 'html-mode-hook       'rainbow-mode)
        (add-hook 'css-mode-hook        'rainbow-mode)
        (add-hook 'c++-mode-hook        'rainbow-mode)
        (add-hook 'c-mode-hook          'rainbow-mode)
        (add-hook 'lisp-mode-hook       'rainbow-mode)
        (add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
)


(use-package projectile
    :defer t
    :ensure t
    :init
        (projectile-mode t)
    :config
        (evil-leader/set-key "p" 'projectile-command-map)
)

;; auto complite mode road
(use-package company :ensure t
    :init (add-hook 'after-init-hook 'global-company-mode)
    :config
        (setq company-idle-delay   0)
        (setq company-minimum-prefix-length 1)
        (setq company-show-numbers t)
        (define-key company-active-map (kbd "M-n") 0)
        (define-key company-active-map (kbd "M-p") 0)
        (define-key company-active-map (kbd "C-n") 'company-select-next)
        (define-key company-active-map (kbd "C-p") 'company-select-previous)
        (use-package company-c-headers
            :ensure t
            :init (add-to-list 'company-backends 'company-c-headers)
        )
)

;(use-package rtags :ensure t)


(use-package flycheck
    :ensure t
    :init   (global-flycheck-mode t)
)

(use-package flycheck-pos-tip
    :ensure t
    :config
    (with-eval-after-load 'flycheck (flycheck-pos-tip-mode))
)

(use-package irony
    :ensure t
    :init
        (add-hook    'c++-mode-hook        'irony-mode)
        (add-hook    'c-mode-hook          'irony-mode)
    :config
    (progn
        (use-package company-irony
            :ensure t
            :config
                (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))
                (add-hook    'irony-mode-hook      'irony-cdb-autosetup-compile-options)
        )
        (use-package flycheck-irony
            :ensure t
            :config (eval-after-load 'flycheck #'flycheck-irony-setup)
        )
        (use-package company-irony-c-headers
            :ensure t
            :init
                (eval-after-load 'company '(add-to-list 'company-backends '(company-irony-c-headers)))
        )
        (use-package clang-format
            :ensure t
            :config (global-set-key [C-M-tab] 'clang-format-regieon)
        )
    )
)

(with-eval-after-load 'company
    (add-hook 'c++-mode-hook 'company-mode)
    (add-hook 'emacs-lisp-mode-hook 'company-mode)
    (add-hook 'lisp-mode-hook 'company-mode)
)

(use-package cmake-ide
    :ensure t
    :init (cmake-ide-setup)
)

(use-package flyspell
    :ensure t
    :init
    (progn
        (add-hook 'prog-mode-hook       'flyspell-prog-mode)
        (add-hook 'text-mode-hook       'flyspell-mode-hook)
        (add-hook 'c-mode-hook          'flyspell-mode-hook)
        (add-hook 'yaml-mode-hook       'flyspell-mode-hook)
        (add-hook 'lisp-mode-hook       'flyspell-mode-hook)
        (add-hook 'emacs-lisp-mode-hook 'flyspell-mode-hook)
    )
    
    :config
        (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-corrent-word)
        (define-key flyspell-mode-map  (kbd "<C-tab>")  #'flyspell-correct-word)
)
(use-package helm
    :defer t
    :ensure t
    :bind ("M-x" . helm-M-x)
    :init 
    :config
        (helm-mode 1)
        ;; helm always bottom
        (add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))
    :diminish helm-mode
)

(use-package helm-projectile
    :ensure t
    ;:bind("M-t" . helm-projectile-find-file)
    :config (helm-projectile-on)
)


(use-package helm-company
    :ensure t
    :config
        (eval-after-load 'company
            '(progn
                (define-key company-mode-map   (kbd "C-q") 'helm-company)
                (define-key company-active-map (kbd "C-q") 'helm-company)
            )
        )
)

(use-package helm-descbinds
    :ensure t
    :config (helm-descbinds-mode)
)

(use-package cmake-mode   :ensure t)
(use-package yaml-mode    :ensure t)
(use-package haskell-mode :ensure t)

(use-package elisp-slime-nav
    :ensure t
    :init
    (dolist (i '(emacs-lisp-mode-hook ielm-mode-hook))
        (add-hook i 'elisp-slime-nav-mode)
    )
    :diminish elisp-slime-nav-mode
)


(use-package undo-tree
    :ensure t
    :bind (("C-u"   . undo-tree-undo)
           ("C-r"   . undo-tree-redo)
    )
    :init
        (global-undo-tree-mode)
        (defalias 'redo 'undo-tree-redo)
        (defalias 'undo 'undo-tree-undo)
    :diminish undo-tree-mode
)


(use-package yasnippet
    :ensure t
    :config
        (yas-global-mode t)
        (setq yas-indent-line nil)
    :diminish yas-minor-mode
)

(require 'server)
(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(irony-cdb-search-directory-list (quote ("." "build" "bin")))
 '(package-selected-packages
   (quote
    (python-mode indent-guide eyebrowse multi-term git-gutter rg god-mode hlinum-mode linum-highlight-current-line-number doom-themes doom-modeline neotree nyan-mode boxquote evil-smartparens smartparens spaceline-all-the-icons nlinum clang-format flycheck-irony company-c-headers yaml-mode zenburn-theme company-irony-c-headers flycheck-pos-tip magit discover-my-major spacemacs-theme helm-descbinds use-package helm-company flycheck evil company-irony cmake-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-buffer-id ((t nil))))
