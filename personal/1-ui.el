;; UI
(setq prelude-whitespace nil)
(custom-set-faces `(default ((t (:height 150 :foundry "adobe" :family "Space Code Pro")))))

(setq prelude-guru nil)

;; (use-package hc-zenburn-theme
;;   :ensure t)

;; (defvar zenburn-colors-alist '())

;; (defvar zenburn-override-colors-alist
;;   '(("zenburn-fg+1"     . "#FFFFEF")
;;     ("zenburn-fg"       . "#DCDCCC")
;;     ("zenburn-fg-05"    . "#A5A888")
;;     ("zenburn-fg-1"     . "#656555")
;;     ("zenburn-bg-2"     . "#000000")
;;     ("zenburn-bg-1"     . "#101010")
;;     ("zenburn-bg-05"    . "#161616")
;;     ("zenburn-bg"       . "#242424")
;;     ("zenburn-bg+05"    . "#303030")
;;     ("zenburn-bg+1"     . "#383838")
;;     ("zenburn-bg+2"     . "#484848")
;;     ("zenburn-bg+3"     . "#585858")
;;     ;; ("zenburn-bg-2"     . "#000000")
;;     ;; ("zenburn-bg-1"     . "#2B2B2B")
;;     ;; ("zenburn-bg-05"    . "#383838")
;;     ;; ("zenburn-bg"       . "#3F3F3F")
;;     ;; ("zenburn-bg+05"    . "#494949")
;;     ;; ("zenburn-bg+1"     . "#4F4F4F")
;;     ;; ("zenburn-bg+2"     . "#5F5F5F")
;;     ;; ("zenburn-bg+3"     . "#6F6F6F")
;;     ("zenburn-red+1"    . "#DCA3A3")
;;     ("zenburn-red"      . "#CC9393")
;;     ("zenburn-red-1"    . "#BC8383")
;;     ("zenburn-red-2"    . "#AC7373")
;;     ("zenburn-red-3"    . "#9C6363")
;;     ("zenburn-red-4"    . "#8C5353")
;;     ("zenburn-orange"   . "#DFAF8F")
;;     ("zenburn-yellow"   . "#F0DFAF")
;;     ("zenburn-yellow-1" . "#E0CF9F")
;;     ("zenburn-yellow-2" . "#D0BF8F")
;;     ("zenburn-green-1"  . "#5F7F5F")
;;     ("zenburn-green"    . "#7F9F7F")
;;     ("zenburn-green+1"  . "#8FB28F")
;;     ("zenburn-green+2"  . "#9FC59F")
;;     ("zenburn-green+3"  . "#AFD8AF")
;;     ("zenburn-green+4"  . "#BFEBBF")
;;     ("zenburn-cyan"     . "#93E0E3")
;;     ("zenburn-blue+1"   . "#94BFF3")
;;     ("zenburn-blue"     . "#8CD0D3")
;;     ("zenburn-blue-1"   . "#7CB8BB")
;;     ("zenburn-blue-2"   . "#6CA0A3")
;;     ("zenburn-blue-3"   . "#5C888B")
;;     ("zenburn-blue-4"   . "#4C7073")
;;     ("zenburn-blue-5"   . "#366060")
;;     ("zenburn-magenta"  . "#DC8CC3"))
;;   "List of Zenburn colors.
;; Each element has the form (NAME . HEX).

;; `+N' suffixes indicate a color is lighter.
;; `-N' suffixes indicate a color is darker.")

;; (eval-after-load 'zenburn-theme
;;   (lambda () (custom-set-faces
;;          `(magit-log-date
;;            ((t (:foreground ,(cdr (assoc "zenburn-fg-05" zenburn-colors-alist))))))
;;          `(cider-result-overlay-face
;;            ((t (:foreground ,(cdr (assoc "zenburn-green" zenburn-colors-alist)))))))))

(eval-after-load 'zenburn-theme
  (lambda ()
    (eval-after-load 'magit
      (lambda () (custom-set-faces
             `(magit-log-date
               ((t (:foreground ,(cdr (assoc "zenburn-fg-05" zenburn-override-colors-alist)))))))))))

