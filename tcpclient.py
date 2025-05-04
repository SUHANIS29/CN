import socket
server_ip = "127.0.0.1"
server_port = 12345
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect((server_ip,server_port))
client_socket.send("Hello Server!".encode())
data = client_socket.recv(1024)
print("Server's msg:", data.decode())
print("Closing client socket...")
client_socket.close()
