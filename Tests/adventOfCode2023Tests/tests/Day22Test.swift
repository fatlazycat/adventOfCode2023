import XCTest
import Parsing
import Foundation

class Day22Test : XCTestCase {
    
    func testPart1Dummy() {
        let bricks = parseData(data: day22DummyData.lines)
        XCTAssertEqual(5, bricksThatCanBeDisintegrated(bricks: bricks))
    }
    
    func testPart1() {
        let bricks = parseData(data: day22Data.lines)
        XCTAssertEqual(407, bricksThatCanBeDisintegrated(bricks: bricks))
    }
    
    func testPart2Dummy() {
        let bricks = parseData(data: day22DummyData.lines)
//        XCTAssertEqual(7, getTotalBricksThatCauseFall(bricks: bricks))
    }
    
    func testPart2() {
        let bricks = parseData(data: day22Data.lines)
//        XCTAssertEqual(59266, getTotalBricksThatCauseFall(bricks: bricks))
    }
    
    class Graph {
        var adjacencyList: [Brick: [Brick]]
        var parentCount: [Brick: Int]

        init() {
            adjacencyList = [Brick: [Brick]]()
            parentCount = [Brick: Int]()
        }

        func addEdge(from source: Brick, to destination: Brick) {
            if adjacencyList[source] == nil {
                adjacencyList[source] = [Brick]()
            }
            adjacencyList[source]?.append(destination)

            parentCount[destination, default: 0] += 1
        }
        
        func findAllRootNodes(for node: Brick) -> Set<Brick> {
                var visited = Set<Brick>()
                var rootNodes = Set<Brick>()

                func findRoots(currentNode: Brick) {
                    visited.insert(currentNode)
                    var isRoot = true

                    for (vertex, edges) in adjacencyList {
                        if edges.contains(currentNode) {
                            isRoot = false
                            if !visited.contains(vertex) {
                                findRoots(currentNode: vertex)
                            }
                        }
                    }

                    if isRoot {
                        rootNodes.insert(currentNode)
                    }
                }

                findRoots(currentNode: node)
                return rootNodes
        }
        
        func exclusiveDescendantsOfNode(_ node: Brick) -> [Brick] {
            var exclusiveDescendants = Set<Brick>()

            func findExclusiveDescendants(of node: Brick) {
                guard let children = adjacencyList[node] else { return }

                for child in children {
                    if parentCount[child] == 1 {
                        exclusiveDescendants.insert(child)
                        findExclusiveDescendants(of: child)
                    }
                }
            }

            findExclusiveDescendants(of: node)
            return Array(exclusiveDescendants)
        }
    }
    
    func testBricks() {
        let bricks = parseData(data: day22DummyData.lines)
        let supports = getSupportingBricks(bricks: bricks)
//        let beingSupportedBy = supports.reversedMappings()
        let brick1 = bricks.filter({$0.name == "1"}).first!
        
        let graph = Graph()
        
        supports.forEach({ kv in
            kv.value.forEach({ to in
                graph.addEdge(from: kv.key, to: to)
            })
        })
        
        
        print(graph.exclusiveDescendantsOfNode(brick1).count)
        
//        let rootNodes = bricks.map{ brick in
//            [brick : graph.findAllRootNodes(for: brick)]
//        }

//        print(rootNodes)
    }
    
    func part2(bricks: [Brick]) -> Int {
        let supports = getSupportingBricks(bricks: bricks)
        let canBeDisintigrated = getBricksSupportingButCanBeDisintegrated(supports: supports)
//        let candidates =
        
        return 0
    }
    
//    func isBrickBeingSupported(brick: Brick, disintegrated: [Brick], supports: [Brick: [Brick]], beingSupportedBy: [Brick: [Brick]]) -> Bool {
//        let brickBeingSupportedBy = beingSupportedBy[brick, default: []]
//        let remainingBricks = Set(brickBeingSupportedBy).subtracting(disintegrated)
//        
//        return remainingBricks.count != 0
//    }
//    
//    func checkBricks(bricks: [Brick], disintegrated: [Brick], supports: [Brick: [Brick]], beingSupportedBy: [Brick: [Brick]]) -> Set<Brick> {
//        
//        let bricksToDisintegrate = bricks.filter({!isBrickBeingSupported(brick: $0, disintegrated: disintegrated, supports: supports, beingSupportedBy: beingSupportedBy)})
//        
//        let children =  bricksToDisintegrate.map{ checkBricks(bricks: supports[$0, default: []], disintegrated: disintegrated + bricksToDisintegrate, supports: supports, beingSupportedBy: beingSupportedBy) }
//        
//        if children.isEmpty {
//            return Set(disintegrated)
//        }
//        else {
//            return foldl(sequence: children, base: Set<Brick>()) { acc, item in acc.union(item) }
//        }
//    }
    
