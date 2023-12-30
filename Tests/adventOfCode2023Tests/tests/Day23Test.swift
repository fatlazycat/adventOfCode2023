import XCTest
import Parsing
import Foundation

class Day23Test : XCTestCase {
    
    func testPart1Dummy() {
        let scenery = parseData(lines: day23DummyData.lines)
        let start = Point(scenery.first!.enumerated().first(where: { $0.1 == .Path })!.0, 0)
        let end = Point(scenery.last!.enumerated().first(where: { $0.1 == .Path })!.0, scenery.count-1)
        XCTAssertEqual(94, part1LongestPath(scenery: scenery, start: start, end: end))
    }
    
    func testPart1() {
        let scenery = parseData(lines: day23Data.lines)
        let start = Point(scenery.first!.enumerated().first(where: { $0.1 == .Path })!.0, 0)
        let end = Point(scenery.last!.enumerated().first(where: { $0.1 == .Path })!.0, scenery.count-1)
        XCTAssertEqual(2394, part1LongestPath(scenery: scenery, start: start, end: end))
    }
    
    func testPart2Dummy() {
        let scenery = parseData(lines: day23DummyData.lines)
        let start = Point(scenery.first!.enumerated().first(where: { $0.1 == .Path })!.0, 0)
        let end = Point(scenery.last!.enumerated().first(where: { $0.1 == .Path })!.0, scenery.count-1)
        XCTAssertEqual(154, part2LongestPath(scenery: scenery, start: start, end: end))
    }
    
// Slow running
//    func testPart2() {
//        let scenery = parseData(lines: day23Data.lines)
//        let start = Point(scenery.first!.enumerated().first(where: { $0.1 == .Path })!.0, 0)
//        let end = Point(scenery.last!.enumerated().first(where: { $0.1 == .Path })!.0, scenery.count-1)
//        XCTAssertEqual(6554, part2LongestPath(scenery: scenery, start: start, end: end))
//    }
    
    func testBlah() {
        var g = Graph()
        
        addPoint(from: 1, to: 2, graph: &g)
        addPoint(from: 2, to: 3, graph: &g)
        addPoint(from: 2, to: 20, graph: &g)
        addPoint(from: 20, to: 21, graph: &g)
        addPoint(from: 3, to: 4, graph: &g)
        addPoint(from: 3, to: 9, graph: &g)
        addPoint(from: 4, to: 5, graph: &g)
        addPoint(from: 5, to: 6, graph: &g)
        addPoint(from: 6, to: 7, graph: &g)
        addPoint(from: 6, to: 12, graph: &g)
        addPoint(from: 7, to: 8, graph: &g)
        addPoint(from: 8, to: 10, graph: &g)
        addPoint(from: 10, to: 9, graph: &g)
        addPoint(from: 10, to: 11, graph: &g)
        addPoint(from: 11, to: 12, graph: &g)
        addPoint(from: 12, to: 13, graph: &g)
        addPoint(from: 13, to: 14, graph: &g)
        
        g.printDagForGraphviz()
        g.simplifyGraph(start: Point(1, 1), end: Point(14, 14))
        g.printDagForGraphviz()
    }
    
    func addPoint(from: Int, to: Int, graph: inout Graph) {
        graph.addEdge(from: Point(from, from), to: Point(to, to))
        graph.addEdge(from: Point(to, to), to: Point(from, from))
    }
    
    func part1LongestPath(scenery: [[Day23Test.Ground]], start: Point, end: Point) -> Int {
        let sceneryValues = scenery.enumerated().flatMap{ (y, row) in
            row.enumerated().map{ (x, item) in (Point(x,y), item) }
        }
        let sceneryDict = Dictionary(uniqueKeysWithValues: sceneryValues)
        let dg = DynamicGraph()
        let determineNextNodes: (Point) -> Set<Point> = { current in
            var nextNodes = Set<Point>()
            
            if let nextLocation = sceneryDict[Point(current.x, current.y - 1)] {
                if nextLocation == .Up || nextLocation == .Path {
                    nextNodes.insert(Point(current.x, current.y - 1))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x, current.y + 1)] {
                if nextLocation == .Down || nextLocation == .Path {
                    nextNodes.insert(Point(current.x, current.y + 1))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x - 1, current.y)] {
                if nextLocation == .Left || nextLocation == .Path {
                    nextNodes.insert(Point(current.x - 1, current.y))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x + 1, current.y)] {
                if nextLocation == .Right || nextLocation == .Path {
                    nextNodes.insert(Point(current.x + 1, current.y))
                }
            }
            
            return nextNodes
        }
        
        let isEndpoint: (Point) -> Bool = { point in
            point == end
        }
        
        let longestPath = dg.findLongestPath(startingAt: start, determineNextNodes: determineNextNodes, isEndpoint: isEndpoint)
        
        return longestPath.count-1
    }
    
