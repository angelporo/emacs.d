(use-package lsp-mode
  :ensure t
  :custom
  (lsp-enable-snippet t)
  (lsp-keep-workspace-alive t)
  (lsp-enable-xref t)
  (lsp-enable-imenu t)
  (lsp-enable-completion-at-point t)
  (global-set-key (kbd "M-.") 'lsp-ui-peek-find-definitions)
  :config
  (add-hook 'typescript-mode-hook  #'lsp)
  (add-hook 'js-mode-hook  #'lsp)
  (add-hook 'js2-mode-hook  #'lsp)
  (add-hook 'js2-jsx-mode-hook  #'lsp)
  (add-hook 'web-mode-hook  #'lsp)
  (add-hook 'go-mode-hook  #'lsp)
  (add-hook 'python-mode-hook  #'lsp)
  (add-hook 'c++-mode-hook  #'lsp)
  (add-hook 'c-mode-hook  #'lsp)
  (add-hook 'rust-mode-hook  #'lsp)
  (add-hook 'html-mode-hook  #'lsp)
  (add-hook 'json-mode-hook  #'lsp)
  (add-hook 'yaml-mode-hook  #'lsp)
  (add-hook 'dockerfile-mode-hook  #'lsp)
  (add-hook 'shell-mode-hook  #'lsp)
  (add-hook 'css-mode-hook  #'lsp)

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "javascript")
                    :major-modes '(typescript-mode)
                    :server-id 'javascript))

  (defvar lsp-language-id-configuration
    '(
      (python-mode . "python")
      (web-mode . "javascript")
      (typescript-mode . "javascript")
      (jsx-mode . "javascript")
      (js-jsx-mode . "javascript")
      (js2-mode . "javascript")
      (js2-jsx-mode . "javascript")
      (html-mode . "html")
      (css-mode . "css")
      (less-css-mode . "css")
      ))
  (add-to-list 'lsp-language-id-configuration '(js-mode . "javascript"))
  (add-to-list 'exec-path "./node_modules/.bin")
  (with-eval-after-load 'lsp-mode
    (lsp-completion--enable)
    (setq lsp-modeline-diagnostics-scope :project)
    (setq lsp-completion-provider :capf)
    (setq  lsp-idle-delay 0)
    )
  :commands lsp)



(use-package lsp-ui
  :ensure t
  :requires lsp-mode flycheck
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c i" . lsp-ui-imenu)
              )
  :hook (lsp-mode-hook . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-flycheck-enable t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-flycheck-list-position 'right)
  (lsp-ui-flycheck-live-reporting t)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-list-width 60)
  (lsp-ui-peek-peek-height 40)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-alignment 'window)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-doc-delay 0.25)
  (lsp-ui-sideline-delay 0.25)
  :config
  ;; Use lsp-ui-doc-webkit only in GUI
  (setq lsp-ui-doc-use-webkit nil)
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; emacs-lsp/lsp-ui#243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(setq lsp-prefer-capf t)

;; (use-package lsp-treemacs
;;   ;; project wide overview
;;   :commands lsp-treemacs-errors-list)

(use-package dap-mode
  :commands (dap-debug dap-debug-edit-template))

(provide 'init-lsp)
