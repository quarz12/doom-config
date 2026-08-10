;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Changed:
(add-to-list 'load-path (expand-file-name "includes" doom-user-dir))
(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/bin/fish")
(setq-default explicit-shell-file-name "/bin/fish")
(cua-mode 1) ; normal copy/ cut/ paste
(setq visible-bell 1) ; disable error sound
(add-to-list 'default-frame-alist
    '(font . "JetBrains Mono-15"))

;; package installs
(setq use-package-always-ensure t) ; always install missing packages
(use-package ligature
  :load-path "~/.emacs.d/includes"
  :config
  (ligature-set-ligatures 't '("--" "---" "==" "===" "!=" "!==" "=!="
                              "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
                              "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
                              "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
                              "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
                              "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
                              "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
                              "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
                              "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
                              "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
                              "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
                              ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
                              "<:<" ";;;"))
  (global-ligature-mode t)) ; connected symbols
(use-package multiple-cursors-core
  :bind    (:map mc/keymap
                 ("<return>" . nil))) ; multicursor use enter for newline, ctrl + g to exit

;; themes/configs?

(setq confirm-kill-emacs nil)
(setq doom-theme 'doom-dark+)
(setq tab-width 4)
(setq indent-tabs-mode nil) ; never use tabs
(treemacs)
(setq treemacs-fixed-width 0) ; allow resizing
(treemacs-git-mode 'deferred)
(treemacs-follow-mode 1)
(treemacs-fringe-indicator-mode 'always) ; highlight | bar left of selected file
(treemacs-filewatch-mode 1) ; update the filetree when new files are created/renamed


(minimap-mode 1)
(setq minimap-window-location 'right) ; minimap

;; keybinds

(map! :g ;;NOTE commented lines are defaults
    "C-y" #'undo-fu-only-redo                  ; C-y redo
    "C-a" #'mark-whole-buffer                  ; select the whole file
    "C-#" #'comment-line                       ; comment line(s)
    "C-M-l" #'eglot-format                     ; format file with lsp
    "<backtab>" #'my-indent-rigidly            ; enter shifting mode
    "C-M-d" #'+lookup/definition               ; jump to definition
    "C-M-i" #'+lookup/implementations          ; jump to implementation
    "C-M-u" #'+lookup/references               ; jump to usages
    ;; "M-,"                                   ; jump backwards
    ;; "C-M-,"                                 ; jump forwards
    "C-M-l" #'format-or-indent-region          ; format using eglot, fallback to autoindent
    "M-S-<up>" #'mc/mark-previous-like-this    ; add a cursor above or at the previous match of the selection
    "M-S-<down>" #'mc/mark-next-like-this      ; add a cursor below or at the next match of the selection
    ;; "C-g"                                   ; exit multicursor mode
    "M-<down-mouse-1>" #'mc/add-cursor-on-click; add cursor at clicked position
    "C-s" #'save-buffer                        ; save file
    "C-f" #'+default/search-buffer             ; search in file
    "C-p" #'treemacs-projectile                ; open sidebar (project)
    "C-d" #'treemacs-select-directory          ; open sidebar (directory)
    "C-+" #'+fold/open                         ; unfold
    "C--" #'+fold/close                        ; fold
    "C-*" #'+fold/open-all                     ; C-S-+ unfold all
    "C-_" #'+fold/close-all                    ; C-S-- fold all
    )
(map!
  :map undo-fu-mode-map
  "C-_" #'+fold/close-all) ; this mode otherwise blocks the keybind
(map!
    :map +dashboard-mode-map
  "C-p" #'treemacs-projectile) ; another one
(after! corfu
  (map! :map corfu-map
        [escape] #'corfu-quit))                ; let ESC close the corfu popup
(with-eval-after-load 'treemacs
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action) ; treemacs fold/unfold in one click
    (treemacs-follow-mode))                                                        ; highlight the current file in tree

;; helper functions
(defun format-or-indent-region (beg end)
  "Format the region with Eglot, falling back to `indent-region'.

Use Eglot's formatter when an Eglot server is active in the current
buffer. Otherwise, indent the selected region using the current
major mode's indentation rules."
  (interactive "r")
  (if (and (bound-and-true-p eglot--managed-mode)
           (eglot-current-server))
      (eglot-format beg end)
    (indent-region beg end)))

(defun my-indent-rigidly ()
    "Enter `indent-rigidly' shifting mode for all selected lines."
    (interactive)
    (let ((beg (save-excursion
                   (goto-char (region-beginning))
                   (line-beginning-position)))
             (end (save-excursion
                      (goto-char (region-end))
                      (line-end-position))))
        (set-mark end)
        (goto-char beg)
        (call-interactively #'indent-rigidly)))

(defun my-mc-normal-click (event)
  "Remove all multicursors and perform a normal mouse click."
  (interactive "e")
  (when (bound-and-true-p multiple-cursors-mode)
    (mc/keyboard-quit))
  (mouse-set-point event))
