; Внешний вид
;; Убираем тулбар

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(tool-bar-mode -1)

;; Убираем скроллбар
(toggle-scroll-bar -1)

;; Убираем меню
(menu-bar-mode nil)

; Настройки редактора
;; Пробелы вместо таба
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq-default tab-width 2)

;; Курсор как палочка
(setq-default cursor-type 'bar)
;; Не показывать сообщение при старте
(setq inhibit-startup-message t)

;; Не заставляйте меня печать yes целиком
(fset 'yes-or-no-p 'y-or-n-p)

;; Org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Указываем где будут лежать файлы расширений
(add-to-list 'load-path "~/.emacs.d/lisp")

;; MELPA
(require 'package)
(setq package-enable-at-startup nil)
;; Add melpa package source when using package list

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Убираем бэкапы
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

(unless (package-installed-p 'use-package)
  (message "EMACS install use-package.el")
  (package-refresh-contents)
  (package-install 'use-package))


(use-package emacs-snippets
  :load-path "/home/oleg/.emacs.d/emacs-snippets"
 :after yasnippet)


;; Общий с системой буфер обмена
(setq x-select-enable-clipboard t)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)


(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default

;; Цветовая схема
(load-theme 'atom-one-dark t)

;; Шрифт
(set-frame-font "Fira Code 12" nil t)


(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

; Команды в русской раскладке
(defun reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))

    (when input-method
      (activate-input-method current))))

(reverse-input-method 'russian-computer)

;; Snippets
(add-to-list 'load-path
             "~/.emacs.d/lisp/yasnippet")

;; Icons
(add-to-list 'load-path
           "~/.emacs.d/lisp/mode-icons")
(mode-icons-mode)

(require 'yasnippet)

(yas-global-mode 1)


(desktop-save-mode 0)


;; HTML Features
(defun html-mega-mode()
  (interactive)
  (web-mode)
  (emmet-mode)
  (auto-complete-mode)
  )

(defun js-mega-mode()
  (interactive)
  (js2-mode)
  (auto-complete-mode)
  (emmet-mode))


(add-to-list 'auto-mode-alist '("\\.html$". html-mega-mode))
(add-to-list 'auto-mode-alist '("\\.js$". js-mega-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'jso-mode
  '(define-key jso-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;;JSDoc Settings
(setq js-doc-mail-address "oleg.ivanov@adsniper.ru"
       js-doc-author (format "Oleg Ivanov <%s>" js-doc-mail-address)
       js-doc-url "http://adsniper.ru"
       js-doc-license "-")


(add-hook 'js2-mode-hook
           #'(lambda ()
               (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
               (define-key js2-mode-map "@" 'js-doc-insert-tag)))


(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
    (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
    (global-set-key (kbd "S-C-<down>") 'shrink-window)
    (global-set-key (kbd "S-C-<up>") 'enlarge-window)

(defun typo-replace()
  (interactive)
  (replace-string "<<" "«")
  (replace-string ">>" "»")
  (replace-string "--" "­")
  )



(defun indent-it-all ()
  "indent the buffer using indent"
  (shell-command-on-region (point-min) (point-max) "indent" t t))

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


(global-auto-revert-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "3b5ce826b9c9f455b7c4c8bff22c020779383a12f2f57bf2eb25139244bb7290" "15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "c620ce43a0b430dcc1b06850e0a84df4ae5141d698d71e17de85e7494377fd81" default)))
 '(fci-rule-color "#3E4451")
 '(package-selected-packages
   (quote
    (go-mode yaml-mode rainbow-delimiters multiple-cursors ido-ubiquitous counsel-ebdb tabbar-ruler tabbar latex-preview-pane markdown-preview-eww markdown-preview-mode flymd typescript-mode js2-refactor projectile zenburn-theme yasnippet-snippets yascroll window-purpose websocket web-mode web-beautify undo-tree tern-auto-complete solarized-theme slime semi searchq request oauth2 nlinum neotree markdown-mode magit lua-mode js2-mode js-doc goto-chg github-theme flymake-jshint flycheck flatui-theme eslint-fix ergoemacs-status emojify emmet-mode djvu dedicated color-theme-sanityinc-solarized color-theme circe atom-one-dark-theme all-the-icons alert))))


(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


(global-set-key (kbd "M-g") 'goto-line)

(setq frame-title-format "%b")

(global-display-line-numbers-mode)



(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-commander)


;; эта часть настроек для доступа к Gmail по IMAP
(setq elmo-imap4-default-server "imap.gmail.com"
      elmo-imap4-default-user "oleg.ivanov.wrk@gmail.com"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl
      elmo-imap4-use-modified-utf7 t)

;; тут настройки отвечающие за SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "oleg.ivanov.wrk"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-from "Имя которое получатели ваших писем увидят в поле From <ваш_адрес@gmail.com>"

    ;; настройки папок IMAP
    ;; если у вас в настройках gmail стоит русский язык то копируйте все как есть
    ;; gmail создает имена папок в зависимости от локали
    wl-default-folder "%inbox"
    wl-draft-folder   "%[Gmail]/Черновики"
    wl-trash-folder   "%[Gmail]/Корзина"
    wl-fcc            "%[Gmail]/Отправленные"

    wl-fcc-force-as-read    t
    wl-default-spec "%")
