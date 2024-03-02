;; Disable gui elements
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Don't show startup message
(setq inhibit-startup-message t)

;; Use empty scratch buffer
(setq initial-scratch-message "")

;; Setup package management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Load remaining of configuration
(org-babel-load-file (concat user-emacs-directory "setup.org"))
