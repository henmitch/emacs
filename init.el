(package-initialize)

(require 'package)

(setq package-enable-at-startup nil)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(defvar backup-dir "~/.emacs.d/backups")
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)


;; Universal preferences

;;;; Function
(electric-pair-mode 1)
;; (show-paren-mode 1)

(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)

(setq confirm-kill-emacs 'yes-or-no-p)
(setq auto-save-default nil)
;; When editing symlinks, allow Emacs to access Git things
(setq vc-follow-symlinks 1)

(add-to-list 'write-file-functions 'delete-trailing-whitespace)

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;;; Appearance

;; Startup
(setq inhibit-splash-screen 1)
(setq inhibit-startup-message 1)
(setq initial-scratch-message "")
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-hook 'after-init-hook '(lambda () (org-agenda nil "n")))

;; Smooth scrolling
(setq scroll-margin 2)
(setq scroll-conservatively 1000)

(global-font-lock-mode 1)

(setq-default display-line-numbers-type 'relative)

(column-number-mode 1)
(global-display-line-numbers-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(add-hook 'prog-mode-hook 'hs-minor-mode)

;; Packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package tex
  :ensure auctex
  :defer 1
  :config
  (setq Tex-tree-roots '("~/.texlive2017" "~/texlive2016"))
  (setq-default TeX-master nil)

  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

  (setq LaTeX-math-list
	'((?, "qc" "" nil)
	  (?6 "partial" "" nil)
	  (?= "implies" "" nil)
	  (?8 "infty" "" nil)
	  (?e "varepsilon" "" nil))))

(use-package general
  :ensure t
  :config
  (general-auto-unbind-keys))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package evil
  :ensure t

  :init
  (setq evil-want-integration nil)
  (setq evil-search-module 'evil-search)
  (setq evil-want-Y-yank-to-eol 1)


  :config
  (evil-ex-define-cmd "h[elp]" 'help)
  (evil-ex-define-cmd "W[rite]" 'evil-save)
  (evil-ex-define-cmd "E[dit]" 'evil-edit)

  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)

  (setq evil-vsplit-window-left -1)

  (evil-mode 1))

(general-define-key
 :states 'normal
 "C-k" 'evil-window-up
 "C-j" 'evil-window-down
 "C-h" 'evil-window-left
 "C-l" 'evil-window-right
 "C-c h" 'help
 :states '(normal visual)
 "<up>" 'evil-previous-visual-line
 "<down>" 'evil-previous-visual-line)

 (use-package evil-commentary
   :requires evil
   :ensure t
   :config
   (evil-commentary-mode))

 (use-package evil-surround
   :requires evil
   :ensure t
   :config
   (global-evil-surround-mode 1))

 (use-package evil-easymotion
   :requires evil
   :ensure t
   :config
   (evilem-default-keybindings "SPC"))

 (use-package evil-leader
   :requires evil
   :ensure t
   :config
   (evil-leader/set-key "SPC" 'evil-ex-nohighlight)
   (global-evil-leader-mode 1))

(use-package org
  :config
  (setq org-todo-keywords
	'((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))
  (setq org-agenda-files
	'("~/Todo/school/"))
  :general
  ("C-c a" 'org-agenda
   "C-c c" 'org-capture)
  (:keymaps 'org-agenda-mode-map
	    "j" 'evil-next-line
	    "k" 'evil-previous-line))

(use-package which-key
  :defer 1
  :config
  (which-key-mode 1))

(use-package highlight-symbol
  :ensure t
  :defer 1
  :config
  (setq-default highlight-symbol-idle-delay 1)
  (highlight-symbol-mode 1))
