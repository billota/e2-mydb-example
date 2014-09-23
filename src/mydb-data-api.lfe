(defmodule mydb-data-api
  (export (open 1)
          (put 3)
          (get 2)
          (del 2)))

(defun open (filepath)
  (dets:open_file filepath '()))

(defun put (db key value)
  (dets:insert db `#(,key ,value)))

(defun get (db key)
  (handle-dets-lookup (dets:lookup db key)))

(defun del (db key)
  (dets:delete db key))

(defun handle-dets-lookup
  ((`(#(,_ ,value)))
   `#(ok ,value))
  ((())
   'error))