    func printPoints(data: [Point : Ground], path: [Point], width: Int, height: Int) {
        let pathAsSet = Set(path)
        
        (0..<height).forEach({ y in
            let chars = (0..<width).map{ x in
                let p = Point(x, y)
                if pathAsSet.contains(p) {
                    return "O"
                } else {
                    return String(data[p]!.rawValue)
                }
            }.joined()
            
            print(chars)
        })
    }
    
    enum Ground : Character {
        case Path = "."
        case Forest = "#"
        case Up = "^"
        case Down = "v"
        case Left = "<"
        case Right = ">"
    }
    
    func parseData(lines: [String]) -> [[Ground]] {
        lines.map{ $0.toCharArray().map{ Ground.init(rawValue: $0)! } }
    }
  
    class DynamicGraph {
        var longestPath: [Point] = []
        var nextNodesCache: [Point: Set<Point>] = [:]

        func findLongestPath(startingAt startNode: Point, determineNextNodes: (Point) -> Set<Point>, isEndpoint: (Point) -> Bool) -> [Point] {
            var stack: [(Point, [Point], Set<Point>)] = [(startNode, [startNode], Set([startNode]))]

            while !stack.isEmpty {
                let (currentNode, currentPath, visited) = stack.removeLast()

                if isEndpoint(currentNode) {
                    if currentPath.count > longestPath.count {
                        print("new longest path \(currentPath.count)")
                        longestPath = currentPath
                    }
                    continue
                }

                if nextNodesCache[currentNode] == nil {
                    nextNodesCache[currentNode] = determineNextNodes(currentNode)
                }

                for nextNode in nextNodesCache[currentNode]! where !visited.contains(nextNode) {
                    var newPath = currentPath
                    newPath.append(nextNode)

                    var newVisited = visited
                    newVisited.insert(nextNode)

                    stack.append((nextNode, newPath, newVisited))
                }
            }

            return longestPath
        }
    }
    
    func part2LongestPath(scenery: [[Day23Test.Ground]], start: Point, end: Point) -> Int {
        let sceneryValues = scenery.enumerated().flatMap{ (y, row) in
            return row.enumerated().map{ (x, item) in
                return (Point(x,y), item)
            }
        }
        let sceneryDict = Dictionary(uniqueKeysWithValues: sceneryValues)
        let nodes = sceneryDict.filter({ $0.value != .Forest }).map{ $0.key }
        let graph = Graph()
        
        print("starting nodes \(nodes.count)")
        
        nodes.forEach({ current in
            if let nextLocation = sceneryDict[Point(current.x, current.y - 1)] {
                if nextLocation != .Forest {
                    graph.addEdge(from: current, to: Point(current.x, current.y - 1))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x, current.y + 1)] {
                if nextLocation != .Forest {
                    graph.addEdge(from: current, to: Point(current.x, current.y + 1))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x - 1, current.y)] {
                if nextLocation != .Forest {
                    graph.addEdge(from: current, to: Point(current.x - 1, current.y))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x + 1, current.y)] {
                if nextLocation != .Forest {
                    graph.addEdge(from: current, to: Point(current.x + 1, current.y))
                }
            }
        })

        
        graph.simplifyGraph(start: start, end: end)
        
        print("simplified nodes \(graph.getNodes().count)")
        
        return graph.longestPath(from: start, to: end).0
    }
    
    //----------
    
    struct PairPoint: Equatable, Hashable {
        var from: Point
        var to: Point
    }
    
    class Graph {
        private var edges: [PairPoint : Int] = [:]
        private var connections: [Point: Set<Point>] = [:]
        
        func addEdge(from: Point, to: Point, weight: Int = 1) {
            edges[PairPoint(from: from, to: to)] = weight
            connections[from, default: []].insert(to)
        }
        
        func getNodes() -> Set<Point> {
            Set(connections.keys)
        }
        
        func printDagForGraphviz() {
            print("-------")
            print("digraph G {")
            connections.keys.forEach({ p in
                let cons = connections[p]!
                
                cons.forEach({ output in
                    let weight = edges[PairPoint(from: p, to: output)]!
                    print("\(p.x) -> \(output.x) [xlabel=\(weight)];")
                })
            })
            print("}")
            print("-------")
        }
        
