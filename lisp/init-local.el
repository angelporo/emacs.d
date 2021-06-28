(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(display-line-numbers-mode -1)


(use-package company-tabnine
  :ensure t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  (setq company-idle-delay 0.0
        company-tooltip-idle-delay 0.0
        company-show-numbers t
        company-minimum-prefix-length 1
        lsp-headerline-breadcrumb-mode t)
  )

(use-package web-mode
  :ensure t
  :mode
  ("\\.html\\'" "\\.css\\'" "\\.vue\\'" "\\.ttml\\'")
  )

;;; 提升 emacs 打开文件速度
(setq vc-handled-backends ())
(setq warning-minimum-level :emergency)

(use-package detour
  :ensure t
  :bind
  ([(control \.)] . detour-mark)
  ([(control \,)] . detour-back))


(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"                 ;; personal snippets
          ))
  (yas-global-mode t)
  ;; (define-key global-map (kbd "<tab>") 'company-yasnippet)
  (yas-reload-all)
  (setq yas-prompt-functions '(yas-ido-prompt))
  (defun help/yas-after-exit-snippet-hook-fn ()
    (prettify-symbols-mode)
    (prettify-symbols-mode))
  (add-hook 'yas-after-exit-snippet-hook #'help/yas-after-exit-snippet-hook-fn)
  :diminish yas-minor-mode)

(use-package undo-tree
  :ensure t
  :defer 2
  :config
  (global-undo-tree-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;             快速查找单词        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ace-jump-mode
  :ensure t
  :defer 2
  :init
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
  )

(setq flycheck-check-syntax-automatically '(mode-enabled save))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;         逗号后面自动添加空格       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd ",")
                #'(lambda ()
                    (interactive)
                    (insert ", ")))


;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;;翻译配置---------------------------------------------------------------------
(use-package bing-dict
  :ensure t
  :defer 2
  :init
  :config
  (global-set-key (kbd "C-c b") 'bing-dict-brief)
  )

(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'emmet-mode)
  (add-hook 'js-mode-hook 'emmet-mode)
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'js2-jsx-mode-hook 'emmet-mode)
  (add-hook 'js2-mode-hook 'emmet-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;             全局按键绑定           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-f") 'right-word)
(setq-default line-spacing 0.2)

(defun my-setup-indent (n)
  ;; java/c/c++
  ;; web development
  (setq coffee-tab-width n)
  (setq javascript-indent-level n)
  (setq js-indent-level n)
  (setq typescript-indent-level n)
  (setq web-mode-markup-indent-offset n)
  (setq web-mode-css-indent-offset n)
  (setq web-mode-code-indent-offset n)
  (setq css-indent-offset n))

(my-setup-indent 2)
(global-display-line-numbers-mode -1)

;;; 修复窗口之间间隙问题
(setq frame-resize-pixelwise t)


;;; 优化搜索功能
;; (ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;; (use-package sis
;;   :ensure t
;;   :init
;;   ;; `C-s/r' 默认优先使用英文 必须在 sis-global-respect-mode 前配置
;;   (setq sis-respect-go-english-triggers
;;         (list 'isearch-forward 'isearch-backward) ; isearch-forward 命令时默认进入
;;         sis-respect-restore-triggers
;;         (list 'isearch-exit 'isearch-abort)) ; isearch-forward 恢复, isearch-exit `<Enter>', isearch-abor `C-g'
;;   :config
;;   (sis-ism-lazyman-config

;;    ;; English input source may be: "ABC", "US" or another one.
;;    ;; "com.apple.keylayout.ABC"
;;    "com.apple.keylayout.US"

;;    ;; Other language input source: "rime", "sogou" or another one.
;;    ;; "im.rime.inputmethod.Squirrel.Rime"
;;    "com.sogou.inputmethod.sogou.pinyin" ;;搜狗输入法
;;    ;; "com.apple.inputmethod.SCIM.Shuangpin" ;; 苹果自带双拼输入法
;;    )
;;   ;; enable the /cursor color/ mode 中英文光标颜色模式
;;   (sis-global-cursor-color-mode t)
;;   ;; enable the /respect/ mode buffer 输入法状态记忆模式
;;   ;; (sis-global-respect-mode t)
;;   ;; enable the /follow context/ mode for all buffers
;;   (sis-global-context-mode )
;;   ;; enable the /inline english/ mode for all buffers
;;   (sis-global-inline-mode t) ; 中文输入法状态下，中文后<spc>自动切换英文，结束后自动切回中文
;;   ;; (global-set-key (kbd "C-M-<spc>") 'sis-switch) ; 切换输入法
;;   ;; 特殊定制
;;   (setq sis-do-set
;;         (lambda(source) (start-process "set-input-source" nil "macism" source "50000")))
;;   (setq sis-default-cursor-color "#E55D9C" ; 英文光标色
;;         sis-other-cursor-color "#FF2121" ; 中文光标色
;;         ;; sis-inline-tighten-head-rule 'all ; 删除头部空格，默认1，删除一个空格，1/0/'all
;;         sis-inline-tighten-tail-rule 'all ; 删除尾部空格，默认1，删除一个空格，1/0/'all
;;         sis-inline-with-english t ; 默认是t, 中文context下输入<spc>进入内联英文
;;         sis-inline-with-other t) ; 默认是nil，而且prog-mode不建议开启, 英文context下输入<spc><spc>进行内联中文
;;   ;; 特殊 buffer 禁用 sis 前缀,使用 Emacs 原生快捷键  setqsis-prefix-override-buffer-disable-predicates
;;   (setq sis-prefix-override-buffer-disable-predicates
;;         (list 'minibufferp
;;               (lambda (buffer) ; magit revision magit的keymap是基于text property的，优先级比sis更高。进入 magit 后，disable sis 的映射
;;                 (sis--string-match-p "^magit-revision:" (buffer-name buffer)))
;;               (lambda (buffer) ; special buffer，所有*打头的buffer，但是不包括*Scratch* *New, *About GNU等buffer
;;                 (and (sis--string-match-p "^\*" (buffer-name buffer))
;;                      (not (sis--string-match-p "^\*About GNU Emacs" (buffer-name buffer))) ; *About GNU Emacs" 仍可使用 C-h/C-x/C-c 前缀
;;                      (not (sis--string-match-p "^\*New" (buffer-name buffer)))
;;                      (not (sis--string-match-p "^\*Scratch" (buffer-name buffer))))))) ; *Scratch*  仍可使用 C-h/C-x/C-c 前缀
;;   )


(add-to-list 'auto-mode-alist '("\\.ttss" . css-mode))
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))
;;; init-javascript.el ends here
;;; 默认使用
(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.css" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss" . css-mode))
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

;; (add-hook 'typescript-mode-hook 'prettier-js-mode)
;; (add-hook 'js-mode-hook 'prettier-js-mode)
;; (add-hook 'css-mode-hook 'prettier-js-mode)
;; (add-hook 'less-css-mode-hook 'prettier-js-mode)
;; (add-hook 'js2-mode-hook 'prettier-js-mode)
;; (add-hook 'js2-jsx-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)


(add-hook 'web-mode-hook (lambda ()
                           (flycheck-mode -1)
                           ))
;;; 默认启动 magit 加快使用速度
(global-auto-revert-mode t)

;; allow editing file permissions
;;; 开启 dired 修改文件权限功能
(setq wdired-allow-to-change-permissions t)

;;; 谷歌翻译
(use-package go-translate
  :ensure t
  :commands (go-translate go-translate-popup)
  :bind
  ("C-c t" . go-translate)
  ("C-c T" . go-translate-popup)
  :config
  (setq go-translate-base-url "https://translate.google.cn")
  (setq go-translate-local-language "zh-CN")
  (setq go-translate-buffer-follow-p t)

  (setq go-translate-inputs-function
        #'go-translate-inputs-current-or-prompt)
  (defun go-translate-token--extract-tkk ()
    (cons 430675 2721866130))
  ;; (setq go-translate-buffer-folow-p t)
  )

(provide 'init-local)
