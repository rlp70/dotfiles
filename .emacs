;;------------------------------------------------------------------------------
;;
;; Robert's .emacs file
;;
;;------------------------------------------------------------------------------
;;
;; * TODOs [0/2]
;;   - [ ] Need to figure out how to automate evil-mode package install
;;     - This might be in dotfiles/Makefile, but idk, yet
;;   - [ ] Need to test the conditional work_config.el load
;;
;;------------------------------------------------------------------------------

;; Some "default" stuff that I don't personally care about, but don't want to erase
;;
;; Disable loading of "default.el" at startup
;; (setq inhibit-default-init t)
;;
;; Enable visual feedback on selections
;(setq transient-mark-mode t)
;;
;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))
;;
;; default to unified diffs
(setq diff-switches "-u")
;;
;; always end a file with a newline
;(setq require-final-newline 'query)
;;
;; CJK utf-8 support for non-Asian users
;; (require 'un-define)


;; My own personal emacs quirks
;;
;; This is how I like my window-cycling
(global-set-key (kbd "C-c <left>")    'windmove-left)
(global-set-key (kbd "C-c <right>")   'windmove-right)
(global-set-key (kbd "C-c <up>")      'windmove-up)
(global-set-key (kbd "C-c <down>")    'windmove-down)
;;
;; Ctrl-g as "Go To Line"
(global-set-key (kbd "C-g") 'goto-line)
;;
;; I like seeing both the line & column numbers
(column-number-mode)


;; Org-mode stuff
;;
;; Switching around M-RET and C-RET because M-RET is giving me problems on
;; certain terminals.
(add-hook 'org-mode-hook
	  '(lambda()
	     (org-defkey org-mode-map [(control return)] 'org-meta-return)))
(add-hook 'org-mode-hook
	  '(lambda()
	     (org-defkey org-mode-map [(meta return)] 'org-insert-heading-respect-content)))
(add-hook 'org-mode-hook
	  '(lambda()
	     (org-defkey org-mode-map [(shift control return)] 'org-insert-todo-heading-respect-content)))
;;
;; Adding these to allow me to do window-cycling even in org-mode w/pretty much zero effort
;; - org-mode hijacks "C-c <direction" bindings, but not "C-c C-<direction>"
(global-set-key (kbd "C-c C-<left>")  'windmove-left)
(global-set-key (kbd "C-c C-<right>") 'windmove-right)
(global-set-key (kbd "C-C C-<up>")    'windmove-up)
(global-set-key (kbd "C-c C-<down>")  'windmove-down)
;;
;; I don't like using "C-c C-p" to follow links.
;; For the moment, I'm going to use "C-c v" (aka, "visit link") since it isn't bound
(add-hook 'org-mode-hook
	  '(lambda()
	     (org-defkey org-mode-map "\C-cv" 'org-open-at-point)))
;;
;; Wrap lines, by default, in org-mode
(add-hook 'org-mode-hook
	  '(lambda()
	     (toggle-truncate-lines)))


;; Evil Mode stuff
;;
;; Package declaration
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
;;
;; And the toggle
(defun toggle-evilmode()
  (interactive)
  (if (bound-and-true-p evil-local-mode)
      (progn
	(evil-local-mode (or -1 1)) ;; Use Emacs
	(undo-tree-mode (or -1 1))
	)
    (progn
      (evil-local-mode (or 1 1))) ;; Use Evil
    ))
;; And map "M-u" to 'toggle-evilmode
(global-set-key (kbd "M-u") 'toggle-evilmode)

;; Some of my "professional" emacs quirks
;;
;; Braces on the next line, tabs=2 spaces
(setq c-default-style "linux"
      c-basic-offset 2)
;;
;; Use "C-c m" to call 'make' without leaving emacs
(defun do-make()
  "Function wrapper to run 'make' in the current directory from emacs"
  (interactive)
  (compile "make")
  (other-window 1))
(global-set-key (kbd "C-c m") 'do-make)
;;
;; Load my workplace's emacs configurations, if there are any.
;; - Can vary by organization & machine
;; - Do it last to overwrite/unset anything they may want me to do.
(load "~/.emacs.d/work_config.el" t)

;; Auto-complete
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Screenwriter Mode
;; - Was playing with this. I'll remove it later.
;; 
(add-to-list 'load-path "~/elisp")
;;(require 'screenwriter)
;;(global-set-key (kbd ">f1<") 'screenwriter-mode)
;;(setq auto-mode-alist (cons '("\\.scp" . screenwriter-mode) auto-mode-alist))
;;(setq auto-mode-alist (cons '("\\.screenplay" . screenwriter-mode) auto-mode-alist))
;;
;; Fountain Mode
(require 'fountain-mode)
(setq auto-mode-alist (cons '("\\.scp" . fountain-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.screenplay" . fountain-mode) auto-mode-alist))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-checkbox-hierarchical-statistics nil)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages (quote (ledger-mode auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
