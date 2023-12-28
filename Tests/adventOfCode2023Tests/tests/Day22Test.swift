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
        let bricks = Set(parseData(data: day22DummyData.lines))
        XCTAssertEqual(7, disintegrateBricks(allBricks: bricks))
    }
    
    func testPart2() {
        let bricks = Set(parseData(data: day22Data.lines))
        XCTAssertEqual(59266, disintegrateBricks(allBricks: bricks))
    }
    
    func testDis() {
        let allBricks = Set(parseData(data: day22DummyData.lines))
        let supports = getSupportingBricks(bricks: Array(allBricks))
        let beingSupportedBy = supports.reversedMappings()
        let brick1 = allBricks.filter({$0.name == "1"}).first!
        
        let result = bricksDisintegrated(startBrick: brick1, allBricks: allBricks, supports: supports, beingSupportedBy: beingSupportedBy)
        
        print(result.count)
    }
    
    func disintegrateBricks(allBricks: Set<Brick>) -> Int {
        let supports = getSupportingBricks(bricks: Array(allBricks))
        let beingSupportedBy = supports.reversedMappings()
        let canBeDisintigrated = getBricksSupportingButCanBeDisintegrated(supports: supports)
        let candidates = Set(supports.keys).subtracting(canBeDisintigrated)
   
        let results = candidates.map{ bricksDisintegrated(startBrick: $0, allBricks: allBricks, supports: supports, beingSupportedBy: beingSupportedBy) }
        let resultCount = results.map{ $0.count }
        
        return resultCount.reduce(0, +)
    }
    
    func bricksDisintegrated(startBrick: Brick, allBricks: Set<Brick>, supports: [Brick: [Brick]], beingSupportedBy: [Brick: [Brick]]) -> Set<Brick> {
        var disintegratedBricks = Set([startBrick])
        var fixedBricks = Set<Brick>()
        var nodes = supports[startBrick, default: []]
        
        while !nodes.isEmpty {
            let node = nodes.removeFirst()
            
            if canDisintegrate(brick: node, beingSupportedBy: beingSupportedBy, disintegratedBricks: &disintegratedBricks, fixedBricks: &fixedBricks) {
                nodes.append(contentsOf: supports[node, default: []])
            }
        }
        
        return disintegratedBricks.subtracting([startBrick])
    }
    
    func canDisintegrate(brick: Brick, 
                        beingSupportedBy: [Brick: [Brick]],
                        disintegratedBricks: inout Set<Brick>,
                        fixedBricks: inout Set<Brick>
    ) -> Bool {
        
        var nodes = [brick]
        
        while !nodes.isEmpty {
            let node = nodes.removeFirst()
            
            if fixedBricks.contains(node) {
                return false
            }
            else if disintegratedBricks.contains(node) {
                return true
            }
            else {
                // Get supporting nodes
                let supports = beingSupportedBy[node, default: []]
                
                if supports.isEmpty {
                    // We are at a root node, so consider supported
                    fixedBricks.insert(node)
                }
                else if supports.anySatisfy({ fixedBricks.contains($0) }) {
                    // We have a fixed brick in the parents, so state we are fixed
                    fixedBricks.insert(node)
                }
                else if supports.allSatisfy({ disintegratedBricks.contains($0) }) {
                    // All supports disintegrated
                    disintegratedBricks.insert(node)
                }
                else {
                    // Process supports and reinsert
                    nodes.insert(node, at: 0)
                    nodes.insert(contentsOf: supports, at: 0)
                }
            }
        }
        
        return disintegratedBricks.contains(brick)
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
