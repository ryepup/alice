;;;; alice.asd

(asdf:defsystem #:alice
  :serial t
  :depends-on (#:iterate
               #:alexandria
               #:talcl
               #:hunchentoot
	       #:cl-mediawiki
	       #:split-sequence)
  :components ((:file "package")
               (:file "alice")
	       (:file "www")))

