(defmodule mydb-server
  (behaviour e2_task)
  (export (start_link 1)
          (init 1)
          (handle_task 1)))

(defun start_link (port)
  (e2_task:start_link (MODULE) port))

(defun init (port)
    `#(ok ,(listen port)))

(defun handle_task (socket)
  (dispatch-client (wait-for-client socket))
  `#(repeat ,socket))

(defun listen (port)
  (let ((`#(ok ,socket) (gen_tcp:listen port '(#(reuseaddr true)))))
    socket))

(defun wait-for-client (socket)
  (let ((`#(ok ,client) (gen_tcp:accept socket)))
    client))

(defun dispatch-client (client)
  (mydb-client-handler-sup:start_handler client))