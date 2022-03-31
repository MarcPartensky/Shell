#!/usr/bin/env python

import getpass

from pexpect import pxssh

try:
    s = pxssh.pxssh()
    hostname = input("hostname: ")
    username = input("username: ")
    s.login(hostname, username)
    s.sendline("cd /tmp")  # run a command
    s.prompt()  # match the prompt
    print(s.before.decode("utf-8"))  # print everything before the prompt.
    s.sendline("pwd")
    s.prompt()
    print(s.before.decode("utf-8"))  # print everything before the prompt.
    s.sendline("cd && pwd && ls")
    s.prompt()
    print(s.before.decode("utf-8"))  # print everything before the prompt.
    s.logout()
except pxssh.ExceptionPxssh as e:
    print("pxssh failed on login.")
    print(e)
