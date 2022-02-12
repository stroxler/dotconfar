;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Helper functions for controlling emacs via environment variables
(defun env-with-default-str (env-var default-value)
  (let ((value (getenv env-var)))
    (or value default-value)))

(defun env-with-default-sym (env-var default-value)
  (intern (env-with-default-str env-var (symbol-name default-value))))

;; Identify myself (meh, not at this time)
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Look and feel
(setq doom-theme (env-with-default-sym "EMACS_THEME" 'doom-zenburn))
(setq display-line-numbers-type t)

;; Make evil treat '_' the way vim does
(modify-syntax-entry ?_ "w")

;; Org configuration
(setq org-directory (env-with-default-str "ORG_DIRECTORY" "~/OrgFiles"))
(setq org-roam-directory (env-with-default-str "ORG_ROAM_DIRECTORY" "~/OrgRoamFiles"))

;; More config options, these come from the doom init output
;; ---------------------------------------------------------

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


