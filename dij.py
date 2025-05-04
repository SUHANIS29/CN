import heapq

class LSRouter:
    def __init__(self, name):
        self.name = name
        self.links = {} 

    def add_link(self, neighbor_name, cost):
        self.links[neighbor_name] = cost

    def dijkstra(self, network):
        distances = {node: float('inf') for node in network}
        previous = {node: None for node in network}
        distances[self.name] = 0
        heap = [(0, self.name)]

        while heap:
            current_cost, current_node = heapq.heappop(heap)
            for neighbor, cost in network[current_node].links.items():
                new_cost = current_cost + cost
                if new_cost < distances[neighbor]:
                    distances[neighbor] = new_cost
                    previous[neighbor] = current_node
                    heapq.heappush(heap, (new_cost, neighbor))

        return distances, previous

    def print_paths(self, network):
        distances, previous = self.dijkstra(network)
        print("Link State Routing Table for", self.name)
        for dest in sorted(distances):
            if dest == self.name:
                continue
            path = []
            current = dest
            while current:
                path.insert(0, current)
                current = previous[current]
            print("  To", dest, "cost:", distances[dest], "path:", " -> ".join(path))
        print()


network = {
    'A': LSRouter('A'),
    'B': LSRouter('B'),
    'C': LSRouter('C'),
    'D': LSRouter('D')
}

network['A'].add_link('B', 1)
network['A'].add_link('C', 5)
network['B'].add_link('A', 1)
network['B'].add_link('C', 2)
network['B'].add_link('D', 4)
network['C'].add_link('A', 5)
network['C'].add_link('B', 2)
network['C'].add_link('D', 1)
network['D'].add_link('B', 4)
network['D'].add_link('C', 1)

# Output
print("=== Link State Routing Tables ===")
for r in network.values():
    r.print_paths(network)