    // ---
    
    func bricksThatCanBeDisintegrated(bricks: [Brick]) -> Int {
        let supports = getSupportingBricks(bricks: bricks)
        let canBeDisintigrated = getBricksSupportingButCanBeDisintegrated(supports: supports)
        let nonSupporting = Set(bricks).subtracting(supports.keys)
        
        return nonSupporting.count + canBeDisintigrated.count
    }
    
    func getBricksSupportingButCanBeDisintegrated(supports: [Brick : [Brick]]) -> [Brick] {
        let beingSupportedBy = supports.reversedMappings()
        
        let canBeDisintigrated = supports.keys.filter{ brick in
            let needsSupporting = supports[brick]!
            return needsSupporting.allSatisfy({ beingSupportedBy[$0]!.count > 1 })
        }
        
        return canBeDisintigrated
    }
    
    func getSupportingBricks(bricks: [Brick]) -> [Brick : [Brick]] {
        let orderedClosestToFloor = bricks.sorted(by: { lhs, rhs in
            lhs.lowestZ < rhs.lowestZ
        })
        var highestPoint = [Point : Int]()
        var brickAtPoint = [Point : Brick?]()
        var supports = [Brick : [Brick]]() // Brick underneath supports value
        
        orderedClosestToFloor.forEach({ brick in
            let pointsOfBrick = brick.pointsBetween()
            let highestPointOnFloor = pointsOfBrick.map{ highestPoint[$0, default: 1] }.max()!
            
            pointsOfBrick.forEach({ point in
                let b = brickAtPoint[point]
                let zVal = highestPoint[point, default: 1]
                
                if zVal == highestPointOnFloor && b != nil {
                    supports.addDistinctValue(forKey: b!!, value: brick)
                }
            })
            
            if brick.orintationInXY == .OnEnd {
                let point = Point(brick.start.x, brick.start.y)
                highestPoint[point] = highestPointOnFloor + brick.height
                brickAtPoint[point] = brick
            }
            else {
                pointsOfBrick.forEach({ point in
                    highestPoint[point] = highestPointOnFloor + 1
                    brickAtPoint[point] = brick
                })
            }
        })
        
        return supports
    }
    
    struct Brick: Equatable, Hashable {
        let start: Point3D
        let end: Point3D
        let name: String
        
        var lowestZ : Int {
            min(start.z, end.z)
        }
        
        var lowerBoundX : Int {
            [start.x, end.x].min()!
        }
        
        var upperBoundX : Int {
            [start.x, end.x].max()! + 1
        }
        
        var lowerBoundY : Int {
            [start.y, end.y].min()!
        }
        
        var upperBoundY : Int {
            [start.y, end.y].max()! + 1
        }
        
        var lowerBoundZ : Int {
            [start.z, end.z].min()!
        }
        
        var upperBoundZ : Int {
            [start.z, end.z].max()! + 1
        }
        
        var height : Int {
            upperBoundZ - lowerBoundZ
        }
        
        var orintationInXY: OrientationInXY {
            if start.x != end.x && start.y == end.y && start.z == end.z {
                OrientationInXY.Horizontal
            } 
            else if start.x == end.x && start.y != end.y && start.z == end.z {
                OrientationInXY.Vertical
            }
            else if start.x == end.x && start.y == end.y && start.z != end.z {
                OrientationInXY.OnEnd
            }
            else if start.x == end.x && start.y == end.y && start.z == end.z {
                OrientationInXY.SingleCube
            }
            else {
                fatalError("Bricks not helpful")
            }
        }
        
        func pointsBetween() -> [Point] {
            var points = [Point]()

            let xRange = start.x <= end.x ? (start.x...end.x) : (end.x...start.x)
            let yRange = start.y <= end.y ? (start.y...end.y) : (end.y...start.y)

            for x in xRange {
                for y in yRange {
                    points.append(Point(x, y))
                }
            }

            return points
        }
    }
    
    enum OrientationInXY {
        case Horizontal
        case Vertical
        case OnEnd
        case SingleCube
    }
    
    func parseData(data: [String]) -> [Brick] {
        var name = 1
        var result = [Brick]()
        
        data.forEach({ line in
            let v = try! rowParser.parse(line)
            result.append(Brick(start: Point3D(v.0, v.1, v.2), end: Point3D(v.3, v.4, v.5), name: String(name)))
            name = name + 1
        })
        
        return result
    }
    
    let rowParser = Parse(input: Substring.self) {
        Int.parser()
        ","
        Int.parser()
        ","
        Int.parser()
        "~"
        Int.parser()
        ","
        Int.parser()
        ","
        Int.parser()
    }
}
