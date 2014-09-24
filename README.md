# e2 example: mydb

*An e2 demo multi-user socket-based database*

## Introduction

The code in this project is an LFE port of Garrett Smith's fabulous e2
tutorial, quite possibly one of the
[best Erlang tutorials](http://e2project.org/tutorial.html)
available on the internets.

The code in this repo differs from that which is presented in the tutorial 
in several ways:

* It's in LFE, so it's all Lisp syntax (i.e., no syntax!).
* The standard Lisp naming conventions are used for functions and variables.
* Some of the module names are different (but a quick comparison should 
  make the differences intuitively obvious).
* Configuration for different environments is done in ``mydb.app.src`` 
  instead of separate config files.
* Since this was written against 17.3, ``appmon`` is not available;
  ``observer`` is used instead.

## Use

```bash
$ git clone https://github.com/billota/e2-mydb-example.git mydb
$ cd mydb
$ make compile
$ make repl-no-deps
```

Then, from the repl:

```cl
> (mydb:start)
ok
> (observer:start)
ok
```

Then, from a separate terminal window:

```telnet
$ telnet 127.0.0.1 3456
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
PUT msg hello
+OK
GET msg
+hello
DEL msg
+OK
GET msg
-ERROR
```

This can be repeated from many different terminal windows, and you will see
the branches from the handler supervisor node in ``observer`` grow in 
number.