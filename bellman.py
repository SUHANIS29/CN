class Router:
    def __init__(self, name):
        self.name = name
        self.neighbors = {}  # neighbor: cost
        self.routing_table = {name: (0, name)}  # destination: (cost, next_hop)

    def add_neighbor(self, neighbor, cost):
        self.neighbors[neighbor] = cost
        self.routing_table[neighbor.name] = (cost, neighbor.name)

    def update_table(self):
        updated = False
        for neighbor, cost_to_neighbor in self.neighbors.items():
            for dest, (neighbor_cost, _) in neighbor.routing_table.items():
                new_cost = cost_to_neighbor + neighbor_cost
                if dest not in self.routing_table or new_cost < self.routing_table[dest][0]:
                    self.routing_table[dest] = (new_cost, neighbor.name)
                    updated = True
        return updated

    def print_table(self):
        print("Routing table for Router", self.name)
        for dest in sorted(self.routing_table):
            cost, next_hop = self.routing_table[dest]
            print("  To", dest, "via", next_hop, "cost:", cost)
        print()

# Network Topology
A = Router("A")
B = Router("B")
C = Router("C")
D = Router("D")

A.add_neighbor(B, 1)
A.add_neighbor(C, 5)
B.add_neighbor(A, 1)
B.add_neighbor(C, 2)
B.add_neighbor(D, 4)
C.add_neighbor(A, 5)
C.add_neighbor(B, 2)
C.add_neighbor(D, 1)
D.add_neighbor(B, 4)
D.add_neighbor(C, 1)

routers = [A, B, C, D]

# Run DVR until convergence
converged = False
while not converged:
    converged = True
    for r in routers:
        if r.update_table():
            converged = False

# Output
print("=== Distance Vector Routing Tables ===")
for r in routers:
    r.print_table()
