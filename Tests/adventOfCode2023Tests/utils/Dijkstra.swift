import Foundation

class Edge {
    var target: Node
    var weight: Int

    init(target: Node, weight: Int) {
        self.target = target
        self.weight = weight
    }
}

class EdgeDefinition {
    var source: Node
    var target: Node
    var weight: Int

    init(source: Node, target: Node, weight: Int) {
        self.source = source
        self.target = target
        self.weight = weight
    }
}

class Node: Equatable {
    var edges: [Edge]
    var distanceFromSource = Int.max
    var visited = false
    var identifier: Point

    init(identifier: Point) {
        self.identifier = identifier
        self.edges = []
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class Graph {
    var nodes: [Node]

    init() {
        self.nodes = []
    }

    func addNode(identifier: Point) -> Node {
        let node = Node(identifier: identifier)
        nodes.append(node)
        return node
    }
    
    func addNode(node: Node) {
        nodes.append(node)
    }


    func addEdge(source: Node, destination: Node, weight: Int) {
        let edge = Edge(target: destination, weight: weight)
        source.edges.append(edge)
    }

    func processDijkstra(source: Node) {
        source.distanceFromSource = 0
        var queue = [Node]()
        queue.append(source)

        while !queue.isEmpty {
            let currentNode = queue.removeFirst()
            currentNode.visited = true

            for edge in currentNode.edges {
                let targetNode = edge.target
                let newDistance = currentNode.distanceFromSource + edge.weight
                if newDistance < targetNode.distanceFromSource {
                    targetNode.distanceFromSource = newDistance
                    if !queue.contains(where: { $0 == targetNode }) {
                        queue.append(targetNode)
                    }
                }
            }
            queue.sort { $0.distanceFromSource < $1.distanceFromSource }
        }
    }
}
