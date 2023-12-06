import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day3Test : XCTestCase {
    
    func testPart1Dummy() {
        let (numbers, symbols) = processRows(lines: day3DummyData)
        let result = numbers.filter{ $0.isAdjacentToAny(points: symbols) }.reduce(0, { acc, n in acc + n.toInt() })
        assertThat(result == 4361)
    }
    
    func testPart1() {
        let (numbers, symbols) = processRows(lines: day3Data)
        let result = numbers.filter{ $0.isAdjacentToAny(points: symbols) }.reduce(0, { acc, n in acc + n.toInt() })
        assertThat(result == 559667)
    }
    
    func processRows(lines: [String]) -> (Set<NumberLocation>, Set<Point>) {
        var numbers: Set<NumberLocation> = []
        var symbols: Set<Point> = []
        var workingNumber = NumberLocation()
        
        lines.enumerated().forEach( { (y, row) in
            row.enumerated().forEach( { (x, c) in
                if c.isNumber {
                    workingNumber.add(c: c, location: Point(x, y))
                } else {
                    if !workingNumber.isEmpty() {
                        numbers.insert(workingNumber)
                        workingNumber = NumberLocation()
                    }
                    
                    if c != "." {
                        symbols.insert(Point(x, y))
                    }
                }
            })
        })
        
        return (numbers, symbols)
    }
}

class NumberLocation : Equatable {
    static func == (lhs: NumberLocation, rhs: NumberLocation) -> Bool {
        lhs.number == rhs.number && lhs.locations == rhs.locations
    }
    
    var number: [Character] = []
    var locations: Set<Point> = []
    
    func add(c: Character, location: Point) {
        number.append(c)
        _ = location.neighbours().map{ locations.insert($0) }
    }
    
    func isEmpty() -> Bool {
        number.isEmpty
    }
    
    func isAdjacentToAny(points: Set<Point>) -> Bool {
        !locations.intersection(points).isEmpty
    }
    
    func isAdjacentTo(point: Point) -> Bool {
        locations.contains(point)
    }
    
    func toInt() -> Int {
        Int(String(number))!
    }
}

extension NumberLocation: Hashable {

    public func hash(into hasher: inout Hasher) {
         hasher.combine(ObjectIdentifier(self))
    }
}

let day3DummyData = """
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
""".lines
