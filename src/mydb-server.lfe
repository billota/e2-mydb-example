(defmodule mydb-server
  (export (start 0)
          (stop 0)))

(defun start ()
  (e2_application:start_with_dependencies 'mydb))

(defun stop ()
  (application:stop 'mydb))
