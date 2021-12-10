;;(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
;;(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)


;; optionally
(use-package! lsp-ui
  :commands
  (lsp-ui-mode)
  :custom
  (lsp-ui-doc--display 2 )
  ;;(lsp-ui-peek-jump-backward) (lsp-ui-peek-jump-forward)
  )

;; if you are helm user
;; (use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;; (use-package! lsp-ivy :commands (lsp-ivy-workspace-symbol) )
(use-package! lsp-treemacs :commands (lsp-treemacs-errors-list) )

;; optionally if you want to use debugger
(use-package dap-mode)
(use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package! which-key
  :config
  (which-key-mode))

(use-package! lsp-mode
  :commands (lsp lsp-execute-code-action)
  :hook ((go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-diagnostics-modeline-mode))
  :bind ("C-c C-c" . 'lsp-execute-code-action)
  :custom
  (lsp-diagnostics-modeline-scope :project)
  (lsp-file-watch-threshold 5000)
  (lsp-response-timeout 1)
  (lsp-enable-file-watchers nil))

(use-package! lsp-ui
  :disabled
  :custom
  (lsp-ui-doc-mode nil)
  (lsp-ui-doc-delay 0.75)
  (lsp-ui-doc-max-height 200)
  (lsp-ui-peek-always-show nil)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-show-hover nil)
  :after lsp-mode)

(use-package! lsp-ivy
  :after (ivy lsp-mode))

(use-package! company-lsp
  :disabled
  :custom (company-lsp-enable-snippet t)
  :after (company lsp-mode))


(setq lsp-lens-enable t)
(evil-define-key 'normal lsp-mode-map (kbd "\\") lsp-command-map)
