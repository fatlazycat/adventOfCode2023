import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day10Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parser(lines: day10DummyData)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        
        assertThat(steps.count/2 == 8)
    }
    
    func testPart1(){
        let data = parser(lines: day10Data)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        
        assertThat(steps.count/2 == 6690)
    }
    
    func testPart2Dummy() {
        let lines = day10Ex1
        let data = parser(lines: lines)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        let possibleMatches = data.filter{ !steps.contains($0.key) }
        let contained = possibleMatches.filter{ wallCounts(p: $0.key, data: data, loop: Set(steps), start: start).isOdd() }
        
        assertThat(contained.count == 4)
    }
    
    func testPart2DummyAgain() {
        let lines = day10Ex2
        let data = parser(lines: lines)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        let possibleMatches = data.filter{ !steps.contains($0.key) }
        let contained = possibleMatches.filter{ wallCounts(p: $0.key, data: data, loop: Set(steps), start: start).isOdd() }
        
        assertThat(contained.count == 10)
    }
    
    func testPart2() {
        let lines = day10Data
        let data = parser(lines: lines)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        let possibleMatches = data.filter{ !steps.contains($0.key) }
        let contained = possibleMatches.filter{ wallCounts(p: $0.key, data: data, loop: Set(steps), start: start).isOdd() }
        
        assertThat(contained.count == 525)
    }
    
    func testWallCounts() {
        let lines = day10Ex1
        let data = parser(lines: lines)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(start: start, data: data)
        let result = wallCounts(p: Point(9, 2), data: data, loop: Set(steps), start: start)
        assertThat(result == 2)
    }
    
    func wallCounts(p: Point, data: [Point : Character], loop: Set<Point>, start: Point) -> Int {
        let crossings: Set<Character> = ["|", "J", "L"]
        let pipeAtStart = pipeAtStart(p: start, data: data)
        var focus = Point(p.x-1, p.y)
        var intersections = 0
        
        while focus.x >= 0 {
            let raw = data[focus]
            let val = raw == "S" ? pipeAtStart : raw!
            
            if loop.contains(focus) && crossings.contains(val) {
                intersections += 1
            }
            
            focus = Point(focus.x-1, focus.y)
        }
        
        return intersections
    }
    
    func testStartPipe() {
        let lines = day10Ex2
        let data = parser(lines: lines)
        
        assertThat(pipeAtStart(p: Point(4,0), data: data) == "7")
    }
    
    func pipeAtStart(p: Point, data: [Point : Character]) -> Character {
        let directions = findPipeAtPoint(start: p, data: data)
        let firstDirection = directions[0]
        let secondDirection = directions[1]
        
        switch(firstDirection, secondDirection) {
            // | is a vertical pipe connecting north and south.
            case (Direction.North, Direction.South): return "|"
            // - is a horizontal pipe connecting east and west.
            case (Direction.West, Direction.East): return "-"
            // L is a 90-degree bend connecting north and east.
            case (Direction.North, Direction.East): return "L"
            // J is a 90-degree bend connecting north and west.
            case (Direction.North, Direction.West): return "J"
            // 7 is a 90-degree bend connecting south and west.
            case (Direction.South, Direction.West): return "7"
            // F is a 90-degree bend connecting south and east.
            case (Direction.South, Direction.East): return "F"
            default: assert(false)
        }
    }
    
    func traverse(start: Point, data: [Point : Character]) -> Set<Point> {
        
        var steps: [Point] = []
        var location = start
        let firstMove = findFirstMoves(start: start, data: data).first!
        steps.append(Point(firstMove.0.x, firstMove.0.y))
        
        location = Point(firstMove.0.x + firstMove.1.0, firstMove.0.y + firstMove.1.1)
        steps.append(location)

        var nextMove = firstMove.1
        
        repeat {
            nextMove = move(newPoint: location, data: data, direction: nextMove.2)!
            location = Point(location.x + nextMove.0, location.y + nextMove.1)
            steps.append(location)
            
        } while nextMove.2 != Direction.Finished
        
        return Set(steps)
    }
    
    func findFirstMoves(start: Point, data: [Point : Character]) -> [(Point, (Int, Int, Direction))] {
        var result : [(Point, (Int, Int, Direction))] = []
        
        if let moveNorth = move(newPoint: Point(start.x, start.y-1), data: data, direction: Direction.North) {
            result.append((Point(start.x, start.y-1), moveNorth))
        }
        
        if let moveSouth = move(newPoint: Point(start.x, start.y+1), data: data, direction: Direction.South) {
            result.append((Point(start.x, start.y+1), moveSouth))
        }
        
        if let moveWest = move(newPoint: Point(start.x-1, start.y), data: data, direction: Direction.West) {
            result.append((Point(start.x-1, start.y), moveWest))
        }
        
        if let moveEast = move(newPoint: Point(start.x+1, start.y), data: data, direction: Direction.East) {
            result.append((Point(start.x+1, start.y), moveEast))
        }
        
        return result
    }
    
    func findPipeAtPoint(start: Point, data: [Point : Character]) -> [Direction] {
        var result : [Direction] = []
        
        if move(newPoint: Point(start.x, start.y-1), data: data, direction: Direction.North) != nil {
            result.append(Direction.North)
        }
        
        if move(newPoint: Point(start.x, start.y+1), data: data, direction: Direction.South) != nil {
            result.append(Direction.South)
        }
        
        if move(newPoint: Point(start.x-1, start.y), data: data, direction: Direction.West) != nil {
            result.append(Direction.West)
        }
        
        if move(newPoint: Point(start.x+1, start.y), data: data, direction: Direction.East) != nil {
            result.append(Direction.East)
        }
        
        return result
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
