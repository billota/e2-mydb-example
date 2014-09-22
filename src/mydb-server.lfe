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

(defun listen (_port)
  'fake-listen-socket)

(defun wait-for-client (_socket)
  (timer:sleep 5000)
  'fake-client-socket)

(defun dispatch-client (client)
  (io:format "TODO: dispatch client ~p~n" (list client)))