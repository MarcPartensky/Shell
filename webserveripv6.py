#!/usr/bin/env python2

import sys
import socket

from BaseHTTPServer import HTTPServer
from SimpleHTTPServer import SimpleHTTPRequestHandler


class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/ip":
            self.send_response(200)
            self.send_header("Content-type", "text/html")
            self.end_headers()
            self.wfile.write("Your IP address is %s" % self.client_address[0])
            return
        else:
            return SimpleHTTPRequestHandler.do_GET(self)


class HTTPServerV6(HTTPServer):
    address_family = socket.AF_INET6


def main():
    if len(sys.argv) == 2:
        port = int(sys.argv[1])
    else:
        port = 8080
    server = HTTPServerV6(("::", port), MyHandler)
    server.serve_forever()


if __name__ == "__main__":
    print("curl -g -6  'http://[fe80::e070:b736:bd38:caac%wlp3s0]:8080/ip'")
    main()
