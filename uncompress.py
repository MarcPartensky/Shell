#!/usr/bin/env python

import os
import shutil


for node in os.listdir("/srv"):
    print(node)
    if not node.endswith(".tar.gz"):
        if os.path.isdir(node):
            shutil.rmtree(node)
        else:
            os.remove(node)
        continue
    name = node.split(".")[0]
    try:
        os.mkdir(name)
    except:
        print(f"{name} already exists")
    os.system(f"tar xvzf {node}")
