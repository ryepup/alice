;;;; alice.asd

(asdf:defsystem #:alice
  :serial t
  :depends-on (#:iterate
               #:alexandria
               #:talcl
               #:hunchentoot)
  :components ((:file "package")
               (:file "alice")))

