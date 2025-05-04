import socket
server_ip = "127.0.0.1"
server_port = 12345
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind((server_ip, server_port))
server_socket.listen(1)
print("Server is ready ! waiting for client...")
conn, addr = server_socket.accept()
print("Connection from:", addr)
data = conn.recv(1024)
print("Client msg:", data.decode())
conn.send("msg received from client".encode())
print("Closing connection...")
conn.close()
server_socket.close()

