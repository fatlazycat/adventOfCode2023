import XCTest
import Parsing
import Foundation

class Day18Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = try! Day18Test.parser.parse(day18DummyData).map{ Input(direction: $0.0, num: $0.1, code: $0.2) }
        XCTAssertEqual(62, part1(data: data))
    }
    
    func testPart1(){
        let data = try! Day18Test.parser.parse(day18Data).map{ Input(direction: $0.0, num: $0.1, code: $0.2) }
        XCTAssertEqual(62, part1(data: data)) // 47920 too low
    }
    
    func part1(data: [Input]) -> Int {
        let walls = createPointsOfTrench(data: data)
        let minX = walls.map{ $0.point.x }.min()!
        let maxX = walls.map{ $0.point.x }.max()!
        let minY = walls.map{ $0.point.y }.min()!
        let maxY = walls.map{ $0.point.y }.max()!
        let start = Point(minX, minY)
        let wallPoints = walls.map{ $0.point }
        let setOfWallPoints = Set(wallPoints)
        let boundaries = Dictionary(uniqueKeysWithValues: walls.map{($0.point, $0.endPoint)})
        let width = maxX - minX
        let height = maxY - minY
        let allPoints = allPoints(start: start, width: width, height: height).filter({!wallPoints.contains($0)})
        let contained = allPoints.filter({
            wallCounts(p: $0, start: start, width: width, height: height, loop: setOfWallPoints, boundaries: boundaries ).isOdd()
        })
        
//        printWallPoints(data: walls, start: start, width: width, height: height)
        
        return contained.count + walls.count
    }
    
    func allPoints(start: Point, width: Int, height: Int) -> [Point] {
        var result = [Point]()
        
        (start.y..<height).forEach({ y in
            (start.x..<width).forEach({ x in
                result.append(Point(x, y))
            })
        })
        
        return result
    }
    
    func createPointsOfTrench(data: [Input]) -> [WallPoint] {
        var current = Point(0,0)
        var result = [WallPoint]()
        let vals: [[Input]] = data.windowed(size: 2, step: 1) + [[data.last!, data.first!]]
        
        vals.forEach({ val in
            let input = val[0]
            let next = val[1]

//            let crossings: Set<Character> = ["|", "J", "L"]
            
            switch input.direction {
            case .Up:
                result.append(contentsOf: (1...input.num).map{
                    WallPoint(point: Point(current.x, current.y - $0),
                              colour: input.colour,
                              endPoint: $0 != input.num) })
                current = Point(current.x, current.y - input.num)
            case .Down:
                result.append(contentsOf: (1...input.num).map{
                    WallPoint(point: Point(current.x, current.y + $0),
                              colour: input.colour,
                              endPoint: $0 != 0) })
                current = Point(current.x, current.y + input.num)
            case .Left:
                result.append(contentsOf: (1...input.num).map{
                    WallPoint(point: Point(current.x - $0, current.y),
                              colour: input.colour,
                              endPoint: $0 == input.num && next.direction == Direction.Up) })
                current = Point(current.x - input.num, current.y)
            case .Right:
                result.append(contentsOf: (1...input.num).map{
                    WallPoint(point: Point(current.x + $0, current.y),
                              colour: input.colour,
                              endPoint: $0 == input.num && next.direction == Direction.Up) })
                current = Point(current.x + input.num, current.y)
            }
        })
        
        return result
    }
    
    func wallCounts(p: Point, start: Point, width: Int, height: Int, loop: Set<Point>, boundaries: [Point : Bool]) -> Int {
        var focus = Point(p.x-1, p.y)
        var intersections = 0
        
        while focus.x >= start.x {
            if loop.contains(focus) && boundaries[focus]! {
                intersections += 1
            }
            
            focus = Point(focus.x-1, focus.y)
        }
        
        return intersections
    }

    struct WallPoint: Equatable, Hashable {
        let point: Point
        let colour: Substring
        let endPoint: Bool
    }
    
    struct Input: Equatable, Hashable {
        let direction: Direction
        let num: Int
        let colour: Substring
        
        init(direction: Substring, num: Int, code: Substring) {
            self.direction = Direction(rawValue: String(direction))!
            self.num = num
            self.colour = code
        }
    }
    
    enum Direction : String {
        case Up = "U"
        case Down = "D"
        case Left = "L"
        case Right = "R"
    }
    
    static let parser = Parse(input: Substring.self) {
        Many {
            Prefix{ $0 != " " }
            Whitespace()
            Int.parser()
            Skip{ " (#" }
            Prefix{ $0 != ")" }
            Skip{ ")" }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
    
    func printPoints(data: [Point], start: Point, width: Int, height: Int) {
        let mapOfPoints = Set(data)
        
        (start.y..<height).forEach({ y in
            let chars = (start.x..<width).map{ x in
                mapOfPoints.contains(Point(x, y)) ? "#" : "."
            }.joined()
            
            print(chars)
        })
    }
    
    func printWallPoints(data: [WallPoint], start: Point, width: Int, height: Int) {
        let mapOfPoints = Dictionary(uniqueKeysWithValues: data.map{ ($0.point, $0) })
        
        (start.y..<height).forEach({ y in
            let chars = (start.x..<width).map{ x in
                if let wallPoint = mapOfPoints[Point(x, y)] {
                    wallPoint.endPoint ? "O" : "#"
                } else {
                    "."
                }
            }.joined()
            
            print(chars)
        })
    }
}