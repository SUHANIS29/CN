# import socket
# server_ip="127.0.0.1"
# server_port=12345
# server_socket=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

# server_socket.bind((server_ip,server_port))

# print("server is ready")
# #receive data from client
# while True:
#   data,client_address=server_socket.recvfrom(1024)
#   print("data received from client:",data.decode())
#   print("client address:",client_address)
# #send ack to client
# server_socket.sendto("ack",client_address)

import socket 
socket_ip="127.0.0.1"
socket_port=12345

client_socket=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
msg="hello from client"
client_socket.sendto(msg.encode(),(socket_ip,socket_port))
data,server_address=client_socket.recvfrom(1024)
print("Server says:", data.decode())
print("Closing client socket...")
client_socket.close()