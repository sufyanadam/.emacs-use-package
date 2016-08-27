;; start a httpd-server in current directory
(defun httpd-start-here (directory port)
  (interactive (list (read-directory-name "Root directory: " default-directory nil t)
                     (read-number "Port: " 8017)))
  (setq httpd-root directory)
  (setq httpd-port port)
  (httpd-start)
  (browse-url (concat "http://localhost:" (number-to-string port) "/")))

(defun httpd-start-impatient (buffer-name)
  "Start http server and navigate to impatient url"
  (interactive)
  (open-impatient-http-server-at (concat "imp/live/" buffer-name)))

(defun open-impatient-http-server-at (path)
  (setq httpd-root "~/")
  (setq httpd-port 8017)
  (httpd-start)
  (browse-url (concat "http://localhost:" (number-to-string 8017) "/" (or path ""))))

(defun view-url ()
  "Open a new buffer containing the contents of URL."
  (interactive)
  (let* ((default (thing-at-point-url-at-point))
         (url (read-from-minibuffer "URL: " default)))
    (switch-to-buffer (url-retrieve-synchronously url))
    (rename-buffer url t)
    ;; TODO: switch to nxml/nxhtml mode
    (cond ((search-forward "<?xml" nil t) (xml-mode))
          ((search-forward "<html" nil t) (html-mode)))))

(defun buffer-to-html (buffer)
  (with-current-buffer (htmlize-buffer buffer)
    (buffer-string)))

(provide 'my-html-defuns)
