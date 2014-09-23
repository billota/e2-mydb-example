(defmodule mydb-client-handler
  (behaviour e2_task)
  (export (start_link 1)
          (handle_task 1)
          (terminate 2)))

(defun start_link (socket)
  (e2_task:start_link (MODULE) socket))

(defun handle_task (socket)
  (handle-command-line (read-line socket) socket))

(defun read-line (socket)
    (inet:setopts socket '(#(active false) #(packet line)))
    (gen_tcp:recv socket 0))

(defun handle-command-line
  ((`#(ok ,data) socket)
    (io:format "### Got ~p from client~n" (list data))
    `#(repeat ,socket))
  ((`#(error ,err) _socket)
   `#(stop #(socket-err ,err))))

(defun terminate (_reason socket)
  (gen_tcp:close socket))
