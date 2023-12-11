import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day10Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parser(lines: day10DummyData)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = walk(start: start, p: start, data: data, direction: nil, testStart: false).max()!
        
        assertThat(steps/2 == 8)
    }
    
    func testPart1(){
        let data = parser(lines: day10Data)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = walk(start: start, p: start, data: data, direction: nil, testStart: false).max()!
        
        assertThat(steps/2 == 8)
    }
    
    func walk(start: Point, p: Point, data: [Point : Character], direction: Direction?, testStart: Bool = true, steps: Int = 0, visited: [Point] = []) -> [Int] {
        
        if testStart && p == start {
            return [steps]
        }
        
        var north: Point? = nil
        var south: Point? = nil
        var west: Point? = nil
        var east: Point? = nil
        
        if let d = direction {
            if d != Direction.SOUTH {
                north = goNorth(p: p, data: data, visited: visited)
            }
            
            if d != Direction.NORTH {
                south = goSouth(p: p, data: data, visited: visited)
            }
            
            if d != Direction.WEST {
                east = goEast(p: p, data: data, visited: visited)
            }
            
            if d != Direction.EAST {
                west = goWest(p: p, data: data, visited: visited)
            }
        } else {
            north = goNorth(p: p, data: data, visited: visited)
            south = goSouth(p: p, data: data, visited: visited)
            east = goEast(p: p, data: data, visited: visited)
            west = goWest(p: p, data: data, visited: visited)
        }
        
        let traverseNorth = north != nil ? walk(start: start, p: north!, data: data, direction: Direction.NORTH, steps: steps + 1, visited: visited + [north!]).compactMap{ $0 } : []
        let traverseSouth = south != nil ? walk(start: start, p: south!, data: data, direction: Direction.SOUTH, steps: steps + 1, visited: visited + [south!]).compactMap{ $0 } : []
        let traverseWest = west != nil ? walk(start: start, p: west!, data: data, direction: Direction.WEST, steps: steps + 1, visited: visited + [west!]).compactMap{ $0 } : []
        let traverseEast = east != nil ? walk(start: start, p: east!, data: data, direction: Direction.EAST, steps: steps + 1, visited: visited + [east!]).compactMap{ $0 } : []

        let traversals = traverseNorth + traverseSouth + traverseWest + traverseEast
        
        return traversals
    }
    
    func goNorth(p: Point, data: [Point : Character], visited: [Point]) -> Point? {
        let newPoint = Point(p.x, p.y-1)
        
        if let potentialNewPoint = data[newPoint] {
            if "7|FS".contains(potentialNewPoint) && !visited.contains(newPoint) {
                return newPoint
            }
        }
        
        return nil
    }
    
    func goSouth(p: Point, data: [Point : Character], visited: [Point]) -> Point? {
        let newPoint = Point(p.x, p.y+1)
        
        if let potentialNewPoint = data[newPoint] {
            if "L|JS".contains(potentialNewPoint) && !visited.contains(newPoint) {
                return newPoint
            }
        }
        
        return nil
    }
    
    func goWest(p: Point, data: [Point : Character], visited: [Point]) -> Point? {
        let newPoint = Point(p.x-1, p.y)
        
        if let potentialNewPoint = data[newPoint] {
            if "L-FS".contains(potentialNewPoint) && !visited.contains(newPoint) {
                return newPoint
            }
        }
        
        return nil
    }
    
    func goEast(p: Point, data: [Point : Character], visited: [Point]) -> Point? {
        let newPoint = Point(p.x+1, p.y)
        
        if let potentialNewPoint = data[newPoint] {
            if "7-JS".contains(potentialNewPoint) && !visited.contains(newPoint) {
                return newPoint
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
    
    enum Direction {
        case NORTH
        case SOUTH
        case EAST
        case WEST
    }

}



//| is a vertical pipe connecting north and south.
//- is a horizontal pipe connecting east and west.
//L is a 90-degree bend connecting north and east.
//J is a 90-degree bend connecting north and west.
//7 is a 90-degree bend connecting south and west.
//F is a 90-degree bend connecting south and east.
