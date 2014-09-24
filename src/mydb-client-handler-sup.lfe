(defmodule mydb-client-handler-sup
  (behaviour e2_task_supervisor)
  (export (start_link 0)
          (start_handler 1)))

(defun start_link ()
  (e2_task_supervisor:start_link
    (MODULE) 'mydb-client-handler '(registered)))

(defun start_handler (socket)
  (e2_task_supervisor:start_task (MODULE) `(,socket)))