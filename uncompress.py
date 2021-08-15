#!/usr/bin/env python

import re
import os
import shutil


pattern = re.compile(r"_([0-9]{4}-[01][0-9]-[0-3][0-9]_[0-2][0-9])")

for node in os.listdir("/srv"):

    # os.rename(node)

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
    os.system(f"tar xvzf {node} /srv")
