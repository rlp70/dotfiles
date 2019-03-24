;;------------------------------------------------------------------------------
;;
;; Robert's .emacs file
;;
;;------------------------------------------------------------------------------
;;
;; * TODOs [0/1]
;;   - [ ] Need to figure out how to automate evil-mode package install
;;     - This might be in dotfiles/Makefile, but idk, yet
;;
;;------------------------------------------------------------------------------

;; My own personal quirks

;; Window-cycling stufff
(global-set-key (kbd "C-c <left>")    'windmove-left)
(global-set-key (kbd "C-c <right>")   'windmove-right)
(global-set-key (kbd "C-c <up>")      'windmove-up)
(global-set-key (kbd "C-c <down>")    'windmove-down)

;; C-g as "Go To Line"
(global-set-key (kbd "C-g") 'goto-line)

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
;; Adding these to allow me to do window-cycling even in org-mode.
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

(setq c-default-style "linux"
      c-basic-offset 2)

;; Evil Mode
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

;; Use "C-c m" to call 'make' without leaving emacs
(defun do-make()
  "Function wrapper to run 'make' in the current directory from emacs"
  (interactive)
  (compile "make")
  (other-window 1))
(global-set-key (kbd "C-c m") 'do-make)

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

