import XCTest
import Parsing
import Foundation

class Day17Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parseData(lines: day17DummyData.lines)
        let width = data[0].count
        let height = data.count
        let start = PathPoint(Point(0, 0), Direction.East, 0)
        let end = Point(width-1, height-1)
        
        let path = findShortestPathByPredicate(
            start: start,
            endFunction: { p in p.p == end },
            neighbours: { $0.neighbours().filter({ n in
                n.p.x >= 0 && n.p.x < width && n.p.y >= 0 && n.p.y < height })},
            heuristic: { p in data[p.p.y][p.p.x] })
        
        XCTAssertEqual(102, path.getScore())
    }
    
    func parseData(lines: [String]) -> [[Int]] {
        lines.map{ $0.toCharArray() }.map{ array in array.map{ Int(String($0))! } }
    }
    
    struct PathPoint : Equatable, Hashable {
        let p: Point
        let d: Direction
        let l: Int
        
        init(_ p: Point, _ d: Direction, _ length: Int) {
            self.p = p
            self.d = d
            self.l = length
        }
        
        func neighbours() -> [PathPoint] {
            var result: [PathPoint] = []
            
            switch d {
            case .North:
                if l < 3 {
                    result.append(PathPoint(Point(p.x, p.y-1), Direction.North, l+1))
                }
                result.append(PathPoint(Point(p.x-1, p.y), Direction.West, 1))
                result.append(PathPoint(Point(p.x+1, p.y), Direction.East, 1))
            case .South:
                if l < 3 {
                    result.append(PathPoint(Point(p.x, p.y+1), Direction.South, l+1))
                }
                result.append(PathPoint(Point(p.x-1, p.y), Direction.West, 1))
                result.append(PathPoint(Point(p.x+1, p.y), Direction.East, 1))
            case .West:
                if l < 3 {
                    result.append(PathPoint(Point(p.x-1, p.y), Direction.West, l+1))
                }
                result.append(PathPoint(Point(p.x, p.y-1), Direction.North, 1))
                result.append(PathPoint(Point(p.x, p.y+1), Direction.South, 1))
            case .East:
                if l < 3 {
                    result.append(PathPoint(Point(p.x+1, p.y), Direction.East, l+1))
                }
                result.append(PathPoint(Point(p.x, p.y-1), Direction.North, 1))
                result.append(PathPoint(Point(p.x, p.y+1), Direction.South, 1))
            }
            
            return result
        }
    }
    
    enum Direction : Equatable, Hashable {
        case North
        case South
        case West
        case East
    }
}
