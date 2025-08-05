;; Disable annoying C-z minimise emacs.
(keymap-global-unset "C-z")
;; Disable annoying accidentally closing emacs
;; (keymap-global-unset "C-x C-c")
;;An improved buffer list
(global-set-key (kbd "M-o") 'other-window)
(global-set-key [remap list-buffers] 'ibuffer)

;; Permanent registers:
(set-register ?c (cons 'file "~/.emacs.d/init.el"))
(set-register ?b (cons 'file "~/.zshrc"))

(global-set-key [f5]
		(lambda ()
		  (interactive)
		  (let ((path (buffer-file-name)))
		    (if path
			(shell-command (format "open --reveal %s" path))
		      (message "Buffer is not visiting a file."))
		    )))

(defun arrayify (start end quote)
  "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion
         (mapconcat
          (lambda (x) (format "%s%s%s" quote x quote))
          (split-string (buffer-substring start end)) ", ")))
    (delete-region start end)
    (insert insertion)))

;; Copy current directory to clipboard with correct escape sequences.
(global-set-key (kbd "H-p")
(lambda ()
  (interactive)
  (let ((path (shell-command-to-string "pwd")))
    (shell-command (format "printf %%q %s | pbcopy" (string-trim path)))
    (message "Copied path: %s" (string-trim path)))))

(global-set-key (kbd "H-w")
		(lambda () (interactive)
		  (let ((delete-trailing-whitespace t))
		    (delete-trailing-whitespace)
		  (message "Deleted trailing whitespace")
		  )))
