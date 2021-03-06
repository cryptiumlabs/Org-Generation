(asdf:defsystem :org-generation
  :depends-on (:fset :uiop)
  :version "0.0.1"
  :description ""
  :author "Mariari"
  :pathname "src/"
  :components
  ((:file "type-signature")
   (:file "maybe")
   (:file "types"           :depends-on ("maybe" "type-signature"))
   (:file "org-directory"   :depends-on ("maybe" "type-signature" "types"))
   (:file "utility"         :depends-on ("type-signature"))
   (:file "haskell"         :depends-on ("maybe" "types"))
   (:file "context"         :depends-on ("haskell" "types"))
   (:file "lisp"            :depends-on ("types" "maybe" "type-signature"))
   (:file "code-generation" :depends-on ("context" "utility" "types" "type-signature" "maybe" "org-directory")))
  :in-order-to ((asdf:test-op (asdf:test-op :org-generation/test))))

(asdf:defsystem :org-generation/test
  :depends-on (:org-generation :fiveam)
  :description "testing org-generation"
  :pathname "test/"
  :components ((:file "testpkg")
               (:file "context"       :depends-on ("testpkg"))
               (:file "org-directory" :depends-on ("testpkg"))
               (:file "haskell"       :depends-on ("testpkg" "context"))
               (:file "run-tests"     :depends-on ("haskell" "org-directory")))
  :perform (asdf:test-op (o s)
                         (uiop:symbol-call :og/org-test :run-tests)))
