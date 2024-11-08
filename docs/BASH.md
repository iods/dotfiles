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


### `stderr` to a file

This example will redirect the `stderr` output of the program to a file.
```bash
grep da * > errors.txt
```
A file named 'errors.txt' is created and contains the output that would normally
be displayed during the `stderr` portion of the `grep da *` command.

### `stdout` to `stderr`

This example will redirect the `stderr` output of the program to be written to the
same descriptor, `stdout`.
```
grep
```

3.4 Sample: stdout 2 stderr
This will cause the stderr ouput of a program to be written to the same filedescriptor than stdout.


        grep da * 1>&2 
        
Here, the stdout portion of the command is sent to stderr, you may notice that in differen ways.
3.5 Sample: stderr 2 stdout
This will cause the stderr ouput of a program to be written to the same filedescriptor than stdout.


        grep * 2>&1
        
Here, the stderr portion of the command is sent to stdout, if you pipe to less, you'll see that lines that normally 'dissapear' (as they are written to stderr) are being kept now (because they're on stdout).
3.6 Sample: stderr and stdout 2 file
This will place every output of a program to a file. This is suitable sometimes for cron entries, if you want a command to pass in absolute silence.


        rm -f $(find / -name core) &> /dev/null 
        
This (thinking on the cron entry) will delete every file called 'core' in any directory. Notice that you should be pretty sure of what a command is doing if you are going to wipe it's output.