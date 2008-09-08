;;======================
;;個人的なemacs-lispの指定
;;======================
(setq load-path (cons "~/" load-path))
(setq load-path (cons "~/site-lisp/" load-path))
(setq load-path (cons "/usr/local/share/emacs/site-lisp/blgrep" load-path))

;;======================
;; for Change log
;; default(C-x 4 a)
;;======================
(setq user-full-name "Masato Inoue")
(setq user-mail-address "masatoinoue00@gmail.com")

(defun memo()
  (interactive)
  	(add-change-log-entry
	 nil
;	 	(expand-file-name "~/memo/diary.txt")))
;	 	(expand-file-name "~/src/GitHub/emacschangelogdiary/diary.txt")))
	 	(expand-file-name "~/src/GitHub/repos/emacs-diary/Work/diary.txt")))
;	 	(expand-file-name "~/memo/memo.txt")))
(define-key ctl-x-map "M" 'memo)

;;=========================
;; for Tab indent
;;=========================
(setq default-tab-width 4)


;====================================
; ミニバッファ設定
;===================================
;ミニバッファで M-x 時のインクリメンタル補完
(require 'mcomplete)
;さらによく使うヒストリを優先させる
(load "mcomplete-history")
(turn-on-mcomplete-mode)

;ファイルを開く時に，カーソルキーだけで，ファイルを選択
;カーソル上下で従来のヒストリ。ctrl+P,ctrl+nでファイル名補完
(require 'cycle-mini)
(define-key minibuffer-local-map [up] 'previous-history-element)
(define-key minibuffer-local-completion-map [up] 'previous-history-element)
(define-key minibuffer-local-must-match-map [up] 'previous-history-element)
(define-key minibuffer-local-ns-map [up] 'previous-history-element)
(define-key minibuffer-local-ns-map [down] 'next-history-element)
(define-key minibuffer-local-map [down] 'next-history-element)
(define-key minibuffer-local-completion-map [down] 'next-history-element)
(define-key minibuffer-local-must-match-map [down] 'next-history-element)


;;====================================
;; use iswitchb
;;====================================
(iswitchb-mode 1)
(iswitchb-default-keybindings)

(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
  (define-key iswitchb-mode-map [left]  'iswitchb-prev-match)
  (define-key iswitchb-mode-map "\C-s"  'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-r"  'iswitchb-prev-match)
;  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
;  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
;  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )


(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;=====================================
;; 初期フレームの設定
;;=====================================
(setq default-frame-alist
      (append (list '(width . 164)
		    '(height . 43)
		    '(top . 0)
		    '(left . 0))
	      default-frame-alist))

;;=====================================
;; Color Theme 設定
;;=====================================
(require 'color-theme)
(color-theme-initialize)
(color-theme-emacs-21)
;(color-theme-gnome2)
;(color-theme-clarity)

;;=====================================
;;; M-g で指定行へジャンプ
;;=====================================
(global-set-key "\M-g" 'goto-line)

;;=====================================
;;; 選択範囲(リージョン)のハイライト
;;=====================================
(transient-mark-mode 1)

;;=====================================
;;; 対応する{}をハイライト
;;=====================================
(show-paren-mode 1)


;
; clgrep
;
(autoload 'clgrep "clgrep" "ChangeLog grep." t)
(autoload 'clgrep-item "clgrep" "ChangeLog grep." t)
(autoload 'clgrep-item-header "clgrep" "ChangeLog grep for item header" t)
(autoload 'clgrep-item-tag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-item-notag "clgrep" "ChangeLog grep for item except for tag" t)
(autoload 'clgrep-item-nourl "clgrep" "ChangeLog grep item except for url" t)
(autoload 'clgrep-entry "clgrep" "ChangeLog grep for entry" t)
(autoload 'clgrep-entry-header "clgrep" "ChangeLog grep for entry header" t)
(autoload 'clgrep-entry-no-entry-header "clgrep" "ChangeLog grep for entry except entry header" t)
(autoload 'clgrep-entry-tag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-entry-notag "clgrep" "ChangeLog grep for tag" t)
(autoload 'clgrep-entry-nourl "clgrep" "ChangeLog grep entry except for url" t)
(add-hook 'clmemo-mode-hook
          '(lambda () (define-key clmemo-mode-map "\C-c\C-g" 'clgrep)))



;;====================================
;; Font 指定
;;====================================
;;Osaka
(if window-system (progn
 (create-fontset-from-fontset-spec
 (concat
 "-*-fixed-medium-r-normal-*-14-*-*-*-*-*-fontset-osaka16,"
 "japanese-jisx0208:-apple-osaka-medium-r-normal--16-160-75-75-m-160-jisx0208.1983-sjis,"
 "ascii:-apple-monaco-medium-r-normal-*-14-*-*-*-*-*-mac-roman"))
 (set-default-font "fontset-standard")
 (setq default-frame-alist (append '((font . "fontset-standard"))))
 ))

;;====================================
;; Mew
;;====================================
(autoload 'mew "mew" nil t)
(autoload 'mew-send' "mew" nil t)
(if (boundp 'read-mail-command)
  (setq read-mail-command 'mew))
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
  (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
  (define-mail-user-agent
    'mew-user-agent
    'mew-user-agent-compose
    'mew-draft-send--message
    'mew-draft-kill
    'mew-send-hook))


;;==================================
;; TAB 表示
;;==================================
;; タブ, 全角スペース、改行直前の半角スペースを表示する

;; タブ, 全角スペース、改行直前の半角スペースを表示する
(when (require 'jaspace nil t)
  (when (boundp 'jaspace-modes)
    (setq jaspace-modes (append jaspace-modes
                                (list 'php-mode
                                      'yaml-mode
                                      'javascript-mode
                                      'ruby-mode
                                      'text-mode
                                      'fundamental-mode))))
  (when (boundp 'jaspace-alternate-jaspace-string)
    (setq jaspace-alternate-jaspace-string "□"))
  (when (boundp 'jaspace-highlight-tabs)
    (setq jaspace-highlight-tabs ?^))
  (add-hook 'jaspace-mode-off-hook
            (lambda()
              (when (boundp 'show-trailing-whitespace)
                (setq show-trailing-whitespace nil))))
  (add-hook 'jaspace-mode-hook
            (lambda()
              (progn
                (when (boundp 'show-trailing-whitespace)
                  (setq show-trailing-whitespace t))
                (face-spec-set 'jaspace-highlight-jaspace-face
                               '((((class color) (background light))
                                  (:foreground "blue"))
                                 (t (:foreground "green"))))
                (face-spec-set 'jaspace-highlight-tab-face
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))
                (face-spec-set 'trailing-whitespace
                               '((((class color) (background light))
                                  (:foreground "red"
                                   :background "unspecified"
                                   :strike-through nil
                                   :underline t))
                                 (t (:foreground "purple"
                                     :background "unspecified"
                                     :strike-through nil
                                     :underline t))))))))

;;===========================
;; shell command  補完
;;===========================
(require 'shell-command)
(shell-command-completion-mode)

;;===========================
;; hatena mode
;;===========================
(require 'simple-hatena-mode)