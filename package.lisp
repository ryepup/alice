;;;; package.lisp

(defpackage #:alice
  (:use #:cl #:iterate #:split-sequence)
  (:shadowing-import-from #:alexandria
			  #:appendf #:starts-with)
  (:shadowing-import-from #:symbol-munger
			  #:english->lisp-symbol)
  )

