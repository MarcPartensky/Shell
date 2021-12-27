#!/usr/bin/env python

import sys
import subprocess

# subprocess.Popen

# useless_cat_call = subprocess.Popen(
#     ["cat"],
#     stdin=subprocess.PIPE,
#     stdout=subprocess.PIPE,
#     stderr=subprocess.PIPE,
#     text=True,
# )
# shell = subprocess.Popen(["echo"], stdin=sys.stdout, stdout=sys.stdin)
# output, errors = shell.communicate(input="Hello from the other side!")
# shell.wait()
# print(output)
# print(errors)
stdin = open("/tmp/stdin", "r")

process = subprocess.Popen(
    "bash",
    stdin=stdin,
    stdout=subprocess.PIPE,
    universal_newlines=True,
    bufsize=0,
)

while True:
    answer = input("q pour quitter:")
    if answer == "q":
        break
    print(process.stdout.readline())

process.stdin.close()
