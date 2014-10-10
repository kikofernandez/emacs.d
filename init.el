(add-to-list 'load-path "~/.emacs.d/")

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Theme
(load-theme 'zenburn t)
(set-default-font "Monaco 16")

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; Bindings
(global-set-key [(control ?x) (control ?g)] 'magit-status)
