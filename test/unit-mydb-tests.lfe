(defmodule unit-mydb-tests
  (behaviour ltest-unit)
  (export all))

(include-lib "ltest/include/ltest-macros.lfe")

(deftest app-init
  (is-equal
    ;; XXX This unit test fails by default -- fix it!
    #(ok "data")
    (mydb-app:init)))
