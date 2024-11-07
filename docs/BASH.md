# Bash Guide

## Introduction

## Redirection

There are three types of file descriptors. You have:
	- `stdin`
	- `stdout`
	- `stderr`

With these, you can perform the following:
	- redirect `stdout` to a file
	- redirect `stderr `to a file
	- redirect `stdout` to a `stderr`
	- redirect `stderr` to a `stdout`
	- redirect `stderr` and `stdout` to a file
	- redirect `stderr` and `stdout` to `stdout`
	- redirect `stderr` and `stdout` to `stderr`

1 'represents' `stdout` and 2 `stderr`.

With the `ls` command (which remains on the buffer) you can view both `stdout`
and the `stderr` that will be printed on the screen, but erased as you try to
"browse" the buffer.

--------------------------------------------------------------------------------

### `stdout` to a file

This example will redirect the output of the program and write it to a file.
```bash
	ls -l > dir.txt
```
A file named dirs.txt is created and contains the output that would normally be
displayed in the terminal window if the same command `ls -l` was run.