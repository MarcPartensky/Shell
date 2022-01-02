#!/usr/bin/env python

import sys
import pexpect

# pexpect.run("echo b")  # Run command as normal
# child = pexpect.spawn("ssh vps")  # Spawns child application
# print("a")
# child.sendline("echo a")
# print(child.before)
# print("c")
# child.sendline("echo c")
# child.readlines()
# child.expect("Password:")  # When this is the output
# child.sendline("mypassword")

child = pexpect.spawn("/bin/bash", encoding="utf-8")
with open("/tmp/pexpect_test", "w") as stream:
    child.logfile = stream
    # child.expect("Your bash prompt here")
    child.sendline("cd /srv")
    child.expect(".*\$ ")
    # If you are using pxssh you can use this
    # child.prompt()
    # child.expect("Your bash prompt here")
    print(child.before)
    print(child.after)
    # child.expect("Your bash prompt here")
    child.sendline("ls")
    child.expect(".*\$ ")
    # If you are using pxssh you can use this
    # child.prompt()
    # child.expect("Your bash prompt here")
    # print(child.before)
    print(child.after)
    # child.expect(".*\$ ")
    # while True:
    # print(child.readlines(-1))
    # print(child.read_nonblocking())
    # print(child.readline())
    # print(child.after)
    # print(child.readlines(2))
    # print(child.after)
    # while child.stdout.readable:
    #     print(child.stdout.readline())
child.close()
