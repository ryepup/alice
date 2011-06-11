;;;; alice.lisp

(in-package #:alice)

;;; "alice" goes here. Hacks and glory await!
(defvar *wiki-creds* '("alice" "t cells rule"))

(defclass course ()
  ((students :accessor students :initarg :students)
   (classes :accessor classes :initarg :classes :initform (list))))

(defclass dance-class ()
  ((moves :accessor moves :initarg :moves)
   (name :accessor name :initarg :name)))

(defun parse-wiki-list (text)
  (iter (for line in (split-sequence #\newline text))
	(when (starts-with #\# line)
	  (collect (subseq line 2)))))

(defun current-course ()
  (cl-mediawiki:with-mediawiki ((make-instance 'cl-mediawiki:mediawiki
					      :url "http://www.shamblingshimmies.com/wiki"))
    (cl-mediawiki:login "alice" "t cells rule")
    (iter (with seen-classes-p = nil)
	  (with course = (make-instance 'course))
	  (for section from 1)
	  (for content = (cl-mediawiki:get-page-content "ActiveCourse"
							:rvsection section))
	  (while content)
	  (cond
	    ((search "== Students" content)
	     (setf (students course) (parse-wiki-list content)))
	    ((search "== Classes" content)
	     (setf seen-classes-p T))
	    (seen-classes-p
	     (appendf (classes course)
		      (make-instance 'dance-class :moves (parse-wiki-list content))
				 )))
	  (finally (return course)))))
