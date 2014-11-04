(add-to-list 'load-path "~/.emacs.d/")

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Theme
(load-theme 'zenburn t)
(set-default-font "Monaco 16")
(global-linum-mode t)


;; Ido mode: lets you interactively do things with buffers and files
(require 'ido)
(ido-mode t)
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

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

;; Auto complete
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
;(ac-config-default)
;(setq ac-ignore-case nil)
;;(add-to-list 'ac-modes 'enh-ruby-mode)

;; Ruby support
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'yard-mode)

;; OCaml
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" "Configuration of imenu for tuareg" t)

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq auto-mode-alist 
        (append '(("\\.ml[ily]?$" . tuareg-mode)
	          ("\\.topml$" . tuareg-mode))
                  auto-mode-alist))

;; Haskell mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; Bindings
(global-set-key [(control ?x) (control ?g)] 'magit-status)

;; Sets the $MANPATH, $PATH and exec-path from your shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(if (featurep 'xemacs)
     (global-set-key [(control ?x) (control ?m)] 'imenu) ; XEmacs
   (global-set-key [(control ?x) (control ?m)] 'imenu)) ; GNU Emacs


