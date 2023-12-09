import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day9Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = try! parser.parse(day9DummyData)
        let lastVals = data.map{ part1(data: $0) }
        assertThat(lastVals.reduce(0, +) == 114)
    }
    
    func testPart1(){
        let data = try! parser.parse(day9Data)
        let lastVals = data.map{ part1(data: $0) }
        assertThat(lastVals.reduce(0, +) == 1708206096)
    }
    
    func part1(data: [Int]) -> Int {
        let paired = data.windowed(size: 2)
        let diff = paired.map{ $0[1] - $0[0] }
        
        if diff.filter({$0 != 0}).count == 0 {
            return data.last! + diff.last!
        } else {
            return data.last! + part1(data: diff)
        }
    }
    
    let parser = Parse(input: Substring.self) {
        Many {
            Many {
                Int.parser()
            } separator: {
                " "
            }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
}
