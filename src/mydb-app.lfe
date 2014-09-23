(defmodule mydb-app
  (behaviour e2_application)
  (export (init 0)))

(defun init ()
  (let ((port (mydb-config:get 'port))
        (dbfile (mydb-config:get 'dbfile)))
    `#(ok (#(mydb-data-svc start_link (,dbfile))
           #(mydb-server start_link (,port))))))
