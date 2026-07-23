;; misc conf

;; (use-package makey
;;   :ensure t)

;; (use-package discover
;;   :ensure t)

;; (global-discover-mode 1)

(use-package dired-filter
  :ensure t
  :config (dired-filter--set-prefix-key 'dired-filter-prefix "M-/"))

(defun my/set-dired-narrow-lighter ()
  (let ((current-filter
         (concat (and (boundp 'my/dired-narrow-filter-value)
                      my/dired-narrow-filter-value)
                 "/")))
    (setq-local my/dired-narrow-filter-value
                (concat current-filter dired-narrow--minibuffer-content))))

(defun my/dired-narrow-reset ()
  (when (not dired-narrow-mode)
    (makunbound 'my/dired-narrow-filter-value)))

;;narrow dired to match filter
(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow))
  :config
  (setq dired-narrow-exit-action #'my/set-dired-narrow-lighter)
  (add-hook 'dired-narrow-mode-hook 'my/dired-narrow-reset))


(use-package dired-ranger
  :ensure t)

(use-package helm-swoop 
  :ensure t
  :vc (:url https://github.com/emacsattic/helm-swoop)
  :bind
  (("C-S-s" . helm-swoop)
   ("M-i" . helm-swoop)
   ("M-s s" . helm-swoop)
   ("M-s M-s" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   )
  :config
  (progn
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
    (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop))
  )

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package cobol-mode
  :ensure t
  :config
  (setq auto-mode-alist
        (append
         '(("\\.cob\\'" . cobol-mode)
           ("\\.cbl\\'" . cobol-mode)
           ("\\.cpy\\'" . cobol-mode))
         auto-mode-alist)))

(use-package evil-textobj-entire
  :ensure t
  :config
  (define-key evil-outer-text-objects-map evil-textobj-entire-key 'evil-entire-entire-buffer)
  (define-key evil-inner-text-objects-map evil-textobj-entire-key 'evil-entire-entire-buffer))

(use-package evil-snipe
  :ensure t
  :config
  (setq evil-snipe-scope 'whole-visible)
  (setq evil-snipe-enable-highlight t)
  (setq evil-snipe-enable-incremental-highlight t)
  (evil-snipe-mode 1))

(use-package evil-easymotion
  :ensure t)

(eval-after-load 'evil-easymotion
  (lambda () (evilem-default-keybindings "SPC")
    (define-key evil-normal-state-map (kbd "SPC") nil)

    (evilem-define (kbd "SPC SPC") 'avy-goto-word-or-subword-1)
    
    (evilem-define (kbd "SPC s") 'evil-snipe-repeat
                   :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
                   :bind ((evil-snipe-scope 'buffer)
                          (evil-snipe-enable-highlight)
                          (evil-snipe-enable-incremental-highlight)))

    (evilem-define (kbd "SPC S") 'evil-snipe-repeat-reverse
                   :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
                   :bind ((evil-snipe-scope 'buffer)
                          (evil-snipe-enable-highlight)
                          (evil-snipe-enable-incremental-highlight)))

    (global-set-key (kbd "M-;") nil)
    
    (define-key evil-snipe-parent-transient-map (kbd "M-;")
                (evilem-create 'evil-snipe-repeat
                               :bind ((evil-snipe-scope 'buffer)
                                      (evil-snipe-enable-highlight)
                                      (evil-snipe-enable-incremental-highlight))))))

(use-package evil-exchange
  :ensure t
  :config
  (evil-exchange-install))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package highlight-parentheses
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'highlight-parentheses-mode)
  (add-hook 'clojure-mode-hook #'highlight-parentheses-mode)
  (add-hook 'scheme-mode-hook #'highlight-parentheses-mode))

(use-package evil-matchit
  :ensure t
  :config
  (global-evil-matchit-mode 1))

(defun my-toggle-smartparens-strict-mode ()
  (interactive)
  (if smartparens-strict-mode
      (turn-off-smartparens-strict-mode)
    (turn-on-smartparens-strict-mode))
  (message "Smartparens strict mode is %s"
           (if smartparens-strict-mode
               "on"
             "off")))

(use-package evil-cleverparens
  :ensure t
  :init
  (setq evil-cleverparens-use-additional-bindings nil)
  (setq evil-cleverparens-use-s-and-S nil)
  :config
  (add-hook 'smartparens-enabled-hook #'evil-cleverparens-mode)
  (require 'evil-cleverparens-text-objects)
  ;; ;; (evil-cp--enable-text-objects)
  ;; (setq evil-cp-additional-bindings (assoc-delete-all "M-t" evil-cp-additional-bindings))
  ;; (setq evil-cp-additional-bindings (assoc-delete-all "M-w" evil-cp-additional-bindings))
  ;; (add-to-list 'evil-cp-additional-bindings '("M-o" . sp-transpose-sexp))
  ;; (add-to-list 'evil-cp-additional-bindings '("M-p" . evil-cp-copy-paste-form))
  ;; (setq evil-cleverparens-use-additional-bindings t)
  ;; (evil-cp-set-additional-bindings)
  ;; (evil-normalize-keymaps)
  (global-set-key (kbd "C-S-q") 'my-toggle-smartparens-strict-mode))
