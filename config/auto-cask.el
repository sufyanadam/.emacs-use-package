(defun auto-cask/find-homebrew-cask-el ()
  (let ((prefix
         (car (seq-filter (lambda (directory) (file-exists-p directory)) ["/usr/local/Cellar/cask" "/opt/homebrew/Cellar/cask" "~/.cask/bin"]))
         ))
    (when (file-exists-p prefix)
					; This will break if cask changes version numbering
      (let ((files (directory-files prefix nil "[0-9]+\\.[0-9]+\\.[0-9]+")))
	(unless (null files)
	  (let ((filename (format "%s/%s/%s" prefix (car files) "cask.el")))
	    (when (file-exists-p filename)
	      filename)))))))

(defun auto-cask/find-cask-el ()
  (let ((homebrew-cask-el (auto-cask/find-homebrew-cask-el))
	(homedir-cask-el "~/.cask/cask.el"))
    (or homebrew-cask-el homedir-cask-el)))

(defun auto-cask/setup ()
  (let ((cask-el (auto-cask/find-cask-el)))
    (when cask-el
      (progn
	(require 'cask cask-el)
	(cask--initialize)))))

(provide 'auto-cask)
