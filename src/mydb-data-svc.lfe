(defmodule mydb-data-svc
  (behaviour e2_service)
  (export (start_link 1)
          (init 1)
          (handle_msg 3)
          (put 2)
          (get 1)
          (del 1)))

(defun start_link (file)
  (e2_service:start_link (MODULE) file '(registered)))

(defun get (key)
  (e2_service:call (MODULE) `#(get ,key)))

(defun put (key value)
  (e2_service:call (MODULE) `#(put ,key ,value)))

(defun del (key)
  (e2_service:call (MODULE) `#(del ,key)))

(defun init (filepath)
  `#(ok ,(open-db filepath)))

(defun open-db (filepath)
  (let ((`#(ok ,db) (mydb-data-api:open filepath)))
    db))

(defun handle_msg
  ((`#(get ,key) _from db)
   `#(reply ,(mydb-data-api:get db key) ,db))
  ((`#(put ,key ,value) _from db)
   `#(reply ,(mydb-data-api:put db key value) ,db))
  ((`#(del ,key) _from db)
   `#(reply ,(mydb-data-api:del db key) ,db)))

