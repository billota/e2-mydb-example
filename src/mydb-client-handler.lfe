(defmodule mydb-client-handler
  (behaviour e2_task)
  (export (start_link 1)
          (handle_task 1)
          (terminate 2)))

(defun start_link (socket)
  (e2_task:start_link (MODULE) socket))

(defun handle_task (socket)
  (gen_tcp:send socket "Hej och adjö!\r\n")
  '#(stop normal))

(defun terminate (_reason socket)
  (gen_tcp:close socket))