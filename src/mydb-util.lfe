(defmodule mydb-util
  (export all))

(defun get-mydb-version ()
  (lutil:get-app-src-version "src/mydb.app.src"))

(defun get-versions ()
  (++ (lutil:get-version)
      `(#(mydb ,(get-mydb-version)))))