(eval-after-load 'zenburn-theme
  (lambda ()
    (eval-after-load 'cider
      (lambda () (custom-set-faces
             `(cider-result-overlay-face
               ((t (:foreground ,(cdr (assoc "zenburn-green" zenburn-override-colors-alist)))))))))))

;; (setq prelude-theme 'hc-zenburn)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-]") nil)
(define-key evil-normal-state-map (kbd "C-]") nil)
(define-key evil-motion-state-map (kbd "C-]") nil)
(define-key evil-motion-state-map (kbd "C-o") nil)
(global-set-key (kbd "C-]") 'xref-find-definitions)
(global-set-key (kbd "C-o") 'xref-pop-marker-stack)
(eval-after-load 'elisp-slime-nav
  (lambda ()
    (define-key elisp-slime-nav-mode-map (kbd "C-]") 'elisp-slime-nav-find-elisp-thing-at-point)
    (define-key elisp-slime-nav-mode-map (kbd "C-o") 'pop-tag-mark)))


(setq frame-title-format
      '(:eval (if (buffer-file-name)
                  (abbreviate-file-name (buffer-file-name))
                "%b")))

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "M-e") 'helm-mini)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h x") 'helm-register)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)
(global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)

(global-set-key (kbd "C--") 'er/contract-region)

(use-package helm-descbinds
  :ensure t
  :config
  (helm-descbinds-mode))

;; (projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)
;; (setq projectile-switch-project-action 'projectile-commander)
(setq projectile-switch-project-action 'helm-projectile)

;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;; (global-set-key [escape] 'evil-exit-emacs-state)

(define-key helm-map (kbd "M-s") 'helm-select-action)


(custom-set-faces
 '(helm-buffer-directory ((t (:foreground "cyan")))))

(use-package spaceline
  :ensure t)

(spaceline-helm-mode)
(setq spaceline-highlight-face-func #'spaceline-highlight-face-evil-state)
(setq powerline-default-separator 'arrow)
;; (setq spaceline-workspace-numbers-unicode t)
(setq spaceline-minor-modes-separator "")
;; (setq powerline-height 15)
;;

(custom-set-faces
 '(spaceline-evil-emacs ((t (:inherit 'mode-line :foreground "#3E3D31" :background "dark orange"))))
 '(spaceline-evil-insert ((t (:inherit 'mode-line :foreground "#3E3D31" :background "DodgerBlue"))))
 '(spaceline-evil-normal ((t (:inherit 'mode-line :foreground "#3E3D31" :background "chartreuse3"))))
 '(spaceline-evil-motion ((t (:inherit 'mode-line :foreground "#3E3D31" :background "plum3"))))
 '(spaceline-evil-replace ((t (:inherit 'mode-line :foreground "#3E3D31" :background "red"))))
 '(spaceline-evil-visual ((t (:inherit 'mode-line :foreground "#3E3D31" :background "grey")))))

(use-package diminish
  :ensure t)

(diminish 'evil-snipe-local-mode " ◉")
(diminish 'highlight-parentheses-mode)
;; (diminish 'evil-cleverparens-mode " 🄒")
;; (setcdr (assq 'evil-cleverparens-mode minor-mode-alist)
;;        '((:eval
;;           (if evil-cleverparens-complete-parens-in-yanked-region
;;               "(c/b)" "(c/i)"))))

(diminish 'aggressive-indent-mode " ⇒")
(diminish 'evil-commentary-mode)
(diminish 'flycheck-mode)
(diminish 'flyspell-mode)
(diminish 'company-mode)
(diminish 'helm-mode)
(diminish 'whitespace-mode)
(diminish 'persp-mode)
(diminish 'god-mode)


(setq projectile-mode-line
      '(:eval
        (if (file-remote-p default-directory)
            ""
          (when-let ((p (projectile-project-name))
                     (p (and (not (equal p "-")) p)))
            (format "⦗%s⦘" p)))))

(diminish 'projectile-mode)

;; (diminish 'smartparens-mode " ⒫")
(eval-after-load "evil-cleverparens"
  '(diminish 'evil-cleverparens-mode))
(eval-after-load "smartparens"
  '(diminish 'smartparens-mode '(:eval (if smartparens-strict-mode "⒮" "⒫"))))
(eval-after-load "highlight-parentheses"
  '(diminish 'highlight-parentheses-mode))
(eval-after-load "evil-commentary"
  '(diminish 'evil-commentary-mode))
(eval-after-load "evil-snipe"
  '(diminish 'evil-snipe-local-mode))
(diminish 'ivy-mode)
(diminish 'super-save-mode)
(diminish 'prelude-mode)
(eval-after-load "which-key"
  '(diminish 'which-key-mode))
(diminish 'beacon-mode)
(diminish 'yas-minor-mode)
(diminish 'clj-refactor-mode)
;; (diminish 'interactive-haskell-mode " λ")
(diminish 'auto-revert-mode)
(diminish 'abbrev-mode " ⓐ")
;; (diminish 'auto-fill-function " ▤")
;; (diminish 'auto-fill-function (concat " " [#xF036]))

(diminish 'auto-fill-function (propertize (concat " " [#xF039]) 'face '(:family "FontAwesome" :height 95)))
;; (diminish 'auto-fill-function (propertize (concat " " [#xF132]) 'face '(:family "font-mfizz")))
;; (diminish 'auto-fill-function (propertize (concat " " [#xF132]) 'face '(:family "FontAwesome")))
;; (diminish 'auto-fill-function (propertize (concat " " [#xF10b]) 'face 'my/mfizz-face17))
(diminish 'mml-mode)
(diminish 'highlight-parentheses-mode)
(diminish 'orgstruct-mode " ⋯")
(diminish 'footnote-mode " [¹]")
(diminish 'orgtbl-mode " ⊟")
(diminish 'visual-line-mode " ⤾")
(eval-after-load 'dired-narrow
  '(diminish 'dired-narrow-mode))
(eval-after-load 'hungry-delete
  '(diminish 'hungry-delete-mode))

(eval-after-load 'editorconfig
  '(diminish 'editorconfig-mode))

(eval-after-load 'haskell
  '(diminish 'interactive-haskell-mode (propertize " \uf120" 'face '(:family "FontAwesome"))))

(eval-after-load 'haskell-indent
  '(diminish 'haskell-indent-mode  (propertize " \uf03c" 'face '(:family "FontAwesome" :height 90))))
;;
(custom-set-faces
 '(shm-current-face ((t (:background "gray15")))))

(use-package git-timemachine
  :ensure t)

(global-set-key (kbd "C-c h ?") 'helm-info)

(global-set-key (kbd "C-M-y") 'evil-yank)


(global-flycheck-mode -1)

(define-key dired-mode-map (kbd ",v") 'dired-ranger-paste)
(define-key dired-mode-map (kbd ",c") 'dired-ranger-copy)
(define-key dired-mode-map (kbd ",V") 'dired-ranger-move)

(global-visual-line-mode)

(spaceline-define-segment my/dired-narrow-segment
  (when (and (bound-and-true-p dired-narrow-mode) (boundp 'my/dired-narrow-filter-value))
    (propertize (concat my/dired-narrow-filter-value "/") 'face 'mode-line-buffer-id))
  :when active)

(spaceline-define-segment major-mode
  "The name of the major mode - modified for fancy symbols"
  (cond
   ((eq major-mode 'haskell-mode)
    (propertize "\uf129" 'face `(:inherit ,default-face :family "font-mfizz" :height 90)))
   ((eq major-mode 'haskell-interactive-mode)
    (concat (propertize "\uf129 " 'face `(:inherit ,default-face :family "font-mfizz" :height 90))
            (propertize "\uf120 " 'face `(:inherit ,default-face :family "FontAwesome"))))
   ((eq major-mode 'clojure-mode)
    (propertize "\uf110" 'face `(:inherit ,default-face :family "font-mfizz" :height 120)))
   ((eq major-mode 'cider-repl-mode)
    (concat (propertize "\uf110 " 'face `(:inherit ,default-face :family "font-mfizz" :height 120))
            (propertize "\uf120 " 'face `(:inherit ,default-face :family "FontAwesome"))))
   (t (powerline-major-mode))))

;; replace erc with circe in spaceline
(spaceline-define-segment erc-track
  (when (bound-and-true-p tracking-mode)
    tracking-mode-line-buffers))

(spaceline-spacemacs-theme 'projectile-root 'my/dired-narrow-segment)


(defun my/switch-to-scratch () (interactive) (switch-to-buffer "*scratch*"))
(defun my/next-buffer-right ()
  (interactive)
  (let ((w (split-window-right)))
    (switch-to-next-buffer w)))
(defun my/next-buffer-below ()
  (interactive)
  (let ((w (split-window-below)))
    (switch-to-next-buffer w)))
(defun my/next-window () (interactive) (other-window 1))
(defun my/prev-window ()(interactive) (other-window -1))

(defun my/delete-next-window ()
  (interactive)
  (let ((this (selected-window))
        (next (next-window)))
    (unless (eq this next)
      (delete-window next))))

(defun my/delete-prev-window ()
  (interactive)
  (let ((this (selected-window))
        (prev (previous-window)))
    (unless (eq this prev)
      (delete-window prev))))

;; TODO: alternate buffer with no evil dependency
;; (global-set-key (kbd "<f3>") 'delete-window)
(global-set-key (kbd "M-<f12>") 'my/other-window-kill-buffer)
(global-set-key (kbd "S-<f12>") 'delete-other-windows)
(global-set-key (kbd "<f12>") 'my/delete-next-window)
(global-set-key (kbd "<f11>") 'split-window-right)
(global-set-key (kbd "S-<f11>") 'split-window-below)
(global-set-key (kbd "S-<f3>") 'kill-this-buffer)
(global-set-key (kbd "M-<f3>") 'my/switch-to-scratch)
(global-set-key (kbd "<f8>") 'switch-to-next-buffer)
(global-set-key (kbd "M-<f8>") 'my/next-buffer-right)
(global-set-key (kbd "C-<f8>") 'my/next-buffer-below)
(global-set-key (kbd "<f7>") 'switch-to-prev-buffer)
;; (global-set-key (kbd "C-<tab>") 'my/next-window)
;; (global-set-key (kbd "C-S-<tab>") 'my/prev-window)
(global-set-key (kbd "<f9>") 'my/next-window)
(global-set-key (kbd "S-<f9>") 'my/prev-window)
(global-set-key (kbd "C-<f9>") 'switch-window)

(defun my/switch-to-scratch-buffer-other-frame ()
  (interactive)
  (let ((buf (get-buffer-create "*scratch*")))
    (switch-to-buffer-other-frame buf)))

(defun my/switch-to-scratch-buffer-other-window ()
  (interactive)
  (let ((buf (get-buffer-create "*scratch*")))
    (switch-to-buffer-other-window buf)))

;; https://emacs.stackexchange.com/questions/3245/kill-buffer-prompt-with-option-to-diff-the-changes
(defun my/kill-this-buffer ()
  (interactive)
  (catch 'quit
    (save-window-excursion
      (let (done)
        (when (and buffer-file-name (buffer-modified-p))
          (while (not done)
            (let ((response (read-char-choice
                             (format "Save file %s? (y, n, d, q) " (buffer-file-name))
                             '(?y ?n ?d ?q))))
              (setq done (cond
                          ((eq response ?q) (throw 'quit nil))
                          ((eq response ?y) (save-buffer) t)
                          ((eq response ?n) (set-buffer-modified-p nil) t)
                          ((eq response ?d) (diff-buffer-with-file) nil))))))
        (kill-buffer (current-buffer))))))

(defun my/delete-frame-but-last ()
  (interactive)
  (unless (and (display-graphic-p) (equal 1 (length (frames-on-display-list))))
    (my/kill-this-buffer)
    (delete-frame)))

(global-set-key (kbd "C-<f11>") 'my/switch-to-scratch-buffer-other-frame)
(global-set-key (kbd "M-<f11>") 'my/switch-to-scratch-buffer-other-window)
(global-set-key (kbd "M-<f3>") 'my/delete-frame-but-last)
(global-set-key (kbd "<f3>") 'delete-window)
;; (global-set-key (kbd "C-<f3>") 'my/delete-frame-but-last)

(define-key dired-mode-map (kbd "C-x C-q") nil)

(define-key dired-mode-map (kbd "C-6") nil)

(global-set-key (kbd "M-A") 'helm-M-x)
(global-set-key (kbd "M-S-<return>") 'helm-M-x)

(define-key dired-mode-map "f" 'dired-goto-file)
(define-key dired-mode-map "+" 'dired-create-empty-file)
(define-key dired-mode-map "k" 'dired-previous-line)
(define-key dired-mode-map "j" 'dired-next-line)
(define-key dired-mode-map (kbd "C-k") 'dired-do-kill-lines)
(define-key dired-mode-map "h" 'dired-up-directory)
(define-key dired-mode-map "l" 'dired-open-file)
;; (define-key dired-mode-map (kbd "SPC") 'dired-find-alternate-file)
;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(evil-leader/set-key "j" 'dired-jump)
(define-key dired-mode-map "q" 'dired-jump)
(define-key dired-mode-map ",j" 'dired-jump)
(define-key dired-mode-map ",B" 'helm-mini)
(define-key dired-mode-map ",s" 'helm-do-grep-ag)
(define-key dired-mode-map ",1" 'delete-other-windows)
(define-key dired-mode-map ",0" 'delete-window)
(define-key dired-mode-map ",g" 'magit-status)
(define-key dired-mode-map ",l" 'helm-projectile-switch-project)
;; (define-key dired-mode-map ",b" 'helm-projectile-switch-to-buffer)
(define-key dired-mode-map ",b" 'helm-projectile)
(define-key dired-mode-map ",f" 'helm-projectile-find-file)
(define-key dired-mode-map ",=" 'dired-create-directory)
;; (define-key dired-mode-map ",d" 'helm-projectile-find-dir)
(define-key dired-mode-map ",r" 'helm-recentf)
(define-key dired-mode-map ",/" 'helm-find)
(define-key dired-mode-map ";" 'god-execute-with-current-bindings)

(defun iterm-goto-filedir-or-home-new-tab ()
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell current window\n"
    "     create tab with default profile\n"
    "       tell current session\n"
    (format "      write text \"cd %s\" \n" (or default-directory "~"))
    "       end tell\n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n")))

(defun iterm-goto-filedir-or-home-current-tab ()
  (interactive)
  (do-applescript
   (concat
    " tell application \"iTerm2\"\n"
    "   tell current window\n"
    "       tell current session\n"
    (format "      write text \"cd %s\" \n" (or default-directory "~"))
    "       end tell\n"
    "   end tell\n"
    " end tell\n"
    " do shell script \"open -a iTerm\"\n")))

(evil-leader/set-key "t" 'iterm-goto-filedir-or-home-current-tab)
(evil-leader/set-key "T" 'iterm-goto-filedir-or-home-new-tab)
(define-key dired-mode-map (kbd ",t") 'iterm-goto-filedir-or-home-current-tab)
(define-key dired-mode-map (kbd ",T") 'iterm-goto-filedir-or-home-new-tab)

;; (define-key evil-normal-state-map (kbd ";") 'helm-mini)
;; (define-key dired-mode-map (kbd ";") 'helm-mini)

(evil-leader/set-key "d" 'dired)
(define-key dired-mode-map (kbd ",d") 'dired)

(evil-leader/set-key "D" 'dired-other-tab)
(define-key dired-mode-map (kbd ",D") 'dired-other-tab)

(evil-leader/set-key "x" 'helm-M-x)
(define-key dired-mode-map (kbd ",x") 'helm-M-x)

(global-set-key (kbd "M-c") 'easy-kill)

(define-key evil-normal-state-map (kbd "M-/") 'evil-commentary-line)
(define-key evil-visual-state-map (kbd "M-/") 'evil-commentary)

(evil-leader/set-key "F" 'helm-find-files)
(define-key dired-mode-map (kbd ",F") 'helm-find-files)

(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)

(global-set-key (kbd "M-t") 'tab-new)
(define-key evil-normal-state-map (kbd "M-t") 'tab-new)
(global-set-key (kbd "M-w") 'tab-close)
(define-key evil-normal-state-map (kbd "M-w") 'tab-close)
(global-set-key (kbd "C-<tab>") 'tab-next)
(global-set-key (kbd "C-S-<tab>") 'tab-previous)
(global-set-key (kbd "C-.") 'tab-next)
(define-key evil-normal-state-map (kbd "C-.") nil)
(global-set-key (kbd "C-,") 'tab-previous)
(global-set-key (kbd "C-<escape>") 'tab-bar-select-tab-by-name)
(global-set-key (kbd "C-`") 'tab-bar-select-tab-by-name)
(global-set-key (kbd "C-\\") 'tab-bar-select-tab-by-name)
(eval-after-load 'magit
  '(define-key magit-status-mode-map (kbd "C-<tab>") nil))
(tab-bar-history-mode)
;; (setq tab-bar-show nil)
(setq tab-bar-new-tab-choice "*scratch*")


(desktop-save-mode 1)

(eval-after-load 'cobol-mode
  (lambda ()
    (define-key cobol-mode-map (kbd "M-r") 'cobol-column-ruler)))

(add-hook 'cobol-mode-hook
          (lambda () (smartparens-mode -1)))
(evil-define-key 'normal evil-smartparens-mode-map "s" nil)
(evil-define-key 'normal evil-smartparens-mode-map "S" nil)

(evil-define-key 'normal evil-cleverparens-mode-map (kbd "M-y") nil)
(evil-define-key 'normal evil-cleverparens-mode-map (kbd "M-c") nil)
(evil-define-key 'normal evil-cleverparens-mode-map (kbd "M-Y") nil)

(evil-normalize-keymaps)


(defun remove-dos-eol ()
  "Hide ^M for mixed UNIX/DOS line endings"
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(global-set-key (kbd "C-l") 'remove-dos-eol)

(setq display-raw-bytes-as-hex 1)

(defun prelude-tip-of-the-day ())

(add-to-list 'evil-emacs-state-modes 'inferior-ess-mode)
(add-to-list 'evil-emacs-state-modes 'cider-repl-mode)
(add-to-list 'evil-emacs-state-modes 'cider-stacktrace-mode)
(add-to-list 'evil-emacs-state-modes 'cider-test-report-mode)
;; (add-to-list 'evil-emacs-state-modes 'magit-status-mode)
;; (add-to-list 'evil-motion-state-modes 'magit-status-mode)
;; (add-to-list 'evil-emacs-state-modes 'org-agenda-mode)
(add-to-list 'evil-emacs-state-modes 'cider-docview-mode)
(add-to-list 'evil-emacs-state-modes 'haskell-presentation-mode)
(add-to-list 'evil-emacs-state-modes 'haskell-interactive-mode)
(add-to-list 'evil-emacs-state-modes 'haskell-error-mode)
(add-to-list 'evil-emacs-state-modes 'makey-key-mode)
(add-to-list 'evil-emacs-state-modes 'eshell-mode)
(add-to-list 'evil-emacs-state-modes 'tuareg-interactive-mode)
(add-to-list 'evil-emacs-state-modes 'dired-mode)
(add-to-list 'evil-emacs-state-modes 'cider-inspector-mode)
(add-to-list 'evil-emacs-state-modes 'cider-macroexpansion-mode)
(add-to-list 'evil-emacs-state-modes 'diff-mode)
(add-to-list 'evil-emacs-state-modes 'sx-question-mode)
(add-to-list 'evil-emacs-state-modes 'sx-question-list-mode)
(add-to-list 'evil-emacs-state-modes 'sx-inbox-mode)
(add-to-list 'evil-emacs-state-modes 'sx-compose-mode)
;; (add-to-list 'evil-emacs-state-modes 'notmuch-message-mode)
;; (add-to-list 'evil-emacs-state-modes 'notmuch-tree-mode)
(delete 'notmuch-search-mode evil-emacs-state-modes)
(delete 'notmuch-message-mode evil-emacs-state-modes)
(delete 'notmuch-tree-message-mode evil-emacs-state-modes)
(delete 'notmuch-show-mode evil-emacs-state-modes)
;; (add-to-list 'evil-emacs-state-modes 'notmuch-hello-mode)
;; (add-to-list 'evil-emacs-state-modes 'fundamental-mode)
(add-to-list 'evil-emacs-state-modes 'eshell-mode)
(add-to-list 'evil-emacs-state-modes 'shell-mode)
(add-to-list 'evil-emacs-state-modes 'calendar-mode)
(add-to-list 'evil-emacs-state-modes 'process-menu-mode)
(add-to-list 'evil-emacs-state-modes 'Info-mode)
(add-to-list 'evil-emacs-state-modes 'skype--member-mode)
(add-to-list 'evil-emacs-state-modes 'skype--message-mode)
(add-to-list 'evil-emacs-state-modes 'skype--chat-mode)
(add-to-list 'evil-emacs-state-modes 'sql-interactive-mode)
(add-to-list 'evil-emacs-state-modes 'utop-mode)
(add-to-list 'evil-emacs-state-modes 'circe-channel-mode)
(add-to-list 'evil-emacs-state-modes 'circe-chat-mode)
(add-to-list 'evil-emacs-state-modes 'circe-query-mode)
(add-to-list 'evil-emacs-state-modes 'circe-server-mode)
(add-to-list 'evil-emacs-state-modes 'xwidget-webkit-mode)
(add-to-list 'evil-emacs-state-modes 'inferior-js-mode)
(add-to-list 'evil-emacs-state-modes 'skewer-repl-mode)
(add-to-list 'evil-emacs-state-modes 'aws-instances-mode)
(delete 'Info-mode evil-motion-state-modes)
(delete 'eshell-mode evil-insert-state-modes)
(delete 'shell-mode evil-insert-state-modes)
