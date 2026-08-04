(use-package ellama
  :ensure t
  :demand t
  :bind ("C-c e" . ellama)
  :hook (org-ctrl-c-ctrl-c-hook . ellama-chat-send-last-message)
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
          (make-llm-ollama
           :chat-model "qwen3.6:35b"
           :embedding-model "nomic-embed-text"))
  :config
  ;; Agent defaults for long coding sessions: enable tools, compact old
  ;; context, show sub-agent buffers, enforce DLP, block irreversible actions,
  ;; and give agent loops enough steps to finish real work.
  (ellama-setup-agentic-coding)

  ;; With an srt policy, normal tool confirmations are skipped, ordinary DLP
  ;; input findings are allowed, output findings are redacted, and
  ;; irreversible actions are still blocked.  Without SRT, confirmations stay
  ;; active and ordinary DLP input/output findings ask first.
  ;; (ellama-setup-agentic-coding
  ;;  "~/.config/ellama/srt-autonomous.json")

  (ellama-context-header-line-global-mode t)
  (ellama-session-header-line-global-mode 11)

  (define-key dired-mode-map (kbd ",e") 'ellama)
  (evil-leader/set-key "e" 'ellama))
