;;; +font.el --- Summery
;;; -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;;; font Setting
;; +------------+------------+
;; | 일이삼사오 | 일이삼사오 |
;; +------------+------------+
;; | ABCDEFGHIJ | ABCDEFGHIJ |
;; +------------+------------+
;; | 1234567890 | 1234567890 |
;; +------------+------------+
;; | 일이삼사오 | 일이삼사오 |
;; | abcdefghij | abcdefghij |
;; +------------+------------+

;; text utf-8 setting
;(setq utf-translate-cjk-mode nil)
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-charset-priority 'unicode)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; 날짜 표시를 영어로한다. org mode에서 time stamp 날짜에 영향을 준다.
(setq system-time-locale "C")

(setq input-method-verbose-flag nil
      input-method-highlight-flag nil)

                                        ; some font use mode speed up config (ex: org-superstar)
(setq inhibit-compacting-font-caches t)

;;  NanumGothicCoding Setting
;; (set-face-attribute   'default            nil       :family "Fira Code" :height 130)
;; (set-face-attribute   'default           nil        :family "FiraCode Nerd Font Mono" :height 130)
;; (set-fontset-font nil 'hangul            (font-spec :family "NanumGothicCoding"  :pixelsize 17))
;; (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "NanumGothicCoding"  :pixelsize 17))
;; (setq face-font-rescale-alist '(("NanumGothicCoding" . 1.2)))

; D2Coding Setting
;(set-face-attribute   'default            nil       :family "Fira Code" :height 120)
;(set-fontset-font nil 'hangul            (font-spec :family "D2Coding"  :pixelsize 18))
;(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "D2Coding"  :pixelsize 18))
;(setq face-font-rescale-alist '(("D2coding" . 1.17)))

;(set-face-attribute   'default            nil       :family "FiraCode Nerd Font Mono" :height 120)
;(setq face-font-rescale-alist '(("D2coding" . 1.03877)))
;(setq face-font-rescale-alist '(("D2coding" . 0.85)))

(set-face-attribute 'default nil :family "Sarasa Mono K" :width 'normal :weight 'regular :height 136)
(set-fontset-font nil 'hangul (font-spec :family "Sarasa Mono K"))
(set-face-attribute 'fixed-pitch nil :family "Sarasa Term K" :width 'normal :weight 'regular)
;; (set-face-attribute 'fixed-pitch-serif nil :family "Hahmlet" :width 'normal :weight 'regular)
(set-face-attribute 'variable-pitch nil :family "Pretendard Variable"
                    :width 'normal :weight 'regular)

(set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji") nil)
(set-fontset-font t 'emoji (font-spec :family "Noto Emoji") nil 'prepend) ; Top

(set-fontset-font t 'symbol (font-spec :family "Symbola") nil)
(set-fontset-font t 'symbol (font-spec :family "Noto Sans Symbols 2") nil 'prepend)
(set-fontset-font t 'symbol (font-spec :family "Noto Sans Symbols") nil 'prepend)

;; (require 'fontaine)

(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")

(defun load-theme@run-hooks (&rest _)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))
(advice-add 'load-theme :after #'load-theme@run-hooks)

(defun load-theme@theme-dont-propagate (&rest _)
  "Discard all themes before loading new."
  (mapc #'disable-theme custom-enabled-themes))
(advice-add #'load-theme :before #'load-theme@theme-dont-propagate)

;; ;; (add-hook 'after-load-theme-hook
;; ;;           (defun bolder-faces ()
;; ;;             (set-face-attribute 'font-lock-function-name-face nil :weight 'semi-bold)
;; ;;             (set-face-attribute 'font-lock-keyword-face nil :weight 'semi-bold)))

(defun +theme--tweaks-h (&optional _)
  (interactive)
  "Use smaller font (80% of the default) for line numbers in graphic mode."
  (when (display-graphic-p)
    (set-face-attribute
     'line-number nil
     :background (face-attribute 'default :background)
     :height (truncate (* 0.80 (face-attribute 'default :height)))
     :weight 'semi-light)
    (set-face-attribute
     'line-number-current-line nil
     :height (truncate (* 0.80 (face-attribute 'default :height)))
     :weight 'bold)))
(add-hook 'after-load-theme-hook #'+theme--tweaks-h)

;; (defun change-mac-input-method ()
;;     "change input-source in MacOS"
;;     (interactive)
;;     (call-process "osascript" nil t nil "-e" "tell application \"System Events\" to keystroke space using { shift down }")
;;     )

;; (when *is-mac*
;;     (progn
;;         (require 'ucs-normalize)
;;         (set-file-name-coding-system 'utf-8)
;;         (setq default-process-coding-system '(utf-8 . utf-8))
;;         (set-terminal-coding-system  'utf-8)))

(setq-default line-spacing 2)

;; (global-font-lock-mode t)

;; 한글입력할때 완성전까지 안보이는 문제 해결을 위해 내장 한글입력기 사용
;; Linux 내장 한글입력기 사용법

; 터미널에 xrdb ~/.Xresources 하고 xrdb -merge ~/.Xresources 하고 이맥스 다시키면 됨
(setq default-input-method "korean-hangul")
(setq default-korean-keyboard 'korean-hangul)
;; (global-set-key [S-SPC] 'toggle-input-method) ; Ivy모드를 사용하면 S-SPC를 ivy-minibuffer-map에서 remapping 해줘야 한다.
;; (global-set-key [?\S- ] 'toggle-input-method) ; Ivy모드를 사용하면 S-SPC를 ivy-minibuffer-map에서 remapping 해줘야 한다.
(global-set-key (kbd "S-SPC") 'toggle-input-method) ; Ivy모드를 사용하면 S-SPC를 ivy-minibuffer-map에서 remapping 해줘야 한다.
;; (global-set-key (kbd "<f17>") 'toggle-input-method) ; macos shift-space setting Karabiner를 사용해야된다.
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

(use-package default-text-scale
:config (default-text-scale-mode)
        ;(if *is-wsl* (default-text-scale-increment 20))
        ;(if *is-wsl* (default-text-scale-increment 45))
)

; FiraCode같은 텍스트모드 활성 모드
(use-package ligature :elpaca (:host github :repo "mickeynp/ligature.el")
  :config
  ;; Enable the www ligature in every possible major mode
  ;; (ligature-set-ligatures 't '("www"))
  ;; (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; ; Enable ligatures in programming modes
  (ligature-set-ligatures '(prog-mode org-mode)
          '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
          ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
          "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
          "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
          "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
          "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
          "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
          "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
          "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
          "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))
  ;; (ligature-set-ligatures '(prog-mode)
  ;;       '("<==" "<~~" "==>" "~~>"
  ;;         "<=>" "<==>" "->" "-->" "<-" "<--"
  ;;         "<->" "<-->"))
  (global-ligature-mode t)
  )

;; (use-package emojify
;;     :if window-system
;;     :custom
;;     (emojify-display-style 'unicode)
;;     (emojify-emoji-styles '(unicode))
;;     :hook (after-init . global-emojify-mode)
;; )

(use-package textsize :elpaca (:type git :host github :repo "WJCFerguson/textsize"))

(provide '+font)
;;; +font.el ends here
