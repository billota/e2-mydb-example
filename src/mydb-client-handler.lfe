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
    (handle-command (parse-command data) socket))
  ((`#(error closed) _socket)
   '#(stop normal))
  ((`#(error ,err) _socket)
   `#(stop #(socket-err ,err))))

(defun parse-command (data)
  (handle-command-parse
    (re:run data
            "(.*?) (.*)\r\n"
            '(#(capture all_but_first list)))))

(defun handle-command-parse
  ((`#(match (,command ,arg)))
   `#(,command ,arg))
  (('nomatch)
   'error))

(defun handle-command
  ((`#("GET" ,key) socket)
   (handle-reply (db-get key) socket))
  ((`#("PUT" ,key-val) socket)
   (handle-reply (db-put (split-keyval key-val)) socket))
  ((`#("DEL" ,key) socket)
   (handle-reply (db-del key) socket))
  ((_ socket)
   (handle-reply 'error socket)))

(defun split-keyval (key-val)
  (handle-keyval-parts
    (re:split key-val " " '(#(return list) #(parts 2)))))

(defun handle-keyval-parts
  ((`(,key))
   `#(,key ""))
  ((`(,key ,val))
   `#(,key ,val)))

(defun db-get (key)
  `#(ok ,(++ "You asked for " key)))

(defun db-put
  ((`#(,_key ,_val))
    'ok))

(defun db-del (key)
  'ok)

(defun handle-reply (reply socket)
  (send-reply reply socket)
  `#(repeat ,socket))

(defun send-reply
  ((`#(ok ,val) socket)
    (gen_tcp:send socket `("+" ,val "\r\n")))
  (('ok socket)
   (gen_tcp:send socket "+OK\r\n"))
  (('error socket)
   (gen_tcp:send socket "-ERROR\r\n")))
    
(defun terminate (_reason socket)
  (gen_tcp:close socket))


