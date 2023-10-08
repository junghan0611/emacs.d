;;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;;; Commentary:

;;; Code:

;;; User Profile

(setq user-full-name (if (getenv "USER_FULL_NAME")
                         (getenv "USER_FULL_NAME")
                       "John Doe"))

(setq user-mail-address (if (getenv "USER_MAIL_ADDRESS")
                            (getenv "USER_MAIL_ADDRESS")
                          "john.doe@example.com"))

;; Set my GPG key as the default key
(setq-default epa-file-encrypt-to (if (getenv "EPA_FILE_ENCRYPT_TO")
                                      (list (getenv "EPA_FILE_ENCRYPT_TO"))
                                    (list "ABCDEFGHIJKLMN")))

;;; Path

(defconst user-org-directory (if (getenv "ORG_DIRECTORY")
                                 (getenv "ORG_DIRECTORY")
                               "~/org/"))

(setq
 ;; org-roam-database-connector 'sqlite-builtin

 ;; org-directory "~/sync/org/" ; (file-truename "~/sync/org/")
 org-directory user-org-directory

 org-roam-directory (concat org-directory "roam/")
 org-note-directory org-roam-directory

 org-workflow-directory (concat org-directory "workflow/")
 org-projectile-file (concat org-workflow-directory "project.org")

;;  org-contacts-files (list (concat org-workflow-directory "contacts.org"))
 ;; org-contacts-files (concat org-roam-directory "notes/people.org")

 org-inbox-file (concat org-workflow-directory "inbox.org")
 org-default-notes-file (concat org-workflow-directory "inbox.org")

 org-user-agenda-files (list (concat org-directory "workflow/"))
 org-log-file (concat org-workflow-directory "log.org")
 ;; org-user-agenda-files (file-expand-wildcards "~/sync/org/workflow/*.org")
 org-user-agenda-diary-file org-log-file
 )

;;; per-machine.el ends here
