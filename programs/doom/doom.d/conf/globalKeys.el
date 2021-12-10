;;; ../dev/workspaces/workspace-emacs/kayvan/doom.d/globalKeys.el -*- lexical-binding: t; -*-
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

(global-set-key (kbd "C-]") 'find-tag)
(global-set-key (kbd "C-x C-b") 'projectile-ibuffer)
(global-set-key (kbd "C-c +") 'image-increase-size)
(global-set-key (kbd "C-c g") 'magit-file-dispatch)
(global-set-key (kbd "C-c z") 'zeal-at-point)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c n") 'avy-goto-char)
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "C-x w") 'elfeed)
(global-set-key (kbd "<f8>") 'treemacs-projectile)
(global-set-key (kbd "S-<f8>") 'treemacs)
(global-set-key [f6] 'lsp-describe-thing-at-point)
;; (global-set-key (kbd "C-c C-g") 'helm-projectile-grep)
;; (global-set-key [f7] 'helm-projectile-grep)
(global-set-key (kbd "C-c C-m i") 'lsp-ui-imenu)
(global-set-key (kbd "C-c C-m I") 'lsp-ui-imenu--kill)
(global-set-key (kbd "C-c C-m l") 'lsp-command-map)
(global-set-key (kbd "C-c C-a") 'lsp-ui-sideline-apply-code-actions)
(global-set-key (kbd "C-c C-m g") 'haskell-hoogle)
(global-set-key (kbd "C-c w") 'haskell-hoogle-lookup-from-website)
(global-set-key (kbd "C-c h") 'haskell-hoogle-lookup-from-local)
;;
;; relie on build tool to reformat source code & refresh
(global-auto-revert-mode t)
(global-set-key (kbd "C-x k") 'kill-this-buffer)

(use-package! highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(double-mouse-1)] 'highlight-symbol-at-point)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
;;;;;;;;;;;;;;;;;
;;;; multiedit ;;;;;;;;;
;; Highlights all matches of the selection in the buffer.
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
;; incrementally add the next unmatched match.
(define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Match selected region.
(define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Insert marker at point
(define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)

;; Same as M-d but in reverse.
(define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

;; OPTIONAL: If you prefer to grab symbols rather than words, use
;; `evil-multiedit-match-symbol-and-next` (or prev).

;; Restore the last group of multiedit regions.
(define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

;; RET will toggle the region under the cursor
(define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; ...and in visual mode, RET will disable all fields outside the selected region
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; For moving between edit regions
(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)
