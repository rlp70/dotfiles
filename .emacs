;; Trying to get stuff going...

;; My desired default window-cycling stufff...
(global-set-key (kbd "C-c <left>")    'windmove-left)
(global-set-key (kbd "C-c <right>")   'windmove-right)
(global-set-key (kbd "C-c <up>")      'windmove-up)
(global-set-key (kbd "C-c <down>")    'windmove-down)

;; Switching around M-RET and C-RET because M-RET is giving me problems on
;; certain terminals.
(add-hook 'org-mode-hook
	  '(lambda()
	     (org-defkey org-mode-map [(control return)] 'org-meta-return)))
(add-hook 'org-mode-hook
	  '(lambda()
	     (org-defkey org-mode-map [(meta return)] 'org-insert-heading-respect-content)))
;; Adding these to allow me to do window-cycling even in org-mode.
;; - org-mode hijacks "C-c <direction" bindings, but not "C-c C-<direction>"
(global-set-key (kbd "C-c C-<left>")  'windmove-left)
(global-set-key (kbd "C-c C-<right>") 'windmove-right)
(global-set-key (kbd "C-C C-<up>")    'windmove-up)
(global-set-key (kbd "C-c C-<down>")  'windmove-down)

;; Wrap lines, by default, in org-mode
(add-hook 'org-mode-hook
	  '(lambda()
	     (toggle-truncate-lines)))

(setq c-default-style "linux"
      c-basic-offset 2)

(global-set-key (kbd "C-g") 'goto-line)

;; Screenwriter Mode
(add-to-list 'load-path "~/elisp")
;;(require 'screenwriter)
;;(global-set-key (kbd ">f1<") 'screenwriter-mode)
;;(setq auto-mode-alist (cons '("\\.scp" . screenwriter-mode) auto-mode-alist))
;;(setq auto-mode-alist (cons '("\\.screenplay" . screenwriter-mode) auto-mode-alist))

;; Fountain Mode
(require 'fountain-mode)
(setq auto-mode-alist (cons '("\\.scp" . fountain-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.screenplay" . fountain-mode) auto-mode-alist))

