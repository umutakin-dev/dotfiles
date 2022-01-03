;; --------------------------------------------------
;; PACKAGES
;; --------------------------------------------------

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize Packages
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Non Linux Systems
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Line Numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(term-mode-hook
		shell-mode hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Dont start searches with ^

(use-package dracula-theme)

(use-package swiper)

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general)
  ;; :config
  ;; (general-create-definer ua/leader-keys
  ;;   ;; :prefix "SPC"
  ;;   :global-prefix "M-SPC")

  ;; (ua/leader-keys
  ;;   "t" '(:ignore t :which-key "toggles")
  ;;   "tt" '(counsel-load-theme :which-key "choose theme"))) 

;; (defun ua/evil-hook ()
;;   (dolist (mode '(custom-mode
;; 		  eshell-mode
;; 		  git-rebase-mode
;; 		  erc-mode
;; 		  circe-server-mode
;; 		  circe-chat-mode
;; 		  circe-query-mode
;; 		  sauron-mode
;; 		  term-mode))
;;     (add-to-list 'evil-emacs-state-modes mode)))

;; (use-package evil
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding nil)
;;   (setq evil-want-C-u-scroll t)
;;   (setq evil-want-C-i-jump nil)
;;   :config
;;   (evil-mode 1)
;;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;;   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

;;   ;; Use visual line motions even outside of visual-line-mode buffers
;;   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;;   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

;;   (evil-set-initial-state 'messages-buffer-mode 'normal)
;;   (evil-set-initial-state 'dashboard-mode 'normal))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  ;; :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; --------------------------------------------------

;; --------------------------------------------------
;; User Interface
;; --------------------------------------------------

(setq inhibit-startup-message t) ;; Inhinit Startup Message
(scroll-bar-mode -1)             ;; Disable Visual Scrollbar
(tool-bar-mode -1)               ;; Disable the Toolbar
(tooltip-mode -1)                ;; Disable Tooltips
(set-fringe-mode 10)             ;; ???
(menu-bar-mode -1)               ;; Disable the Menu Bar
(setq visible-bell t)            ;; Set Up Visual Bell
(set-face-attribute              ;; Set Font
 'default nil 
 :font "DejaVu Sans Mono"  
 :height 150)
(load-theme 'dracula t)         ;; Load Theme

;; --------------------------------------------------
