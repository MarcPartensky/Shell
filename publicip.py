#!/usr/bin/env python

import sys
import os

if sys.argv[1] == "ip":
    print(os.system("curl -s ipconfig.io"))
