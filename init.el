;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(add-to-list 'load-path "/usr/local/opt/coq/lib/emacs/site-lisp")
(add-to-list 'load-path "/Users/kikofernandezreyes/.emacs.d/plugins")
(add-to-list 'load-path "/Users/kikofernandezreyes/.emacs.d/themes")
(add-to-list 'load-path "/Users/kikofernandezreyes/.emacs.d/modules")

;; (require 'cask "/Users/kikofernandezreyes/.emacs.d/.cask/26.3.1/elpa/cask-20180119.1906/cask.el")
(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

;; Simpleclip setup
;; (require 'simpleclip)
;; (simpleclip-mode 1)

;; (setq load-path (cons (expand-file-name "/Users/kikofernandezreyes/Code/ott/emacs") load-path))
;; (require 'ott-mode)

(require 'writegood-mode)
(global-set-key "\C-cg" 'writegood-mode)
(add-to-list 'auto-mode-alist '("\\.tex\\'" . writegood-mode))
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))


(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; Clojure CIDER
;; (add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
;; (unless (package-installed-p 'cider)
;;     (package-install 'cider))

;; ;; require or autoload paredit-mode
;; (add-hook 'clojure-mode-hook #'paredit-mode)

;; ;; require or autoload smartparens
;; (add-hook 'clojure-mode-hook #'smartparens-strict-mode)


;; load homebrew packages
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; (require 'grace-mode)

;; Coq
;; (load-file "~/.emacs.d/modules/ProofGeneral-4.2/generic/proof-site.el")
;; (setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
;; (autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)

;; Theme
(load-theme 'spacemacs-light t)
;; (load-theme 'zenburn t)
;; (load-theme 'whiteboard t)
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/color-theme-sanityinc-tomorrow/sanityinc-tomorrow-night")
;; (load-theme 'sanityinc-tomorrow-night t)
(set-frame-font "Monaco 16" nil t)
;; (set-default-font "Monaco 14")
(global-linum-mode t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq doc-view-ghostscript-program "/usr/local/bin/gs")

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; (require 'refill-mode)
;; (global-set-key (kbd "C-c q") 'refill-mode)

;; (add-hook 'c-mode-common-hook #'whitespace-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

;; Ido mode: lets you interactively do things with buffers and files
(require 'ido)
(ido-mode t)
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

;; ;; highlight symbol
(require 'highlight-symbol)
(global-set-key [(control c) (h)] 'highlight-symbol-at-point)
(global-set-key [meta tab] 'highlight-symbol-next)
(global-set-key [control meta tab] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

(add-hook 'after-init-hook #'global-flycheck-mode)
(global-set-key [(control c) (n)] 'flycheck-next-error)
(global-set-key [(control c) (p)] 'flycheck-previous-error)
(add-hook 'c-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "~/Code/encore/release/inc")
				 (expand-file-name "~/Code/encore/src/runtime/pony/libponyrt/")
				 (expand-file-name "~/Code/encore/src/runtime/party/")
                                 (expand-file-name "~/Code/llvm-src/llvm/include")
                                 (expand-file-name "~/Code/llvm-src/llvm/include/llvm")
                                 ))
	    (setq flycheck-clang-ms-extensions t)
	    (setq flycheck-clang-warnings (list "all" "extra" "everything" "error" "maybe-uninitialized"))))

;; ;; FillColumnIndicator
(setq-default fill-column 81)
;; (setq fci-rule-color "white")
;; (add-hook 'after-change-major-mode-hook 'fci-mode)

;; (setq truncate-lines nil)
;; (setq-default truncate-lines t)
;; (setq-default default-truncate-lines nil)
;; ;(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; ;(global-fci-mode 1)


;; ;; ENCORE MODE
;; (add-to-list 'load-path "~/Code/encore/emacs/encore-mode/")
;; (setq encore-block-highlight-toggle 'overlay)
;; (setq encore-block-highlight-toggle 'minibuffer)
;; (setq encore-block-highlight-toggle t)
;; (add-to-list 'yas-snippet-dirs "~/Code/encore/emacs/encore-mode/snippets")
;; (require 'encore-mode)

;; (add-hook 'encore-mode-hook (lambda () (global-set-key (kbd "C-c C-c") 'compile)))
;; (add-hook 'encore-mode-hook (lambda () (global-set-key (kbd "C-c C-n") 'next-error)))
;; (add-hook 'encore-mode-hook (lambda () (global-set-key (kbd "C-c C-p") 'previous-error)))


;; (global-set-key (kbd "s-<left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "s-<right>") 'enlarge-window-horizontally)
;; (global-set-key (kbd "s-<down>") 'shrink-window)
;; (global-set-key (kbd "s-<up>") 'enlarge-window)

(defvar visual-wrap-column nil)

(defun set-visual-wrap-column (new-wrap-column &optional buffer)
      "Force visual line wrap at NEW-WRAP-COLUMN in
    BUFFER (defaults to current buffer) by setting the right-hand
    margin on every window that displays BUFFER.  A value of NIL
    or 0 for NEW-WRAP-COLUMN disables this behavior."
      (interactive (list (read-number "New visual wrap column, 0 to disable: " (or visual-wrap-column fill-column 0))))
      (if (and (numberp new-wrap-column)
               (zerop new-wrap-column))
        (setq new-wrap-column nil))
      (with-current-buffer (or buffer (current-buffer))
        (visual-line-mode t)
        (set (make-local-variable 'visual-wrap-column) new-wrap-column)
        (add-hook 'window-configuration-change-hook 'update-visual-wrap-column nil t)
        (let ((windows (get-buffer-window-list)))
          (while windows
            (when (window-live-p (car windows))
              (with-selected-window (car windows)
                (update-visual-wrap-column)))
            (setq windows (cdr windows))))))

(defun update-visual-wrap-column ()
      (if (not visual-wrap-column)
        (set-window-margins nil nil)
        (let* ((current-margins (window-margins))
               (right-margin (or (cdr current-margins) 0))
               (current-width (window-width))
               (current-available (+ current-width right-margin)))
          (if (<= current-available visual-wrap-column)
            (set-window-margins nil (car current-margins))
            (set-window-margins nil (car current-margins)
                                (- current-available visual-wrap-column))))))


(add-hook 'latex-mode-hook
         (lambda ()
	    (visual-line-mode 1)
	    (visual-fill-column 1)))

;; ;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-to-list 'auto-mode-alist '("\\.scrbl\\'" . texinfo-mode))

(add-hook 'markdown-mode-hook
          (lambda ()
	    ;; (visual-fill-column-mode 1)
	    (visual-line-mode 1)
	    ))


(add-hook 'org-mode-hook
          (lambda ()
	    ;; (visual-line-mode 1)
	    (visual-fill-column 1)))

;; ;; Auto complete
;; ;(require 'auto-complete-config)
;; ;(add-to-list 'ac-dictionary-directories "~/.emacs.d/.cask/24.3.50.1/elpa/auto-complete-20130724.1750/dict")
;; ;(ac-config-default)
;; ;(setq ac-ignore-case nil)
;; ;;(add-to-list 'ac-modes 'enh-ruby-mode)

;; ;; Ruby support
;; (add-hook 'enh-ruby-mode-hook 'robe-mode)
;; (add-hook 'enh-ruby-mode-hook 'yard-mode)

;; ;; OCaml
;; (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
;; (autoload 'camldebug "camldebug" "Run the Caml debugger" t)
;; (autoload 'tuareg-imenu-set-imenu "tuareg-imenu" "Configuration of imenu for tuareg" t)

;; (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

;; (setq auto-mode-alist
;;         (append '(("\\.ml[ily]?$" . tuareg-mode)
;; 	          ("\\.topml$" . tuareg-mode))
;;                   auto-mode-alist))

(add-to-list 'load-path "~/.local/bin/hindent")
(require 'hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)


;; Haskell setup

(require 'hs-lint)
(defun hlint-mode ()
   (local-set-key "\C-hl" 'hs-lint))
(add-hook 'haskell-mode-hook 'hlint-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook 'highlight-symbol-mode)

;; (defun haskell-sort-and-format-imports
;;     "Runs 'haskell-sort-imports' and 'haskell-mode-format-imports' in sequence"
;;     (interactive)
;;     (haskell-sort-imports)
;;     (haskell-mode-format-imports))

;; (add-hook 'haskell-mode-hook
;;   (lambda()
;;     (local-set-key (kbd "C-c i") haskell-sort-and-format-imports)))

(setq haskell-tags-on-save t)
;; (add-to-list 'company-backends 'company-ghc)
;; (custom-set-variables '(company-ghc-show-info t))

(add-hook 'haskell-mode-hook
  (lambda ()
    (set (make-local-variable 'company-backends)
         (append '((company-capf company-dabbrev-code))
                 company-backends))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "2679db166117d5b26b22a8f12a940f5ac415d76b004de03fcd34483505705f62" "bd51a329aa9b8e29c6cf2c8a8cf136e0d2960947dfa5c1f82b29c9178ad89a27" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "a0fdc9976885513b03b000b57ddde04621d94c3a08f3042d1f6e2dbc336d25c7" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default))
 '(flycheck-clang-warnings '("all" "extra" "everything" "error" "uninitialized"))
 '(ggtags-global-output-format 'path)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'stack-ghci)
 '(magit-commit-arguments '("--gpg-sign=D0DE5652052129C6"))
 '(org-agenda-files (list "~/work.org"))
 '(package-selected-packages
   '(which-key helm-lsp lsp-origami lsp-ui erlang flyspell-popup writegood-mode spacemacs-theme humanoid-themes company-ghci flymake-haskell-multi flymd gh-md markdown-changelog flycheck company-ghc company ensime typescript-mode cider clojure-mode paredit xclip gscholar-bibtex osx-clipboard simpleclip forest-blue-theme ggtags hindent flycheck-haskell zenburn-theme yasnippet web-mode use-package undo-tree tuareg smex smartparens projectile prodigy popwin pallet nyan-mode multiple-cursors markdown-mode magit idle-highlight-mode htmlize highlight-symbol haskell-mode flycheck-cask fill-column-indicator expand-region exec-path-from-shell enh-ruby-mode drag-stuff auto-complete ack))
 '(safe-local-variable-values
   '((TeX-master . t)
     (TeX-master . "main.tex")
     (TeX-master . "../main")
     (TeX-master . "")))
 '(simpleclip-mode t))

(require 'speedbar)
   (speedbar-add-supported-extension ".hs")


;; ;; Bindings
(global-set-key [(control ?x) (control ?g)] 'magit-status)

;; Sets the $MANPATH, $PATH and exec-path from your shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(if (featurep 'xemacs)
     (global-set-key [(control ?x) (control ?m)] 'imenu) ; XEmacs
   (global-set-key [(control ?x) (control ?m)] 'imenu)) ; GNU Emacs


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
;;  '(custom-safe-themes (quote ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "e3c90203acbde2cf8016c6ba3f9c5300c97ddc63fcb78d84ca0a144d402eedc6" "2a86b339554590eb681ecf866b64ce4814d58e6d093966b1bf5a184acf78874d" "a0fdc9976885513b03b000b57ddde04621d94c3a08f3042d1f6e2dbc336d25c7" "8f1cedf54f137f71382e3367e1843d10e173add99abe3a5f7d3285f5cc18f1a9" "c56d90af9285708041991bbc780a073182cbe91721de17c6e7a8aac1380336b3" "0ed983facae99849805b2f7be926561cb58474eb18e5296d9bb3ad7f9b088a5b" "8022cea21aa4daca569aee5c1b875fbb3f3248a5debc6fc8cf5833f2936fbb22" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" default)))
;;  '(fci-rule-color "#383838")
;;  '(send-mail-function (quote smtpmail-send-it))
;;  '(smtpmail-smtp-server "smtp.uu.se")
;;  '(smtpmail-smtp-service 25)
;;  '(tool-bar-mode nil)
;;  '(truncate-lines nil)
;;  '(truncate-partial-width-windows nil)
;;  '(vc-annotate-background "#2B2B2B")
;;  '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
;;  '(vc-annotate-very-old-color "#DC8CC3"))

;; ;;(custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;; ;; '(default ((t (:inherit nil :stipple nil :background "#3F3F3F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Monaco")))))


;; ;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;; '(org-agenda-files (quote ("~/Code/encore/src/runtime/party/todo.org")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; -*- lisp -*-

;; This is a sample .emacs file which you can use to troubleshoot your
;; Erlang LS Emacs setup.

;; Use packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

;; Define a utility function which either installs a package (if it is
;; missing) or requires it (if it already installed).
(defun package-require (pkg &optional require-name)
  "Install a package only if it's not already installed."
  (when (not (package-installed-p pkg))
    (package-install pkg))
  (if require-name
      (require require-name)
    (require pkg)))

;; Install the official Erlang mode
(package-require 'erlang)

;; Include the Language Server Protocol Clients
(package-require 'lsp-mode)

;; Customize prefix for key-bindings
(setq lsp-keymap-prefix "C-l")

;; Enable LSP for Erlang files
(add-hook 'erlang-mode-hook #'lsp)

;; Require and enable the Yasnippet templating system
(package-require 'yasnippet)
(yas-global-mode t)

;; Enable logging for lsp-mode
(setq lsp-log-io t)

;; Show line and column numbers
(add-hook 'erlang-mode-hook 'linum-mode)
(add-hook 'erlang-mode-hook 'column-number-mode)

;; Enable and configure the LSP UI Package
(package-require 'lsp-ui)
(setq lsp-ui-sideline-enable t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-position 'bottom)

;; Enable LSP Origami Mode (for folding ranges)
(package-require 'lsp-origami)
(add-hook 'origami-mode-hook #'lsp-origami-mode)
(add-hook 'erlang-mode-hook #'origami-mode)

;; Provide commands to list workspace symbols:
;; - helm-lsp-workspace-symbol
;; - helm-lsp-global-workspace-symbol
(package-install 'helm-lsp)

;; Which-key integration
(package-require 'which-key)
(add-hook 'erlang-mode-hook 'which-key-mode)
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; Always show diagnostics at the bottom, using 1/3 of the available space
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))
