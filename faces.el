;;; package --- Summary
;;; Commentary:
;;; Code:

(add-hook 'flycheck-color-mode-line-hook '(set-face-attribute 'flycheck-color-mode-line-error-face t :inherit 'flycheck-fringe-error :box t :line-width 2 :color "red" :style 'released-button))
(add-hook 'flycheck-color-mode-line-hook '(set-face-attribute 'flycheck-color-mode-line-warning-face t :inherit 'flycheck-fringe-warning :box t :line-width 2 :color "orange" :style 'released-button))
(eval-after-load 'ecb '(set-face-attribute 'ecb-analyse-bucket-element-face t :inherit 'ecb-analyse-general-face :foreground "gold"))
(eval-after-load 'ecb '(set-face-attribute 'ecb-bucket-node-face t :inherit 'ecb-default-general-face :foreground "#FF6E27" :weight 'normal))
(eval-after-load 'ecb '(set-face-attribute 'ecb-default-highlight-face t :background "#FF6E27" :foreground "white smoke"))
(eval-after-load 'ecb '(set-face-attribute 'ecb-methods-general-face t :foreground "#FF6E27" :height 1.0))
(eval-after-load 'ecb '(set-face-attribute 'ecb-mode-line-data-face t :foreground "#FF6E27"))
(eval-after-load 'ecb '(set-face-attribute 'ecb-mode-line-prefix-face t :foreground "#FF6E27"))
(eval-after-load 'ecb '(set-face-attribute 'ecb-tag-header-face t :background "#FF6E27"))
(eval-after-load 'magit '(set-face-attribute 'magit-branch-local t :foreground "orange"))
(eval-after-load 'magit '(set-face-attribute 'magit-branch-remote t :foreground "#D90F5A"))
(eval-after-load 'magit '(set-face-attribute 'magit-diff-removed t :background "#000000" :foreground "orange red"))
(eval-after-load 'magit '(set-face-attribute 'magit-diff-removed-highlight t :background "#3C3D37" :foreground "orange red"))
(eval-after-load 'magit '(set-face-attribute 'magit-filename t :foreground "#F34739" :weight 'normal))
(eval-after-load 'magit '(set-face-attribute 'magit-hash t :foreground "#FF6E27"))
(eval-after-load 'magit '(set-face-attribute 'magit-log-author t :foreground "orange"))
(eval-after-load 'magit '(set-face-attribute 'magit-log-date t :foreground "#FF6E27"))
(eval-after-load 'magit '(set-face-attribute 'magit-log-graph t :foreground "#75715E"))
(eval-after-load 'magit '(set-face-attribute 'magit-section-heading t :foreground "#FF6E27" :weight 'bold))
(eval-after-load 'magit '(set-face-attribute 'magit-section-highlight t :background "gray9"))
(eval-after-load 'magit '(set-face-attribute 'magit-tag t :foreground "orange" :weight 'bold))
(eval-after-load 'neotree '(set-face-attribute 'neo-banner-face t :background "#000000" :foreground "#F34739" :weight 'bold))
(eval-after-load 'neotree '(set-face-attribute 'neo-dir-link-face t :foreground "#FF6E27"))
(eval-after-load 'neotree '(set-face-attribute 'neo-root-dir-face t :background "#000000" :foreground "gold"))
(eval-after-load 'pass '(set-face-attribute 'pass-mode-directory-face t :foreground "#FF6E27" :weight 'bold))
(eval-after-load 'pass '(set-face-attribute 'pass-mode-entry-face t))
(set-face-attribute 'cursor t :background "#FE8B05" :foreground "white smoke" :inverse-video t)
(set-face-attribute 'default t :background "#000000" :foreground "#F8F8F2" :weight 'bold :height 110 :family "Ubuntu Mono")
(set-face-attribute 'flycheck-error t :underline "#F92672")
(set-face-attribute 'highlight t :background "black" :foreground "white")
(set-face-attribute 'ido-first-match t :foreground "#FF6E27" :weight 'bold)
(set-face-attribute 'ido-incomplete-regexp t :foreground "DeepPink1" :weight 'bold)
(set-face-attribute 'ido-indicator t :background "#FF6E27" :foreground "#000000" :width 'condensed)
(set-face-attribute 'ido-only-match t :background "#FF6E27" :foreground "white smoke" :weight 'bold)
(set-face-attribute 'ido-subdir t :foreground "#F34739")
(set-face-attribute 'ido-virtual t :foreground "#FF6E27")
(set-face-attribute 'iedit-occurrence t :foreground "green yellow")
(set-face-attribute 'minibuffer-prompt t :foreground "#FF6E27")
(set-face-attribute 'mode-line t :background "gray9" :foreground "#F8F8F0" :slant 'normal)
(set-face-attribute 'mode-line-buffer-id t :foreground "white smoke" :weight 'bold)
(set-face-attribute 'mode-line-inactive t :background "#000000" :box nil :foreground "#75715E")
(set-face-attribute 'nlinum-current-line t :foreground "#FF6E27" :slant 'normal :weight 'bold)
(set-face-attribute 'package-name t :foreground "#FF6E27")
(set-face-attribute 'powerline-active0 t :background "#F34739")
(set-face-attribute 'powerline-active1 t :background "#FF6E27" :foreground "white smoke" :weight 'bold)
(set-face-attribute 'powerline-active2 t :background "gray9" :foreground "#FF6E27")
(set-face-attribute 'whitespace-line t)
(set-face-attribute 'whitespace-newline t)
(set-face-attribute 'whitespace-space t)
(set-face-attribute 'whitespace-tab t :foreground "#FD971F" :weight 'bold)
(set-face-attribute 'whitespace-trailing t :foreground "orange" :inverse-video t)

(provide 'faces)
;;; faces.el ends here
