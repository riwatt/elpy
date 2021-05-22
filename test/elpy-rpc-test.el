;;; -*-coding: utf-8-*-

(ert-deftest elpy-rpc-integration ()
  (elpy-testcase ()
    (should (equal (elpy-rpc "echo" '(23 "möp"))
                   '(23 "möp")))))
