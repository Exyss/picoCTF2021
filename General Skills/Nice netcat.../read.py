import socket
import sys

hostname = sys.argv[2]
port = int(sys.argv[3])

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((hostname, port))

# Read all incoming data
r = ""
while True:
    data = s.recv(1)
    if not data:
        break
    r += data.decode()

s.close()
numbers = r.splitlines()

for n in numbers:
    print(chr(int(n)), end="")