        func simplifyGraph(start: Point, end: Point) {
            let nodes = Array(connections.keys).filter({isJunctionNode($0)}).filter({ node in
                connections[node]!.count > 2 ||
                node == start ||
                node == end
            })
            
            nodes.forEach({ node in
                // When we are a junction node, process until all paths are remove
                while !onlyConnectedToJunctionNode(node) {
                    let neighbours = connections[node]!
                    let firstPathNeighbour = neighbours.filter({!isJunctionNode($0)}).first!
                    let chain = chain(prevNode: node, nextNode: firstPathNeighbour, acc: [node, firstPathNeighbour])
                    let chainWeight = chainWeight(chain: chain)
                    let pairs = chain.windowed(size: 2)

                    let lastOfChain = chain.last!
                    
                    // If end of chain was a dead end then just remove
                    if connections[lastOfChain]!.count == 1 && lastOfChain != start && lastOfChain != end {
                        pairs.forEach({ p in
                            _ = edges.removeValueFor(forKey: PairPoint(from: p[0], to: p[1]))
                            _ = edges.removeValueFor(forKey: PairPoint(from: p[1], to: p[0]))
                            let fromValues = connections[p[0]]!
                            connections[p[0]] = fromValues.filter({ $0 != p[1] })
                            let toValues = connections[p[1]]!
                            connections[p[1]] = toValues.filter({ $0 != p[0] })
                        })
                    }
                    else {
                        // remove old chain
                        pairs.forEach({ p in
                            _ = edges.removeValueFor(forKey: PairPoint(from: p[0], to: p[1]))
                            _ = edges.removeValueFor(forKey: PairPoint(from: p[1], to: p[0]))
                            let fromValues = connections[p[0]]!
                            connections[p[0]] = fromValues.filter({ $0 != p[1] })
                            let toValues = connections[p[1]]!
                            connections[p[1]] = toValues.filter({ $0 != p[0] })
                        })

                        // add in direct connection
                        edges[PairPoint(from: chain.first!, to: chain.last!)] = chainWeight
                        edges[PairPoint(from: chain.last!, to: chain.first!)] = chainWeight
                        connections[chain.first!]!.insert(chain.last!)
                        connections[chain.last!]!.insert(chain.first!)
                    }

                }
            })
            
            connections = connections.filter({ !$0.value.isEmpty })
        }
        
        func chain(prevNode: Point, nextNode: Point, acc: [Point]) -> [Point] {
            if isJunctionNode(nextNode) {
                return acc
            }
            else {
                let connections = connections[nextNode]!.filter({ $0 != prevNode })
                
                if connections.count != 1 {
                    fatalError("Should only be 1 connection")
                }
                
                let nextInChain = connections.first!
                
                return chain(prevNode: nextNode, nextNode: nextInChain, acc: acc + [nextInChain])
            }
        }
        
        func chainWeight(chain: [Point]) -> Int {
            let pairs = chain.windowed(size: 2)
            let weights = pairs.map{ p in edges[PairPoint(from: p[0], to: p[1])]! }
            
            return weights.reduce(0, +)
        }
        
        private func isJunctionNode(_ node: Point) -> Bool {
            let count = connections[node]?.count ?? 0
            return count != 2 // Not a path node
        }
        
        private func onlyConnectedToJunctionNode(_ node: Point) -> Bool {
//            if !isJunctionNode(node) {
//                print("\(node) \(connections[node]!)")
//                fatalError("Should not be calling this function on a non junction node")
//            }
            
            let neighbours = connections[node]!
            
            return neighbours.allSatisfy({isJunctionNode($0)})
        }
        
        func longestPath(from start: Point, to end: Point) -> (totalWeight: Int, path: [Point]) {
            var visited: Set<Point> = []
            var longestPath: [Point] = []
            var currentPath: [Point] = []
            var longestWeight = 0

            dfs(current: start, end: end, currentWeight: 0, longestWeight: &longestWeight, currentPath: &currentPath, longestPath: &longestPath, visited: &visited)

            return (longestWeight, longestPath)
        }

        private func dfs(current: Point, end: Point, currentWeight: Int, longestWeight: inout Int, currentPath: inout [Point], longestPath: inout [Point], visited: inout Set<Point>) {
            visited.insert(current)
            currentPath.append(current)

            if current == end {
                if currentWeight > longestWeight {
                    longestWeight = currentWeight
                    longestPath = currentPath
                }
            } else {
                for neighbor in connections[current, default: []] {
                    if !visited.contains(neighbor) {
                        let edge = PairPoint(from: current, to: neighbor)
                        let weight = edges[edge, default: 0]
                        dfs(current: neighbor, end: end, currentWeight: currentWeight + weight, longestWeight: &longestWeight, currentPath: &currentPath, longestPath: &longestPath, visited: &visited)
                    }
                }
            }

            visited.remove(current)
            currentPath.removeLast()
        }
    }
}
