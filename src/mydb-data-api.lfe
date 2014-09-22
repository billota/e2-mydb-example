(defmodule mydb-data-api
  (export (open 1)
          (put 3)
          (get 2)
          (del 2)))

(defun open (file)
  `#(todo-open-dets-file ,file))

(defun put (db key value)
  `#(todo-put-val ,db ,key ,value))

(defun get (db key)
  `#(todo-read-val ,db ,key))

(defun del (db key)
  `#(todo-delete-val ,db ,key))
