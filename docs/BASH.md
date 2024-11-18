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

## Reference

## Syntax

## Structure

## Basic Structures

### Compound Commands

#### Command List

#### Expressions

#### Loops

### Builtins

#### Dummies

#### Declarative

#### Input

#### Output

#### Execution

#### Jobs/Processes

#### Conditionals & Loops

In bash and other related shells, `0` is `true` and `1` or other numbers is `false`.

These numbers are exit codes of shell executables and shell commands.
```
true; echo $?
false; echo $?
```
Therefore any command that succeeds should return a `0`.

#### Script Arguments

## Streams

### File Descriptors

### Redirection

### Piping

### Expansions

### Common Combinations

## Tests

### Exit Code

#### Testing Exit Code

### Patterns

#### Glob Syntax

### Testing

## Parameters

### Special Parameters

### Parameter Operations

### Arrays

#### Creating Arrays

#### Using Arrays

## Examples: Basic Structures

### Compound Commands

#### Command Lists

#### Expressions

#### Loops

### Builtins

#### Dummies

#### Declarative

#### Input

#### Output

#### Execution




# Regular Colors

| Value    | Color  |
| -------- | ------ |
| \e[0;30m | Black  |
| \e[0;31m | Red    |
| \e[0;32m | Green  |
| \e[0;33m | Yellow |
| \e[0;34m | Blue   |
| \e[0;35m | Purple |
| \e[0;36m | Cyan   |
| \e[0;37m | White  |

# Bold

| Value    | Color  |
| -------- | ------ |
| \e[1;30m | Black  |
| \e[1;31m | Red    |
| \e[1;32m | Green  |
| \e[1;33m | Yellow |
| \e[1;34m | Blue   |
| \e[1;35m | Purple |
| \e[1;36m | Cyan   |
| \e[1;37m | White  |

# Underline

| Value    | Color  |
| -------- | ------ |
| \e[4;30m | Black  |
| \e[4;31m | Red    |
| \e[4;32m | Green  |
| \e[4;33m | Yellow |
| \e[4;34m | Blue   |
| \e[4;35m | Purple |
| \e[4;36m | Cyan   |
| \e[4;37m | White  |

# Background

| Value  | Color  |
| ------ | ------ |
| \e[40m | Black  |
| \e[41m | Red    |
| \e[42m | Green  |
| \e[43m | Yellow |
| \e[44m | Blue   |
| \e[45m | Purple |
| \e[46m | Cyan   |
| \e[47m | White  |

# High Intensity

| Value    | Color  |
| -------- | ------ |
| \e[0;90m | Black  |
| \e[0;91m | Red    |
| \e[0;92m | Green  |
| \e[0;93m | Yellow |
| \e[0;94m | Blue   |
| \e[0;95m | Purple |
| \e[0;96m | Cyan   |
| \e[0;97m | White  |

# Bold High Intensity

| Value    | Color  |
| -------- | ------ |
| \e[1;90m | Black  |
| \e[1;91m | Red    |
| \e[1;92m | Green  |
| \e[1;93m | Yellow |
| \e[1;94m | Blue   |
| \e[1;95m | Purple |
| \e[1;96m | Cyan   |
| \e[1;97m | White  |

# High Intensity backgrounds

| Value     | Color  |
| --------- | ------ |
| \e[0;100m | Black  |
| \e[0;101m | Red    |
| \e[0;102m | Green  |
| \e[0;103m | Yellow |
| \e[0;104m | Blue   |
| \e[0;105m | Purple |
| \e[0;106m | Cyan   |
| \e[0;107m | White  |

# Reset

| Value | Color  |
| ----- | ------ |
| \e[0m | Reset  |

# other styles

```bash
echo -e "\e[1mbold\e[0m"
echo -e "\e[3mitalic\e[0m"
echo -e "\e[3m\e[1mbold italic\e[0m"
echo -e "\e[4munderline\e[0m"
echo -e "\e[9mstrikethrough\e[0m"
echo -e "\e[31mHello World\e[0m"
echo -e "\x1B[31mHello World\e[0m"
```