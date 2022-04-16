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
(add-hook 'elpy-mode-hook
  (lambda ()
    (local-set-key [f9] 'elpy-format-code)))
(setq elpy-shell-echo-output nil)
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
(setq ein:output-area-inlined-images t)
;; Magit
(use-package magit)
(use-package forge)
(with-eval-after-load 'magit
  (require 'forge))
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
(setq verilog-indent-level             2
      verilog-indent-level-module      2
      verilog-indent-level-declaration 2
      verilog-indent-level-behavioral  2
      verilog-indent-level-directive   1
      verilog-case-indent              2
      verilog-auto-newline             nil
      verilog-auto-indent-on-newline   t
      verilog-tab-always-indent        t
      verilog-auto-endcomments         t
      verilog-minimum-comment-distance 1
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              'declarations
      verilog-linter                   "my_lint_shell_command"
      )

;; VHDL mode
(use-package vhdl-mode)
;; Golden ratio mode
(use-package golden-ratio)
;; Projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1)
  (setq projectile-switch-project-action #'projectile-dired))
;; Helm
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (add-to-list 'helm-completing-read-handlers-alist
               '(verilog-goto-defun . nil))
  )
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
(eval-after-load "elpy"
  (setq elpy-formatter "black")
  )
;; Disable double buffering as it gives issues on some X11 versions, remote connections
;; (setq default-frame-alist
;;          (append default-frame-alist '((inhibit-double-buffering . t))))
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; Extra modes
(add-to-list 'auto-mode-alist '("\\.sdc\\'" . tcl-mode))
(add-to-list 'auto-mode-alist '("\\.cpf\\'" . tcl-mode))
; Instant auto-complete in all buffers with company mode
(setq company-idle-delay 0)
(add-hook 'after-init-hook 'global-company-mode)
;; Default theme settings
(load-theme 'leuven t)
(nyan-mode t)
;; C++
(use-package irony)
(use-package company-irony)
(use-package flycheck)
(use-package flycheck-irony)
(use-package clang-format)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(require 'company-irony)
(eval-after-load 'company
 '(add-to-list 'company-backends 'company-irony))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

(setq clang-format-style-option "llvm")
(setq-default clang-format-fallback-style "llvm")
;; Disable bell sound
(setq ring-bell-function 'ignore)
;; (server-start)
;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-items '((projects . 10)
                        (recents  . 10)
                        ))
(setq dashboard-startup-banner 'logo)
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
;; which-keys
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
