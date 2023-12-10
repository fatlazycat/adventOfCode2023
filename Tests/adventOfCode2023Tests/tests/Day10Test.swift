import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day10Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parser(lines: day10DummyData)
        let start = data.filter{ $0.value == "S" }.first!.key
        
        print(data)
        print(start)
    }
    
    func walk(p: Point, data: [Point : Character]) -> Int {
        
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

class DAG {
    var adjacencyList: [Point: [Point]] = [:]

    func addEdge(_ from: Point, _ to: Point) {
        if adjacencyList[from] == nil {
            adjacencyList[from] = []
        }
        adjacencyList[from]?.append(to)
    }

    func printGraph() {
        for (vertex, neighbors) in adjacencyList {
            let neighborString = neighbors.map{ String(describing: $0)}.joined(separator: ", ")
            print("\(vertex) -> [\(neighborString)]")
        }
    }
}

//| is a vertical pipe connecting north and south.
//- is a horizontal pipe connecting east and west.
//L is a 90-degree bend connecting north and east.
//J is a 90-degree bend connecting north and west.
//7 is a 90-degree bend connecting south and west.
//F is a 90-degree bend connecting south and east.
