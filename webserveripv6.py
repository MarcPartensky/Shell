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
    host = "::"
    if len(sys.argv) == 2:
        port = int(sys.argv[1])
    else:
        port = 8080
    server = HTTPServerV6((host, port), MyHandler)
    alladdr = socket.getaddrinfo(host, port)
    t = filter(lambda x: x[0] == socket.AF_INET6, alladdr)
    ipv6 = list(t)[0][4][0]
    url = "http://[" + ipv6 + "]:" + str(port)
    print("curl -g -6 '" + url + "/ip'")
    server.serve_forever()


if __name__ == "__main__":
    main()
