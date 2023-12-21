import XCTest
import Parsing
import Foundation

class Day21Test : XCTestCase {
    
    func testPart1DummyAgain(){
        let rawData = day21DummyData
        XCTAssertEqual(16, part1(data: rawData, steps: 6))
    }
    
    func testPart1(){
        let rawData = day21Data
        XCTAssertEqual(3651, part1(data: rawData, steps: 64))
    }
    
    func part1(data: [String], steps: Int) -> Int {
        let (_, start, map) = createAllEdges(data: data)
        var mm = [Int : [Point]]()

        var s = [start]
        var seen = Set([start])
        mm[0] = s
        
        for i in 1...steps {
            s = Set(s.flatMap{ $0.neightboursInVerticalAndHorizontal() }.filter({!seen.contains($0)})).filter{ map[$0] != "#" }
            mm[i] = s
            seen.formUnion(s)
        }
        
        return stride(from: 0, through: steps, by: 2).map{ mm[$0]!.count }.reduce(0, +)
    }
    
    func printPoints(data: [String], toHighlight: Set<Point>) {
        let width = data[0].count
        let height = data.count
        let map = Dictionary(uniqueKeysWithValues:
            (0..<height).flatMap{ y in
                (0..<width).map{ x in
                    (Point(x, y), data[y][x])
                }
            }
        )
        
        (0..<height).forEach({ y in
            let chars = (0..<width).map{ x in
                let p = Point(x, y)
                
                return if toHighlight.contains(p) {
                    "O"
                } else {
                    String(map[p]!)
                }
            }.joined()
            
            print(chars)
        })
    }
    
    func createAllEdges(data: [String]) -> ([Edge], Point, [Point : Character] ) {
        let width = data[0].count
        let height = data.count
        
        let map = Dictionary(uniqueKeysWithValues: 
            (0..<height).flatMap{ y in
                (0..<width).map{ x in
                    (Point(x, y), data[y][x])
                }
            }
        )
        
        let allEdges = map.keys.flatMap{ p in p.neightboursInVerticalAndHorizontal().map{ Edge(from: p, to: $0) } }
            .filter({map[$0.to] != nil}).filter({map[$0.to]! != "#"})
            
        return (allEdges, map.lazy.elements.first{ $0.value == "S" }!.key, map)
    }
    
    struct Edge {
        let from: Point
        let to: Point
    }
}
