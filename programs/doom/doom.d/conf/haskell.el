(use-package! ormolu
  ;; :hook (haskell-mode . ormolu-format-on-save-mode)
  :bind
  ("C-c C-f" . haskell-mode-stylish-buffer)
  ("C-c C-o" . ormolu-format-buffer)
  )

(add-hook 'haskell-mode-hook #'(lambda () (eldoc-mode -1)) )

(defun shm/copy-node ()
  "Copy the current node."
  (interactive)
  (shm-kill-node nil nil nil t))

(after! shm
  (map! :map shm-map
        "C-w" #'shm/backward-kill-word
        "C-M-w" #'shm/copy-node)
  ;; Make it easier to toggle shm when it shits the bed
  ;; (defalias 'shm 'structured-haskell-mode)
  )

;; haskell files use camelcase and tend to benefit from subword movement
(add-hook! 'haskell-mode-hook #'subword-mode)
(add-hook! 'haskell-cabal-mode-hook #'subword-mode)

;; use shm by default in haskell files
;; (add-hook! 'haskell-mode-hook #'structured-haskell-mode)

;; So smartparens doesn't get confused at language pragmas
(sp-local-pair 'haskell-mode "{-#" "#-}")

;;TODO: does this stll work?
(setq haskell-auto-insert-module-format-string
      "module %s\n    ( \n    ) where")

(setq ormolu-extra-args
      '("--ghc-opt" "-XTypeApplications" "--ghc-opt" "-XBangPatterns"))
(setq-default flycheck-disabled-checkers '(haskell-stack-ghc))
;; the above and below should do the same and are redundent
(add-to-list 'flycheck-disabled-checkers 'haskell-stack-ghc)
