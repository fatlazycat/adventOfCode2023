import XCTest
import Parsing
import Foundation

class Day21Test : XCTestCase {
    
    func testPart1Dummy(){
        let rawData = day21DummyData
        XCTAssertEqual(16, part1(data: rawData, steps: 6))
    }
    
    func testPart1(){
        let rawData = day21Data
        XCTAssertEqual(3651, part1(data: rawData, steps: 64))
    }
    
    func testPart2(){
        let rawData = day21Data
        XCTAssertEqual(607334325965751, part2(data: rawData, partTwoSteps: 26501365))
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
    
    func infiniteGrid(data: [String], steps: Int) -> Int {
        let dim = data.count
        let (_, start, map) = createAllEdges(data: data)
        var mm = [Int : [Point]]()
        var s = [start]
        var seen = Set([start])
        mm[0] = s
        
        for i in 1...steps {
            s = Set(s.flatMap{ $0.neightboursInVerticalAndHorizontal() }
                .filter({!seen.contains($0)}))
            .filter{ map[Point(wrapValue($0.x, dim), wrapValue($0.y, dim))] != "#" }
            mm[i] = s
            seen.formUnion(s)
        }
        
        if steps.isOdd() {
            return stride(from: 1, through: steps, by: 2).map{ mm[$0]!.count }.reduce(0, +) 
        } else {
            return stride(from: 0, through: steps, by: 2).map{ mm[$0]!.count }.reduce(0, +)
        }
    }
    
    func wrapValue(_ n: Int, _ dim: Int) -> Int {
        if n < 0 {
            dim + n % dim
        } else {
            n % dim
        }
    }
    
    func part2(data: [String], partTwoSteps: Int) -> Int {
        let w = data[0].count
        let remainder = partTwoSteps % w
        let divisor = partTwoSteps / w
        let zero = infiniteGrid(data: data, steps: remainder)
        let one = infiniteGrid(data: data, steps: w + remainder)
        let two = infiniteGrid(data: data, steps: 2*w + remainder)
        //      -- we have a + b + c = one
        //      -- 4a + 2b + c = two
        //      -- So 2a = two + c - 2one = two - 3*zero - 2*one
        //      -- and b = one - zero - a
        let c = zero
        let a = (two + c - 2 * one) / 2
        let b = one - c - a
        
        return a * (divisor * divisor) + b * divisor + zero
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
