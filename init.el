(add-to-list 'load-path "~/.emacs.d/")

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Theme
(load-theme 'zenburn t)
(set-default-font "Monaco 16")

;; Ido mode: lets you interactively do things with buffers and files
(require 'ido)
(ido-mode t)

;; FillColumnIndicator
(setq-default fill-column 80)
(setq fci-rule-color "white")
(add-hook 'after-change-major-mode-hook 'fci-mode)
;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;(global-fci-mode 1)

;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Bindings
(global-set-key [(control ?x) (control ?g)] 'magit-status)
