;;; init.el --- Gianina's Emacs configuration
;;
;; Copyright © 2023 Gianina Moraru
;;
;; Author: Gianina Moraru <gianinamoraru@proton.me>
;; URL: https://github.com/giamru/.emacs.d

;;; Commentary:
;; My personal EMACS configuration

;;; Code:
 
(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
;; update the package metadata
(unless package-archive-contents
  (package-refresh-contents))

;; Always load newest byte code
(setq load-prefer-newer t)

;; Start in full screen
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Remove top toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; Remove menu bar
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; Fonts
(cond
 ((find-font (font-spec :name "Cascadia Code"))
  (set-frame-font "Cascadia Code-16"))
 ((find-font (font-spec :name "Menlo"))
  (set-frame-font "Menlo-16"))
 ((find-font (font-spec :name "DejaVu Sans Mono"))
  (set-frame-font "DejaVu Sans Mono-16"))
 ((find-font (font-spec :name "Inconsolata"))
  (set-frame-font "Inconsolata-16")))

;; check OS type
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (message "Microsoft Windows")))
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
    ;; (setq mac-right-command-modifier      'super
    ;;       ns-right-command-modifier       'super
    ;;       mac-option-modifier             'meta
    ;;       ns-option-modifier              'meta
    ;;       mac-right-option-modifier       'none
    ;;       ns-right-option-modifier        'none
    ;;       )
    (setq mac-right-command-modifier 'meta
	  mac-command-modifier 'meta)
    (message "MacOS")))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (message "Linux"))))

;; Install use package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;; Packages

(use-package paren
  :config
  (show-paren-mode +1))

(use-package magit
  :ensure t)

(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin t)
  (set-background-color "black"))

(use-package diminish
  :ensure t
  :config
  (diminish 'abbrev-mode)
  (diminish 'flyspell-mode)
  (diminish 'flyspell-prog-mode)
  (diminish 'eldoc-mode))

(use-package paredit
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'paredit-mode)
  (add-hook 'lisp-mode-hook #'paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
  (diminish 'paredit-mode "()"))

(use-package markdown-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-c l")
  :commands lsp)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.5)
  (setq company-show-quick-access t)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-align-annotations t)
  ;; invert the navigation direction if the the completion popup-isearch-match
  ;; is displayed on top (happens near the bottom of windows)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode)
  (diminish 'company-mode))


(use-package tree-sitter
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-tree-sitter-mode))

(use-package undo-tree
  :ensure t
  :config
  ;; autosave the undo-tree history
  (setq undo-tree-history-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq undo-tree-auto-save-history t)
  (global-undo-tree-mode +1)
  (diminish 'undo-tree-mode))

;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here

