import XCTest
import Parsing
import Foundation

class Day22Test : XCTestCase {
    
    func testPart1Dummy() {
        let bricks = parseData(data: day22DummyData.lines)
        XCTAssertEqual(5, lowerBricksToFloor(bricks: bricks))
    }
    
    func testPart1() {
        let bricks = parseData(data: day22Data.lines)
        XCTAssertEqual(407, lowerBricksToFloor(bricks: bricks))
    }
    
    func lowerBricksToFloor(bricks: [Brick]) -> Int {
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
        
        let beingSupportedBy = supports.reversedMappings()
        
        let canBeDisintigrated = supports.keys.filter{ brick in
            let needsSupporting = supports[brick]!
            return needsSupporting.allSatisfy({ beingSupportedBy[$0]!.count > 1 })
        }
        
        // Get non supporting
        let allBricks = Set(orderedClosestToFloor)
        let nonSupporting = allBricks.subtracting(supports.keys)
        
        return nonSupporting.count + canBeDisintigrated.count
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
