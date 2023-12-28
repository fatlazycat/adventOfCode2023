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
        XCTAssertEqual(7, disintegrateBricks(allBricks: bricks))
    }
    
    func testPart2() {
        let bricks = parseData(data: day22Data.lines)
//        XCTAssertEqual(59266, getTotalBricksThatCauseFall(bricks: bricks))
    }
    
    func testBricks() {
        let bricks = parseData(data: day22DummyData.lines)
        let supports = getSupportingBricks(bricks: bricks)
//        let beingSupportedBy = supports.reversedMappings()
        let brick1 = bricks.filter({$0.name == "1"}).first!
        let brick2 = bricks.filter({$0.name == "2"}).first!
        let brick7 = bricks.filter({$0.name == "7"}).first!
        
        let dag = DAG()
        
        supports.forEach({ kv in
            kv.value.forEach({ to in
                dag.addDependency(from: kv.key, to: to)
            })
        })
        
        
        print(dag.getAllDescendants(of: brick1).count)
        print(dag.getAllDescendants(of: brick2).count)
        print(dag.getRootNodes(of: brick7).first!.name)
        print(dag.getRootNodes(of: brick2).first!.name)
        
//        let rootNodes = bricks.map{ brick in
//            [brick : graph.findAllRootNodes(for: brick)]
//        }

//        print(rootNodes)
    }
    
    func disintegrateBricks(allBricks: [Brick]) -> Int {
        let supports = getSupportingBricks(bricks: allBricks)
        let beingSupportedBy = supports.reversedMappings()
        let canBeDisintigrated = getBricksSupportingButCanBeDisintegrated(supports: supports)
        let nonSupporting = Set(allBricks).subtracting(supports.keys)
        let candidates = Set(supports.keys).subtracting(canBeDisintigrated)
        
        let results = candidates.map{ checkBricks(brick: $0, disintegrated: Set([$0]), supports: supports, beingSupportedBy: beingSupportedBy) }
        let resultCount = results.map{ $0.count - 1}
        
        return resultCount.reduce(0, +)
    }
    
    func isBrickBeingSupported(brick: Brick, disintegrated: Set<Brick>, supports: [Brick: [Brick]], beingSupportedBy: [Brick: [Brick]]) -> Bool {
        let brickBeingSupportedBy = beingSupportedBy[brick, default: []]
        let remainingBricks = Set(brickBeingSupportedBy).subtracting(disintegrated)

        return remainingBricks.count != 0
    }

    func checkBricks(brick: Brick, disintegrated: Set<Brick>, supports: [Brick: [Brick]], beingSupportedBy: [Brick: [Brick]]) -> Set<Brick> {

        // is brick being supported ? If not disintigrate and continue
        if !isBrickBeingSupported(brick: brick, disintegrated: disintegrated, supports: supports, beingSupportedBy: beingSupportedBy) {
            let updatedDisintegrated = disintegrated.union([brick])
            
            if let children = supports[brick] {
                let childResults = children.map{ checkBricks(brick: $0, disintegrated: updatedDisintegrated, supports: supports, beingSupportedBy: beingSupportedBy) }
                return foldl(sequence: childResults, base: updatedDisintegrated) { acc, item in acc.union(item) }
            }
            else {
                // No children just return the set upto this point
                return updatedDisintegrated
            }
        }
        else {
            // Brick is supported so just stop here
            return disintegrated
        }
    }
    
    class DAG {
        var dependencies: [Brick: [Brick]]
        var reverseDependencies: [Brick: [Brick]]
        
        init() {
            dependencies = [:]
            reverseDependencies = [:]
        }
        
        // Add a dependency (edge) from one brick to another
        func addDependency(from parent: Brick, to child: Brick) {
            dependencies[parent, default: []].append(child)
            reverseDependencies[child, default: []].append(parent)
        }
        
        // Function to get all descendants of a brick
        func getAllDescendants(of brick: Brick) -> [Brick] {
            var descendants = [Brick]()
            var visited = Set<Brick>()
            
            func dfs(_ brick: Brick) {
                visited.insert(brick)
                if let children = dependencies[brick] {
                    for child in children {
                        if !visited.contains(child) {
                            descendants.append(child)
                            dfs(child)
                        }
                    }
                }
            }
            
            dfs(brick)
            return descendants
        }
        
        // Function to get all root nodes for a given brick
        func getRootNodes(of brick: Brick) -> [Brick] {
            var roots = [Brick]()
            var visited = Set<Brick>()
            
            func dfs(_ brick: Brick) {
                visited.insert(brick)
                if let parents = reverseDependencies[brick], !parents.isEmpty {
                    for parent in parents {
                        if !visited.contains(parent) {
                            dfs(parent)
                        }
                    }
                } else {
                    // If a brick has no parents, it's a root node
                    roots.append(brick)
                }
            }
            
            dfs(brick)
            return roots
        }
    }
    
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
