;;; +docker.el --- Summery
;;; -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(use-package docker
:commands docker
:general (leader "hud" 'docker)
:custom (docker-image-run-arguments '("-i", "-t", "--rm"))
)

(use-package dockerfile-mode
:mode ("Dockerfile\\'" . dockerfile-mode)
)

(use-package kubernetes
    :commands (kubernetes-overview)
    :config
    (setq kubernetes-poll-frequency 3600)
    (setq kubernetes-redraw-frequency 3600)
)

(use-package k8s-mode
:hook (k8s-mode . yas-minor-mode)
)

(use-package docker-compose-mode)

(provide '+docker)
;;; +docker.el ends here
