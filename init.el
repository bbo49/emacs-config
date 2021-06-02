;; ===================================
;; MELPA Package Support
;; ===================================
;; Enables basic packaging support
(require 'package)
;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;; Initializes the package infrastructure
(package-initialize)
;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))
;; Auto package install support
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;;=======================
;; Install some packages
;;=======================
;; ELPY
(use-package elpy)
(elpy-enable)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
;; Python-x-mode
(use-package python-x)
(python-x-setup)
(define-key python-mode-map (kbd "M-<return>") nil)
;; Python-cell-mode
(use-package python-cell)
;; NYAN Mode
(use-package nyan-mode)
;; Quickhelp mode
(use-package company-quickhelp)
;; EIN Emacs IPython Notebook
(use-package ein)
;; Magit
(use-package magit)
;; muliple-cursors
(use-package multiple-cursors)
;; When you have an active region that spans multiple lines,
;; the following will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; When you want to add multiple cursors not based on continuous
;; lines, but based on keywords in the buffer, use:
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; RealGUD debugger
(use-package realgud)
(use-package realgud-ipdb)
;; Verilog mode
(use-package verilog-mode)
;; VHDL mode
(use-package vhdl-mode)
;; Additional Configuration
;;===========================
;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Put custom variables in separate file
(setq custom-file "~/.emacs_custom")
(load custom-file 'noerror)
;; Disable toolbar
(tool-bar-mode -1)
;; Disable menu bar
;; (menu-bar-mode -1)
;; Disable scroll bar
(toggle-scroll-bar -1) 
;; Use simple ipython proment
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")
;; Disble python cell mode in python buffer
(add-hook 'inferior-python-mode-hook
        (lambda ()
          (setq python-cell-mode nil)))
;; Disable double buffering as it gives issues on some X11 versions, remote connections
(setq default-frame-alist
         (append default-frame-alist '((inhibit-double-buffering . t))))
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; Extra modes
(add-to-list 'auto-mode-alist '("\\.sdc\\'" . tcl-mode))
(add-to-list 'auto-mode-alist '("\\.cpf\\'" . tcl-mode))
(setq company-idle-delay 0)
(add-hook 'after-init-hook 'global-company-mode)
