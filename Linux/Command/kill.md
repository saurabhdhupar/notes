> BSD General Commands Manual

# NAME
     kill -- 终止或者 signal 一个进程

# SYNOPSIS
     kill [-s signal_name] pid ...
     kill -l [exit_status]
     kill -signal_name pid ...
     kill -signal_number pid ...

# DESCRIPTION
     向指定 pid 的进程传递一个信号.

     只有 super-user 可以向其他用户的进程发送信号.

     可选参数:

     -s signal_name
             指定传输的信号，而不是默认的 TERM.

     -l [exit_status]
             如果没有给定 exit_status ，列出所有的 信号 signal names，否则输出给定 exit_status的数字

     -signal_name
             指定传输的信号 **的名字**，而不是默认的 TERM.

     -signal_number
             指定传输的信号 **的号码**（十进制非负整数），而不是默认的 TERM.

     下述 pid 有特殊的含义:

     -1      如果是 superuser ，就广播到所有进程，如果是普通用户，就广播到该用户的所有进程.

     一些公用信号:

     1       HUP (hang up)                               挂起
     2       INT (interrupt)                             打断
     3       QUIT (quit)                                 退出
     6       ABRT (abort)                                退出
     9       KILL (non-catchable, non-ignorable kill)    不可捕捉不可忽视的干掉
     14      ALRM (alarm clock)                          时钟
     15      TERM (software termination signal)          软件终止信号

# EXIT STATUS
     The kill utility exits 0 on success, and >0 if an error occurs.

# EXAMPLES
     Terminate the processes with PIDs 142 and 157:

           kill 142 157

     Send the hangup signal (SIGHUP) to the process with PID 507:

           kill -s HUP 507

# SEE ALSO
     builtin(1), csh(1), killall(1), ps(1), sh(1), kill(2), sigaction(2)


# HISTORY
     A kill command appeared in Version 3 AT&T UNIX.

# BUGS
     A replacement for the command `kill 0` for csh(1) users should be provided.
