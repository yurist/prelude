;; install required inheritenv dependency:
(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

;; install claude-code.el
(use-package claude-code :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  ;; optional IDE integration with Monet
  ;; (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
  ;; (monet-mode 1)
  ;; Use vterm:
  (setq claude-code-terminal-backend 'vterm)

  
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map)

  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))

(with-eval-after-load 'claude-code
  (define-key dired-mode-map (kbd ",c") claude-code-command-map)
  (evil-leader/set-key "c" claude-code-command-map))
