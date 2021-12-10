;;; ../dev/workspaces/workspace-emacs/kayvan/doom.d/org.el -*- lexical-binding: t; -*-

(map! :mode org-mode-map
      "C-c SPC" #'ace-jump-mode)

(defun org-archive-done-tasks ()
  "Archive done tasks in the current org mode file"
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'tree))

; hook into archiving items in org mode and save org
; buffers. otherwise, archive files don't automatically get saved and
; are easy to forget about
(advice-add 'org-archive-subtree-default :after #'org-save-all-org-buffers)

;; org markdown supports strikethrough with + characters
(sp-local-pair 'org-mode "+" "+")

(setq org-directory "~/Documents/org/")
(setq org-roam-directory "~/Documents/org/roam")
(setq default-directory "~/Documents/org/notes"
      deft-extensions '("org" "txt")
      deft-recursive t)
(setq org-journal0-date-prefix "#TITLE: "
      org-journal-time-prfix "* "
      org-journal-date-prfix "%a, %Y-%m-%d"
      )
