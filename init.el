;;; package --- Summary
;;; Commentary:
;;; Code:

(package-initialize)
(load "~/.emacs.d/init-packages")
(load "~/.emacs.d/require")
(load "~/.emacs.d/alias")
(load "~/.emacs.d/automode")
(load "~/.emacs.d/hooks")
(load "~/.emacs.d/shortcuts")

;; Global settings


(defvar ido-enable-flex-matching)
(defvar dumb-jump-prefer-searcher)
(defvar yas-prompt-functions)
(defvar path-to-ctags)

(setq auto-window-vscroll nil)
(setq inhibit-startup-message t) ;; Disable startup messages
(setq make-backup-files nil) ;; No backup files ~
(setq auto-save-default nil) ;; Stop creating auto #autosave# files
(setq ido-enable-flex-matching t)
(setq frame-resize-pixelwise t)
(setq dumb-jump-prefer-searcher 'rg)
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq indent-line-function 'insert-tab)
(setq path-to-ctags "/usr/bin/ctags") ;; <- your ctags path here
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq yas-prompt-functions '(yas-dropdown-prompt
                             yas-ido-prompt
                             yas-completing-prompt))

(setq-default kill-read-only-ok t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; Maximize window at startup
(tool-bar-mode -1) ;; Hide toolbar
(scroll-bar-mode -1) ;; Hide scrollbar
(menu-bar-mode -1) ;; Hide menubar
(column-number-mode 1) ;; Show column number
(global-linum-mode 1) ;; Show line-number
(global-auto-complete-mode t) ;; Enable auto-complete
(global-highlight-parentheses-mode t)
(powerline-default-theme)
(put 'upcase-region 'disabled nil)
(yas-global-mode 1)
(ido-mode 1)
(dumb-jump-mode 1) ;dumb-jump
(savehist-mode 1)
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup))
(put 'downcase-region 'disabled nil)
(set-default 'case-fold-search nil) ; Case sensitive TAGS search
(global-diff-hl-mode)
(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t) ; Geben
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)



;; Functions
(defun get-point (symbol &optional arg)
  "Get the point.
SYMBOL.
ARG."
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "Copy thing between beg & end into kill ring.
BEGIN-OF-THING.
END-OF-THING.
ARG."
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end)))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
         (lambda()
           (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
            nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))

(defun copy-word (&optional arg)
  "Copy words at point into ‘kill-ring’.
ARG."
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  (message "Copying word at point into kill-ring...")
  ;; (Paste-to-mark arg)
  )

(defun duplicate-current-line ()
  "Duplicate the current line."
  (interactive)
  (beginning-of-line nil)
  (let ((b (point)))
    (end-of-line nil)
    (copy-region-as-kill b (point)))
  (beginning-of-line 2)
  (open-line 1)
  (yank)
  (back-to-indentation))


; ctags
(defun crear-tags (dir-name)
  "Create tags file.
DIR-NAME."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -R -e --languages='php' --exclude='cache' %s" path-to-ctags dir-name (directory-file-name dir-name)))
)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %.
ARG."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(defun copy-line (&optional arg)
"Do a ‘kill-line’ but copy rather than kill.
This function directly calls ‘kill-line’, so see documentation of ‘kill-line’
for how to use it including prefix
argument and relevant variables.  This function works by temporarily making the
buffer read-only, so I suggest setting ‘kill-read-only-ok’ to t.
ARG."
  (interactive "P")
  (read-only-mode 1)
  (kill-line arg)
  (read-only-mode 0))


;; iedit
(defun iedit-dwim (arg)
  "Start iedit but use \\[narrow-to-defun] to limit its scope.
ARG."
  (interactive "P")
  (if arg
      (iedit-mode)
    (save-excursion
      (save-restriction
        (widen)
        ;; this function determines the scope of `iedit-start'.
        (if iedit-mode
            (iedit-done)
          ;; `current-word' can of course be replaced by other
          ;; functions.
          (narrow-to-defun)
          (iedit-start (current-word) (point-min) (point-max)))))))


;; Edit files as root
;; http://emacsredux.com/blog/2013/04/21/edit-files-as-root/
(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))

; xml-format
(defun xml-format ()
  "Xml-format."
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)
    )
  )

