(custom-set-variables
 '(cua-mode t nil (cua-base))   ;; use Common-User-Access keys (Ctrl-c, Page Up/Page Down, etc.)
 '(inhibit-startup-screen t))   ;; suppress the startup screen
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Eliminate delay for set-default-font
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; Save file every 1000 characters (also deletes the auto save (#) file)
(setq auto-save-interval 1000)

;; Enable wheelmouse support by default
(cond (window-system
       (mwheel-install)
))

;; Set text mode as default (not Lisp)
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "")

;; Set Ctrl-c; as comment/uncomment region [works for Python, F90, TeX, else?]
(global-set-key "\C-c;" 'comment-or-uncomment-region)

;; Wrap the text at the fill-column value
(setq-default fill-column 60)
(global-visual-line-mode 1)

;; AUCTeX Setup (10-03-2017)
(setq TeX-auto-save t) ;; Enable parse on save.
(setq TeX-parse-self t) ;; Enable parse on load.
(setq-default TeX-master nil) ;; Query for Master file in case present file is not the master.
(setq TeX-PDF-mode t) ;; Compile using pdflatex
(setq LaTeX-math-mode t) ;; Turns on feature where you hit "`" and then a letter to get a latex math symbol (i.e., enter ` t -> 'tau{}
(setq latex-run-command "pdflatex") ;; use pdflatex for compilation
(setq TeX-view-program-selection '((output-pdf "PDF Viewer"))) ;; create PDF Viewer option
(setq TeX-view-program-list
      '(("PDF Viewer" "xpdf %o"))) ;; use xpdf as the PDF viewer
;; RefTeX modes for AUCTeX
(autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
;;(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(setq reftex-plug-into-AUCTeX t) ;; nice interface between RefTeX and AUCTeX
;;(setq reftex-extra-bindings t) ;; uses the RefTeX supplemental keybindings (https://www.gnu.org/software/emacs/manual/html_node/reftex/Key-Bindings.html)
;;(add-hook 'reftex-mode-hook
;;	  '(lambda ()
;;	     (define-key reftex-mode-map "\C-ct"
;;	                 'reftex-toc)
;;	     (define-key reftex-mode-map "\C-cl"
;;	       'reftex-label)
;;	     (define-key reftex-mode-map "\C-cr"
;;	       'reftex-reference)
;;	     (define-key reftex-mode-map "\C-cc"
;;	       'reftex-citation)
;;	     (define-key reftex-mode-map "\C-cv"
;;	       'reftex-view-crossref)
;;	     (define-key reftex-mode-map "\C-cs"
;;	       'reftex-search-document)
;;	     (define-key reftex-mode-map "\C-cg"
;;	       'reftex-grep-document)
;;))  

;; NEW SECTIONS (10-02-2017)

(transient-mark-mode 1)

;; This function re-assembles a sequence of one-line sentences into a paragraph
(defun ospl/reassemble-paragraph ()
  (interactive)
  (forward-paragraph 1)
  (forward-paragraph -1)
  (while (looking-at paragraph-start)
    (forward-line 1))
  (let ((beg (point)))
    (forward-paragraph 1)
    (backward-char 1)
    (while (> (point) beg)
      (join-line)
      (beginning-of-line))
    )
  )

;; ORPHANED SECTIONS (?)

;;(add-hook 'LaTeX-mode-hook
;;	  '(lambda () (longlines-mode)))
;;(add-hook 'text-mode-hook
;;	  '(lambda () (longlines-mode)))

;; These f90 options date back to BC Barnes at WUSTL. Not sure what they do today.
;;(eval-after-load "f90"
;;  '(progn
;;     (setq f90-font-lock-keywords-3
;;	   (append f90-font-lock-keywords-2
;;		   (list
;;		    f90-keywords-level-3-re
;;		    f90-operators-re
;;		    (list f90-procedures-re '(1 font-lock-builtin-face keep))
;;		    "\\<real\\>"))
;;	   f90-font-lock-keywords-4 (append f90-font-lock-keywords-3
;;	       (list f90-hpf-keywords-re)))))     
