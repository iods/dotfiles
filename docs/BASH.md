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

## File and Directory Support

### `ls` Tips

`ls <option> /path/to/dir`

 - `ls` lists the directory contents separated by a comma.
 - `ls -Q` lists directory contents enclosed by quotation marks.
 - `ls -l` lists files in a long-list format.
 - `ls -lh` lists file sizes in a human-readable format.
 - `ls -g` omits groups ownership column.
 - `ls -F` adds a forward slash when listing directories.
 - `ls -i` lists inode number of files and directories.
 - `ls -a` lists all files including hidden ones.
 - `ls *.` lists files according to the file extension.
 - `ls -la` lists all files and directories in long list format.
 - `ls -R` displays files and directories recursively.
 - `ls -r` lists files in reverse.
 - `ls -X` lists files alphabetically by file extension.
 - `ls -tl` displays files according to the creation date and time.
 - `ls -n` list UIDs and GIDs.