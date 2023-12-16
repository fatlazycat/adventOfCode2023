import XCTest
import Parsing
import Foundation

class Day16Test : XCTestCase {

    func testPart1Dummy(){
        let data = Day16Test.loadData(filename: "Day16DummyData").lines.map{ $0.toCharArray() }.filter({ !$0.isEmpty })
        XCTAssertEqual(46, part1(data: data))
    }
    
    func testPart1(){
        let data = Day16Test.loadData(filename: "Day16Data").lines.map{ $0.toCharArray() }.filter({ !$0.isEmpty })
        XCTAssertEqual(6816, part1(data: data))
    }
    
    func part1(data: [[Character]]) -> Int {
        let paths = findEnergisedPoints(data: data)
        let allPoints = paths.compactMap{ $0 }.map{ $0.point }
        let setOfPoints = Set(allPoints)
        
        return setOfPoints.count
    }

    func printPoints(data: [Point], width: Int, height: Int, orginal: [[Character]], printOrig: Bool = false) {
        let setOfPoints = Set(data)
        
        (0..<height).forEach({ y in
            let chars = (0..<width).map{ x in
                setOfPoints.contains(Point(x, y)) ? "#" : (printOrig ? String(orginal[y][x]) : ".")
            }.joined()
            
            print(chars)
        })
    }
    
    func findEnergisedPoints(data: [[Character]]) -> Set<PathPoint> {
        let height = data.count
        let width = data[0].count
        var pathsToProcess = [PathPoint(Point(0, 0), Direction.East)]
        var energisedPoints: Set<PathPoint> = [PathPoint(Point(0, 0), Direction.East)]
        
        while !pathsToProcess.isEmpty {
            let current = pathsToProcess.removeFirst()
            let newPoints = getNewPoints(cell: data[current.point.y][current.point.x], current: current.point, direction: current.direction)
            
            newPoints.forEach({ p in
                if !energisedPoints.contains(p) && p.point.x >= 0 && p.point.x < width && p.point.y >= 0 && p.point.y < height {
                    energisedPoints.insert(p)
                    pathsToProcess.append(p)
                }
            })
        }
        
        return energisedPoints
    }
    
    func getNewPoints(cell: Character, current: Point, direction: Direction) -> [PathPoint] {
        switch cell {
        case ".":
            [PathPoint(updateCoords(current: current, direction: direction), direction)]
        case "\\":
            switch direction {
            case .North:
                [PathPoint(updateCoords(current: current, direction: Direction.West), Direction.West)]
            case .South:
                [PathPoint(updateCoords(current: current, direction: Direction.East), Direction.East)]
            case .West:
                [PathPoint(updateCoords(current: current, direction: Direction.North), Direction.North)]
            case .East:
                [PathPoint(updateCoords(current: current, direction: Direction.South), Direction.South)]
            }
        case "/":
            switch direction {
            case .North:
                [PathPoint(updateCoords(current: current, direction: Direction.East), Direction.East)]
            case .South:
                [PathPoint(updateCoords(current: current, direction: Direction.West), Direction.West)]
            case .West:
                [PathPoint(updateCoords(current: current, direction: Direction.South), Direction.South)]
            case .East:
                [PathPoint(updateCoords(current: current, direction: Direction.North), Direction.North)]
            }
        case "-":
            switch direction {
            case .North:
                [PathPoint(updateCoords(current: current, direction: Direction.West), Direction.West),
                 PathPoint(updateCoords(current: current, direction: Direction.East), Direction.East)]
            case .South:
                [PathPoint(updateCoords(current: current, direction: Direction.West), Direction.West),
                 PathPoint(updateCoords(current: current, direction: Direction.East), Direction.East)]
            case .West:
                [PathPoint(updateCoords(current: current, direction: Direction.West), Direction.West)]
            case .East:
                [PathPoint(updateCoords(current: current, direction: Direction.East), Direction.East)]
            }
        case "|":
            switch direction {
            case .North:
                [PathPoint(updateCoords(current: current, direction: Direction.North), Direction.North)]
            case .South:
                [PathPoint(updateCoords(current: current, direction: Direction.South), Direction.South)]
            case .West:
                [PathPoint(updateCoords(current: current, direction: Direction.North), Direction.North),
                 PathPoint(updateCoords(current: current, direction: Direction.South), Direction.South)]
            case .East:
                [PathPoint(updateCoords(current: current, direction: Direction.North), Direction.North),
                 PathPoint(updateCoords(current: current, direction: Direction.South), Direction.South)]
            }
        default:
            fatalError("Shouldn't be possible")
        }
    }
    
    func updateCoords(current: Point, direction: Direction) -> Point {
        switch direction {
        case .North:
            Point(current.x, current.y-1)
        case .South:
            Point(current.x, current.y+1)
        case .West:
            Point(current.x-1, current.y)
        case .East:
            Point(current.x+1, current.y)
        }
    }
    
    enum Direction {
        case North
        case South
        case West
        case East
    }
    
    struct PathPoint : Equatable, Hashable {
        let point: Point
        let direction: Direction
        
        init(_ point: Point, _ direction: Direction) {
            self.point = point
            self.direction = direction
        }
    }
    
    static func loadData(filename: String) -> String {
        
        let bundle = Bundle.module
        
        let dataURL = bundle.url(
        forResource: filename,
        withExtension: "txt")

      guard let dataURL,
        let data = try? String(contentsOf: dataURL, encoding: .utf8)
      else {
        fatalError("Couldn't find file '\(filename).txt' in the 'dataFiles' directory.")
      }

      // On Windows, line separators may be CRLF. Converting to LF so that \n
      // works for string parsing.
      return data.replacingOccurrences(of: "\r", with: "")
    }
}
