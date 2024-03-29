#!/usr/bin/env python

import argparse
import socket
from threading import Thread


def scan(ip, port):
    try:
        connSkt = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        connSkt.connect((ip, port))
        print(port, "tcp open")
        connSkt.close()
    except:
        pass


def main():
    parser = argparse.ArgumentParser(description="A port scanner")
    parser.add_argument("host", type=str, help="target host")
    args = parser.parse_args()

    host = args.host
    try:
        ip = socket.gethostbyname(host)
    except:
        print("Cannot resolve", host)
        exit(1)

    socket.setdefaulttimeout(1)
    for port in range(65536):
        t = Thread(target=scan, args=(ip, port))
        t.start()


if __name__ == "__main__":
    main()
