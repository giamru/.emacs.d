;;; init.el --- Gianina's Emacs configuration
;;
;; Copyright © 2023 Gianina Moraru
;;
;; Author: Gianina Moraru <gianinamoraru@proton.me>
;; URL: https://github.com/giamru/.emacs.d

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

;; Install use package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

;; Packages

(use-package magit
  :ensure t)

(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin t)
  (set-background-color "black"))


;; config changes made through the customize UI will be stored here
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

;;; init.el ends here

