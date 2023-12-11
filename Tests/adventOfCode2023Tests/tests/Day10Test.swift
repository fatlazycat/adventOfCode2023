import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day10Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parser(lines: day10DummyData)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(p: start, data: data, visited: [start]).max()!
        
        assertThat(steps/2 == 8)
    }
    
    func testPart1(){
        let data = parser(lines: day10Data)
        let start = data.filter{ $0.value == "S" }.first!.key
        let steps = traverse(p: start, data: data, visited: [start]).max()!
        
        assertThat(steps/2 == 8)
    }
    
    func traverse(p: Point?, data: [Point : Character], visited: [Point]) -> [Int] {
        
        if let p = p {
            if visited.count > 2 && p == visited.first {
                // we are back at the start
                return [visited.count-1]
            }
            
            let north = move(newPoint: Point(p.x, p.y-1), data: data, visited: visited, validOptions: "7|F")
            let south = move(newPoint: Point(p.x, p.y+1), data: data, visited: visited, validOptions: "L|J")
            let west = move(newPoint: Point(p.x-1, p.y), data: data, visited: visited, validOptions: "L-F")
            let east = move(newPoint: Point(p.x+1, p.y), data: data, visited: visited, validOptions: "7-J")
            
            // Attempt to traverse the map
            return (
                traverse(p: north,
                         data: data,
                         visited: visited.appendOptionalAndCompact(north)) +
                traverse(p: south,
                         data: data,
                         visited: visited.appendOptionalAndCompact(south)) +
                traverse(p: west,
                         data: data,
                         visited: visited.appendOptionalAndCompact(west)) +
                traverse(p: east,
                         data: data,
                         visited: visited.appendOptionalAndCompact(east))
            ).compactMap{ $0 }
        }
        
        return []
    }
    
    func move(newPoint: Point, data: [Point : Character], visited: [Point], validOptions: String) -> Point? {
        if let potentialNewPoint = data[newPoint] {
            if "S".contains(potentialNewPoint) && visited.count > 2 {
                return newPoint
            }
            else if validOptions.contains(potentialNewPoint) && !visited.contains(newPoint) {
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
}

//| is a vertical pipe connecting north and south.
//- is a horizontal pipe connecting east and west.
//L is a 90-degree bend connecting north and east.
//J is a 90-degree bend connecting north and west.
//7 is a 90-degree bend connecting south and west.
//F is a 90-degree bend connecting south and east.
