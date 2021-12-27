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
child.logfile = sys.stdout
# child.expect("Your bash prompt here")
child.sendline("cd")
child.expect(".*\$ ")
# If you are using pxssh you can use this
# child.prompt()
# child.expect("Your bash prompt here")
print(child.before)
# child.expect("Your bash prompt here")
child.sendline("ls")
child.expect(".*\$ ")
# If you are using pxssh you can use this
# child.prompt()
# child.expect("Your bash prompt here")
print(child.before)
child.expect(".*\$ ")
child.close()
