# import socket
# server_id="127.0.0.1"
# server_port=12345

# client_socket=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)

# #msg to client
# msg="hello from server"
# client_socket.sendto(msg.encode(),(server_id,server_port))

# #response from client
# data,server_address=client_socket.recvfrom(1024)


import socket
server_ip="127.0.0.1"
server_port=12345

server_socket=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
server_socket.bind((server_ip,server_port))
print("serve ready")
data,client_address=server_socket.recvfrom(1024)
print("data received from client:",data.decode())

server_socket.sendto("ack".encode(),client_address)
print("Closing server socket...")
server_socket.close()


