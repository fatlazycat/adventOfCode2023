import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day10Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parser(lines: day10DummyData)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        
        assertThat(steps/2 == 8)
    }
    
    func testPart1(){
        let data = parser(lines: day10Data)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        
        assertThat(steps/2 == 8) // 6690
    }
    
    func traverse(start: Point, data: [Point : Character]) -> Int {
        
        var steps = 1
        var location = start
        var firstMove = findFirstMove(start: start, data: data)
        
        location = Point(firstMove.0.x + firstMove.1.0, firstMove.0.y + firstMove.1.1)
        var nextMove = firstMove.1
        
        repeat {
            nextMove = move(newPoint: location, data: data, direction: nextMove.2)!
            location = Point(location.x + nextMove.0, location.y + nextMove.1)
            steps += 1
            
        } while nextMove.2 != Direction.Finished
        
        return steps
    }
    
    func findFirstMove(start: Point, data: [Point : Character]) -> (Point, (Int, Int, Direction)) {
        if let moveNorth = move(newPoint: Point(start.x, start.y-1), data: data, direction: Direction.North) {
            return (Point(start.x, start.y-1), moveNorth)
        } else if let moveSouth = move(newPoint: Point(start.x, start.y+1), data: data, direction: Direction.South) {
            return (Point(start.x, start.y+1), moveSouth)
        } else if let moveWest = move(newPoint: Point(start.x-1, start.y), data: data, direction: Direction.West) {
            return (Point(start.x-1, start.y), moveWest)
        } else {
            let moveEast = move(newPoint: Point(start.x-1, start.y), data: data, direction: Direction.East)!
            return (Point(start.x+1, start.y), moveEast)
        }
    }
    
    func move(newPoint: Point, data: [Point : Character], direction: Direction) -> (Int, Int, Direction)? {
        if let route = data[newPoint] {
            if let nextMove = moves[NextLocation(d: direction, s: route)] {
                return nextMove
            }
        }
        
        return nil
    }
    
    func parser(lines: [String]) -> [Point: Character] {
        let data = lines.enumerated().flatMap { (y, row) in
            row.enumerated().flatMap{ (x, item) in
                [Point(x, y) : item]
            }
        }
        
        return Dictionary(uniqueKeysWithValues: data)
    }
    
    let moves = [
        NextLocation(d: Direction.North, s: "|") : (0, -1, Direction.North),
        NextLocation(d: Direction.North, s: "7") : (-1, 0, Direction.West),
        NextLocation(d: Direction.North, s: "F") : (1, 0, Direction.East),
        NextLocation(d: Direction.North, s: "S") : (0, 0, Direction.Finished),
        NextLocation(d: Direction.South, s: "|") : (0, 1, Direction.South),
        NextLocation(d: Direction.South, s: "L") : (1, 0, Direction.East),
        NextLocation(d: Direction.South, s: "J") : (-1, 0, Direction.West),
        NextLocation(d: Direction.South, s: "S") : (0, 0, Direction.Finished),
        NextLocation(d: Direction.West, s: "-") : (-1, 0, Direction.West),
        NextLocation(d: Direction.West, s: "L") : (0, -1, Direction.North),
        NextLocation(d: Direction.West, s: "F") : (0, 1, Direction.South),
        NextLocation(d: Direction.West, s: "S") : (0, 0, Direction.Finished),
        NextLocation(d: Direction.East, s: "-") : (1, 0, Direction.East),
        NextLocation(d: Direction.East, s: "7") : (0, 1, Direction.South),
        NextLocation(d: Direction.East, s: "J") : (0, -1, Direction.North),
        NextLocation(d: Direction.East, s: "S") : (0, 0, Direction.Finished),
    ]
    
    struct NextLocation : Equatable, Hashable {
        let d: Direction
        let s: Character
    }
    
    enum Direction {
        case North
        case South
        case West
        case East
        case Finished
    }
}

//| is a vertical pipe connecting north and south.
//- is a horizontal pipe connecting east and west.
//L is a 90-degree bend connecting north and east.
//J is a 90-degree bend connecting north and west.
//7 is a 90-degree bend connecting south and west.
//F is a 90-degree bend connecting south and east.