(custom-set-variables
 '(blink-cursor-mode t)
 '(custom-safe-themes
        (quote
         ("bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" default)))
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(flycheck-highlighting-mode (quote lines))
 '(flycheck-pycheckers-checkers (quote (pylint pep8)))
 '(global-whitespace-mode t)
 '(linum-format " %d ")
 '(linum-highlight-current-line t)
 '(linum-use-right-margin nil)
 '(monokai-background "#000000")
 '(neo-autorefresh t)
 '(neo-smart-open t)
 '(package-selected-packages
        (quote
         (yasnippet-snippets yaml-mode smarty-mode powerline linum linum-hl monokai-theme markdown-mode+ jquery-doc iedit highlight-parentheses highlight git-gutter geben flymd flycheck-color-mode-line flycheck ecb dumb-jump diff-hl company-php auto-indent-mode all-the-icons adoc-mode ac-php ac-js2 dash-functional ag)))
 '(phpcbf-standard "PSR2")
 '(powerline-default-separator (quote arrow-fade))
 '(powerline-gui-use-vcs-glyph t)
 '(size-indication-mode nil)
 '(whitespace-display-mappings (quote ((tab-mark 9 [187]))))
 '(whitespace-line-column nil)
 '(whitespace-style
        (quote
         (face trailing tabs spaces newline empty indentation space-after-tab space-before-tab space-mark tab-mark newline-mark))))

(custom-set-faces
 '(default ((t (:background "#000000" :foreground "#F8F8F2" :weight bold :height 110 :family "Ubuntu Mono"))))
 '(cursor ((t (:background "turquoise1" :foreground "white smoke" :inverse-video t))))
 '(flycheck-color-mode-line-error-face ((t (:box (:line-width 1 :color "DeepPink3") :weight bold))))
 '(flycheck-color-mode-line-info-face ((t (:box (:line-width 1 :color "turquoise1")))))
 '(flycheck-color-mode-line-success-face ((t (:box (:line-width 1 :color "turquoise1")))))
 '(flycheck-color-mode-line-warning-face ((t (:box (:line-width 1 :color "orange")))))
 '(flycheck-error ((t (:underline "#F92672"))))
 '(highlight ((t (:background "black" :foreground "white"))))
 '(ido-first-match ((t (:foreground "cyan" :weight normal))))
 '(ido-incomplete-regexp ((t (:foreground "DeepPink1" :weight bold))))
 '(ido-only-match ((t (:background "cyan" :foreground "black" :weight bold))))
 '(iedit-occurrence ((t (:foreground "green yellow"))))
 '(linum-current-line ((t (:foreground "turquoise2" :weight bold))))
 '(magit-branch-local ((t (:foreground "turquoise1"))))
 '(magit-filename ((t (:foreground "DarkOrange1" :weight normal))))
 '(magit-hash ((t (:foreground "orange"))))
 '(magit-log-author ((t (:foreground "aquamarine1"))))
 '(magit-log-date ((t (:foreground "orange"))))
 '(magit-log-graph ((t (:foreground "#75715E"))))
 '(magit-section-heading ((t (:foreground "aquamarine1" :weight bold))))
 '(magit-section-highlight ((t (:background "turquoise4"))))
 '(magit-tag ((t (:foreground "orange" :weight bold))))
 '(mode-line ((t (:background "#49483E" :foreground "#F8F8F0" :box (:line-width 1 :color "black")))))
 '(mode-line-buffer-id ((t (:foreground "white smoke" :weight bold))))
 '(mode-line-inactive ((t ("#000000" nil "#75715E" :background :box nil))))
 '(powerline-active0 ((t (:background "turquoise4"))))
 '(powerline-active1 ((t (:background "turquoise3" :foreground "gray10" :weight bold))))
 '(powerline-active2 ((t (:background "black" :foreground "turquoise1"))))
 '(trailing-whitespace ((t (:background "deep pink" :foreground "white"))))
 '(whitespace-line ((t nil)))
 '(whitespace-newline ((t nil)))
 '(whitespace-space ((t nil)))
 '(whitespace-tab ((t (:foreground "#FD971F" :weight bold))))
 '(whitespace-trailing ((t (:foreground "deep pink" :inverse-video t)))))

(load-theme 'monokai t)
(provide 'init)
;;; init.el ends here
