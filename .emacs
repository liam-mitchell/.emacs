(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background "gray10" :foreground "gray70")))))

(require 'package)
(setq url-proxy-services '(("http" . "proxy.hitachi-id.com")))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")
             t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/s.el-master")
(load "s")

(add-to-list 'load-path "~/.emacs.d/powerline-master")
(load "powerline")
(powerline-default-theme)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "environment")
(setup-environment)

(add-to-list 'load-path "~/.emacs.d/company-mode-master/")
(load "company")
(add-to-list 'load-path "~/.emacs.d/company-irony-master/")
(load "company-irony")

(add-to-list 'load-path "~/.emacs.d/flx-master/")
(load "flx-ido")

(add-to-list 'load-path "~/.emacs.d/flycheck-master/")
(load "flycheck")

(add-to-list 'load-path "~/.emacs.d/evil-evil/")
(load "evil")

(add-to-list 'load-path "~/.emacs.d/smartparens-master/")
(load "smartparens")
(load "smartparens-config")

(add-to-list 'load-path "~/.emacs.d/web-mode-master/")
(load "web-mode")

(add-to-list 'load-path "~/.emacs.d/linum-relative-master/")
(load "linum-relative")

(add-to-list 'load-path "~/.emacs.d/swiper-master/")
(load "swiper")

(add-to-list 'load-path "~/.emacs.d/irony-mode-master/")
(load "irony")

(load "sr-speedbar")
(add-hook 'speedbar-visiting-file-hook 'sr-speedbar-close)
(add-hook 'speedbar-visiting-tag-hook 'sr-speedbar-close)

(evil-ex-define-cmd "k" 'kill-this-buffer)
(evil-ex-define-cmd "kb" 'kill-old-buffers)

(define-key evil-normal-state-map "'" 'sr-speedbar-toggle)
(define-key evil-normal-state-map "\\" 'find-file-in-project)
(define-key evil-normal-state-map (kbd "<backspace>") 'pop-mark)
(define-key evil-normal-state-map (kbd "<M-backspace>") 'unpop-mark)

(setq inhibit-startup-echo-area-message "liam00")
(setq inhibit-startup-message t)
(setq w32-pipe-read-delay 0)

(setq initial-frame-alist '((font . "Source Code Pro-10")))
(setq default-frame-alist '((font . "Source Code Pro-10")))

(setq compilation-scroll-output 't)
(setq ring-bell-function 'ignore)
(setq org-log-done 'time)

(setq sp-highlight-pair-overlay nil)
(setq sp-highlight-wrap-overlay nil)
(setq sp-highlight-wrap-tag-overlay nil)

(setq indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)

(column-number-mode t)
(linum-relative-global-mode)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(evil-mode 1)
(ido-mode t)
(ido-everywhere 1)
(flx-ido-mode 1)
(smartparens-global-mode 1)
(show-smartparens-global-mode 1)
(hlinum-activate)
;; (flycheck-select-checker 'c/c++-cl)

(setq ido-enable-flex-matching t)
(setq ffip-prefer-ido-mode t)
(setq linum-format "%d|")

(defun toggle-comment ()
  "comment or uncomment region or line"
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(defun kill-dired-buffers ()
  "Kill all dired buffers open."
  (interactive)
  (mapc (lambda (buffer)
          (when (eq 'dired-mode (buffer-local-value 'major-mode buffer))
            (kill-buffer buffer)))
        (buffer-list)))

(defun kill-old-buffers ()
  "Kill all dired and ag buffers open."
  (interactive)
  (kill-dired-buffers)
  (ag-kill-other-buffers))

(defun pop-mark ()
  "Pop the top mark off the mark ring."
  (interactive)
  (set-mark-command t))

(defun unpop-mark ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
  (when mark-ring
    (let ((pos (marker-position (car (last mark-ring)))))
      (if (not (= (point) pos))
          (goto-char pos)
        (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
        (set-marker (mark-marker) pos)
        (setq mark-ring (nbutlast mark-ring))
        (goto-char (marker-position (car (last mark-ring))))))))

(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c f") 'set-face-foreground)
(global-set-key (kbd "C-c /") 'toggle-comment)
(global-set-key (kbd "C-c h") 'ff-find-other-file)
(global-set-key (kbd "C-c s") 'enable-automatic-flycheck)
(global-set-key (kbd "C-c C-SPC") 'unpop-to-mark-command)
(global-set-key (kbd "M-[") 'previous-buffer)
(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-n") 'other-window)
(global-set-key (kbd "C-;") 'etags-select-find-tag)
(global-set-key (kbd "C-:") 'etags-select-find-tag-at-point)

(set-face-foreground 'font-lock-preprocessor-face "gray40")
(set-face-foreground 'font-lock-string-face "pink4")
(set-face-foreground 'font-lock-function-name-face "SlateBlue3")
(set-face-foreground 'font-lock-keyword-face "DeepSkyBlue4")
(set-face-foreground 'font-lock-constant-face "SteelBlue1")
(set-face-foreground 'font-lock-type-face "DodgerBlue3")
(set-face-foreground 'font-lock-variable-name-face "SkyBlue4")
(set-face-foreground 'font-lock-comment-face "bisque4")
(set-face-foreground 'font-lock-comment-delimiter-face "bisque4")
(set-face-foreground 'font-lock-doc-face "bisque4")
(set-face-foreground 'font-lock-builtin-face "DeepSkyBlue4")

(set-face-foreground 'web-mode-symbol-face "SteelBlue1")

(set-face-foreground 'linum "gray40")
(set-face-background 'linum "gray15")
(set-face-foreground 'linum-highlight-face "gray50")
(set-face-background 'linum-highlight-face "gray25")

(set-face-attribute 'trailing-whitespace nil :strike-through "orange red" :background "gray10")

(defun my-org-mode-hook ()
  (set-face-foreground 'org-todo "pink4")
  (set-face-foreground 'org-done "seagreen")
  (set-face-foreground 'org-date "gray40"))

(defun my-c++-mode-hook ()
  (cd "C:\\src\\fox-master")
  (flycheck-select-checker 'c/c++-cl)
  (flycheck-mode))

(defun my-irony-mode-hook()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'irony-mode)

(add-hook 'org-mode-hook 'my-org-mode-hook)
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . hs-minor-mode))

(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

(setq flycheck-cl-args '("/DPSYNCH_REPOSITORY_VERSION=0" "/DPSYNCH_VERSION_LONG=\"10.0.0.0\"" "/c" "/MD" "/EHsc" "/nologo" "/DMT_ENDIAN_LITTLE" "/DWINNT" "/D_WIN32_WINNT=0x0502" "/D_WINSOCKAPI_" "/DVC_VERSION=10" "/D_Windows" "/D_CRT_SECURE_FORCE_DEPRECATE" "/D_CRT_SECURE_NO_DEPRECATE" "/D_CRT_SECURE_NO_WARNINGS" "/DSTRSAFE_NO_DEPRECATE" "/D__USERNAME__=\"liam00\"" "/D__COMPUTERNAME__=\"LIAM00-WS\"" "/Zi" "/DWIN64" "/D_AMD64_" "/bigobj" "/O2" "/Ox" "/Oy-" "/DPSYNCH_MAJOR_VERSION=10" "/DPSYNCH_MINOR_VERSION=0" "/DPSYNCH_PATCH_VERSION=0" "/DPSYNCH_VERSION_SHORT=\"10.0.0\"" "/DPSYNCH_VERSION_STATE=\"Alpha\"" "/DPSYNCH_COMPANY_NAME=\"Hitachi ID Systems, Inc.\"" "/DPSYNCH_COMPANY_SHNAME=\"Hitachi ID\"" "/I.\\.\\services\\ajaxsvc" "/I.\\common" "/I.\\lib" "/I.\\psdlls" "/IC:\\pslibs\\extlib\\libs\\boost\\1.34.1" "/IC:\\pslibs\\extlib\\libs\\loki\\0.1.5\\include" "/IC:\\pslibs\\extlib\\libs\\regex\\3.8\\include" "/IC:\\pslibs\\extlib\\libs\\msxml\\4.0\\include" "/IC:\\pslibs\\extlib\\libs\\cpprest\\1.2.0\\include" "/IC:\\pslibs\\extlib\\libs\\sqlite3\\3.8.4.3\\include"))
