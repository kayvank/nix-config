;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kayvan Kazeminejad"
      user-mail-address "kayvan@q2io.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;
 (setq doom-font (font-spec :family "Source Code Pro" :size 28 )
       doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 30))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
(setq org-roam-directory "~/Documents/org/roam")
(setq default-directory "~/Documents/org/notes"
      deft-extensions '("org" "txt")
      deft-recursive t)
(setq org-journal0-date-prefix "#TITLE: "
      org-journal-time-prfix "* "
      org-journal-date-prfix "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-c l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(global-set-key (kbd "C-c +") 'image-increase-size)
(global-set-key (kbd "C-c g") 'magit-file-dispatch)
(global-set-key (kbd "C-c z") 'zeal-at-point)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c n") 'avy-goto-char)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x w") 'elfeed)
(global-set-key (kbd "<f8>") 'neotree-projectile-action)
(global-set-key (kbd "S-<f8>") 'neotree-toggle)
(global-set-key [f6] 'lsp-describe-thing-at-point)
;; (global-set-key (kbd "C-c C-g") 'helm-projectile-grep)
;; (global-set-key [f7] 'helm-projectile-grep)
(global-set-key (kbd "C-c C-m i") 'lsp-ui-imenu)
(global-set-key (kbd "C-c C-m I") 'lsp-ui-imenu--kill)
(global-set-key (kbd "C-c C-m l") 'lsp-command-map)
(global-set-key (kbd "C-c C-a") 'lsp-ui-sideline-apply-code-actions)
(global-set-key (kbd "C-c C-m g") 'haskell-hoogle)
(global-set-key (kbd "C-c C-h") 'haskell-hoogle-lookup-from-website)
;;
;; relie on build tool to reformat source code & refresh
(global-auto-revert-mode t)
(global-set-key (kbd "C-x k") 'kill-this-buffer)


(setq large-file-warning-threshold 100000000)
;; (setq auth-sources '("~/.authinfo.gpg") auth-source-cache-expiry nil)
(setq rmh-elfeed-org-files (list "~/.elfeed.org"))
(setq lsp-lens-enable t)
(evil-define-key 'normal lsp-mode-map (kbd "\\") lsp-command-map)

;;;;;;;;;; gnus ;;;;;;;;;;;

(use-package! erc
  :custom
  (erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#haskell" "purescript" "nixos")))
  (erc-autojoin-timing 'ident)
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 22)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                             "324" "329" "332" "333" "353" "477"))
  :config
  (add-to-list 'erc-modules 'notifications)
  (add-to-list 'erc-modules 'spelling)
  (erc-services-mode 1)
  (erc-update-modules))

(defun my/erc-start-or-switch ()
  "Connects to ERC, or switch to last active buffer."
  (interactive)
  (if (get-buffer "irc.freenode.net:6667")
      (erc-track-switch-buffer 1)
    (when (y-or-n-p "Start ERC? ")
      (erc :server "irc.freenode.net" :port 6667 :nick "rememberYou"))))

(defun my/erc-notify (nickname message)
  "Displays a notification message for ERC."
  (let* ((channel (buffer-name))
         (nick (erc-hl-nicks-trim-irc-nick nickname))
         (title (if (string-match-p (concat "^" nickname) channel)
                    nick
                  (concat nick " (" channel ")")))
         (msg (s-trim (s-collapse-whitespace message))))
    (alert (concat nick ": " msg) :title title)))
(defun my/erc-count-users ()
  "Displays the number of users connected on the current channel."
  (interactive)
  (if (get-buffer "irc.freenode.net:6667")
      (let ((channel (erc-default-target)))
        (if (and channel (erc-channel-p channel))
            (message "%d users are online on %s"
                     (hash-table-count erc-channel-users)
                     channel)
          (user-error "The current buffer is not a channel")))
    (user-error "You must first start ERC")))
;; (set-face-attribute 'aw-leading-char-face nil :height 400)
(use-package! all-the-icons-ivy
  :hook (
         'after-init-hook 'all-the-icons-ivy-setup)
  )
