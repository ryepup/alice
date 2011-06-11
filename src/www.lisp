(in-package :alice)

(defun resource-path (path)
  "looks up path relative to whereever this asdf system is installed.  Returns a truename"
  (truename (asdf:system-relative-pathname :alice path)))


(defvar *acceptor* nil "the hunchentoot acceptor")

(defun start-server (&optional (port 8888))
  (setf *acceptor* (make-instance 'hunchentoot:acceptor :port port))  
  ;; make a folder dispatcher the last item of the dispatch table
  ;; if a request doesn't match anything else, try it from the filesystem
  (setf (alexandria:last-elt hunchentoot:*dispatch-table*)
	(hunchentoot:create-folder-dispatcher-and-handler "/" (resource-path "www")))
  (hunchentoot:start *acceptor*))

(defvar *tal-generator*
  (make-instance 'talcl:caching-file-system-generator
		 :root-directories (list (resource-path "templates"))))

(defun render-page (template &optional tal-env)
  "renders the given template" 
  (format nil "<!doctype html>~%~a"
	  (talcl:run-template *tal-generator* template tal-env)))

(hunchentoot:define-easy-handler (home :uri "/") ()
  (render-page "home.tal"
	       (talcl:tal-env 'course (current-course))
		 ))