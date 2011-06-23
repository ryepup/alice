;;;; alice.asd

(asdf:defsystem #:alice
  :serial t
  :depends-on (#:iterate
               #:alexandria
               #:talcl
               #:hunchentoot
	       #:cl-mediawiki
	       #:split-sequence
	       #:symbol-munger
	       #:buildnode)
  :components ((:file "package")
               (:file "alice")
	       (:module "src"
		:serial t
		:components ((:file "www")))))

