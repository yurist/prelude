;; evil

(use-package evil-leader
  :ensure t)
(global-evil-leader-mode)
(evil-leader/set-leader ",")


(defmacro my/evil-let-minor-keybindings
    (file mode-map mode-hook)
  `(eval-after-load ',file
     '(progn
        (evil-make-overriding-map ,mode-map 'normal)
        (add-hook ',mode-hook #'evil-normalize-keymaps))))

(my/evil-let-minor-keybindings
 flycheck flycheck-error-list-mode-map flycheck-error-list-mode-hook)

;; (add-to-list 'evil-motion-state-modes 'magit-status-mode)

(my/evil-let-minor-keybindings
 magit magit-status-mode-map magit-status-mode-hook)

(my/evil-let-minor-keybindings
 notmuch notmuch-search-mode-map notmuch-search-hook)

(my/evil-let-minor-keybindings
 notmuch notmuch-message-mode-map notmuch-message-mode-hook)

(my/evil-let-minor-keybindings
 notmuch notmuch-tree-mode-map notmuch-tree-command-hook)

(my/evil-let-minor-keybindings
 notmuch notmuch-show-mode-map notmuch-show-command-hook)

(my/evil-let-minor-keybindings
 helm-grep helm-grep-mode-map helm-grep-mode-hook)

(my/evil-let-minor-keybindings
 djvu djvu-read-mode-map djvu-read-mode-hook)

(my/evil-let-minor-keybindings
 pdf-occur pdf-occur-buffer-mode-map pdf-occur-buffer-mode-hook)

(my/evil-let-minor-keybindings
 org-agenda org-agenda-mode-map org-agenda-mode-hook)

(my/evil-let-minor-keybindings
 clojure-mode clojure-mode-map clojure-mode-hook)

(define-key evil-normal-state-map (kbd "M-.") nil)
(define-key evil-normal-state-map (kbd "M-,") nil)


(evil-leader/set-key "w" 'save-buffer)
(evil-leader/set-key "B" 'helm-mini)
(evil-leader/set-key "W" 'switch-to-buffer-other-window)
(evil-leader/set-key "s" 'helm-do-grep-ag)
(evil-leader/set-key "o" 'helm-swoop)
(evil-leader/set-key "i" 'helm-semantic-or-imenu)
(evil-leader/set-key "1" 'delete-other-windows)
(evil-leader/set-key "0" 'delete-window)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "l" 'helm-projectile-switch-project)
;; (evil-leader/set-key "b" 'helm-projectile-switch-to-buffer)
(evil-leader/set-key "b" 'helm-projectile)
(evil-leader/set-key "f" 'helm-projectile-find-file)
;; (evil-leader/set-key "D" 'helm-projectile-find-dir)
(evil-leader/set-key "r" 'helm-recentf)



(evil-define-key 'normal evil-commentary-mode-map "gc" 'evil-commentary)
(evil-define-key 'visual evil-commentary-mode-map "gc" 'evil-commentary)
