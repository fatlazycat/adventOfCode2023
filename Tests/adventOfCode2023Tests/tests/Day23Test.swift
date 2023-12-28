import XCTest
import Parsing
import Foundation

class Day23Test : XCTestCase {
    
    func testPart1Dummy() {
        let scenery = parseData(lines: day23DummyData.lines)
        XCTAssertEqual(94, longestPath(scenery: scenery))
    }
    
    func testPart1() {
        let scenery = parseData(lines: day23Data.lines)
        XCTAssertEqual(2394, longestPath(scenery: scenery))
    }
    
    func testPart2Dummy() {
        let scenery = parseData(lines: day23DummyData.lines)
        XCTAssertEqual(154, longestPathIgnoreSlopes(scenery: scenery))
    }
    
    func testPart2() {
        let scenery = parseData(lines: day23Data.lines)
        XCTAssertEqual(154, longestPathIgnoreSlopes(scenery: scenery))
    }
    
    func longestPath(scenery: [[Day23Test.Ground]]) -> Int {
        let start = Point(scenery.first!.enumerated().first(where: { $0.1 == .Path })!.0, 0)
        let end = Point(scenery.last!.enumerated().first(where: { $0.1 == .Path })!.0, scenery.count-1)
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
        
//        printPoints(data: sceneryDict, path: longestPath, width: scenery[0].count, height: scenery.count)
        
        return longestPath.count-1
    }
    
    func longestPathIgnoreSlopes(scenery: [[Day23Test.Ground]]) -> Int {
        let start = Point(scenery.first!.enumerated().first(where: { $0.1 == .Path })!.0, 0)
        let end = Point(scenery.last!.enumerated().first(where: { $0.1 == .Path })!.0, scenery.count-1)
        let sceneryValues = scenery.enumerated().flatMap{ (y, row) in
            row.enumerated().map{ (x, item) in (Point(x,y), item) }
        }
        let sceneryDict = Dictionary(uniqueKeysWithValues: sceneryValues)
        let dg = DynamicGraph()
        let determineNextNodes: (Point) -> Set<Point> = { current in
            var nextNodes = Set<Point>()
            
            if let nextLocation = sceneryDict[Point(current.x, current.y - 1)] {
                if nextLocation != .Forest {
                    nextNodes.insert(Point(current.x, current.y - 1))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x, current.y + 1)] {
                if nextLocation != .Forest {
                    nextNodes.insert(Point(current.x, current.y + 1))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x - 1, current.y)] {
                if nextLocation != .Forest {
                    nextNodes.insert(Point(current.x - 1, current.y))
                }
            }
            
            if let nextLocation = sceneryDict[Point(current.x + 1, current.y)] {
                if nextLocation != .Forest {
                    nextNodes.insert(Point(current.x + 1, current.y))
                }
            }
            
            return nextNodes
        }
        
        let isEndpoint: (Point) -> Bool = { point in
            point == end
        }
        
        let longestPath = dg.findLongestPath(startingAt: start, determineNextNodes: determineNextNodes, isEndpoint: isEndpoint)
        
//        printPoints(data: sceneryDict, path: longestPath, width: scenery[0].count, height: scenery.count)
        
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

        func findLongestPath(startingAt startNode: Point, determineNextNodes: (Point) -> Set<Point>, isEndpoint: (Point) -> Bool) -> [Point] {
            var visited = Set<Point>()
            var currentPath = [Point]()

            func dfs(currentNode: Point) {
                visited.insert(currentNode)
                currentPath.append(currentNode)

                if isEndpoint(currentNode) && currentPath.count > longestPath.count {
                    longestPath = currentPath
                } else {
                    for nextNode in determineNextNodes(currentNode) where !visited.contains(nextNode) {
                        dfs(currentNode: nextNode)
                    }
                }

                // Backtrack
                currentPath.removeLast()
                visited.remove(currentNode)
            }

            dfs(currentNode: startNode)
            return longestPath
        }
    }
}
