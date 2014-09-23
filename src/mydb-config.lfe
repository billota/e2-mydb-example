(defmodule mydb-config
  (export all))

(defun get-env (key)
  (let ((`#(ok ,data) (application:get_env 'mydb key)))
    data))

(defun env ()
  "Using the config environment set as 'current' in the .app.src 'env' section,
  extract the config settings for the environment."
  (let ((current (get-env 'current-env)))
    (get-env current)))

(defun get (env key)
  (proplists:get_value key env))

(defun get (key)
  (proplists:get_value key (env)))