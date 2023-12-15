import XCTest
import Parsing
import Foundation

class Day15Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = try! Day15Test.parser.parse(day15DummyData)
        print(data)
//        let titltedGrid = tiltNorth(data: data)
//        
//        XCTAssertEqual(136, sumLoad(grid: titltedGrid))
    }
    
    static let equalsParser = Parse(input: Substring.self) {
        Prefix{ $0 != "=" }
        "="
        Int.parser()
    }.map(Step.equals)

    static let minusParser = Parse(input: Substring.self)  {
        Prefix{ $0 != "-" }
        "-"
    }.map(Step.minus)

    static let stepParser = OneOf {
        equalsParser
        minusParser
    }
    
    static let parser = Parse(input: Substring.self) {
        Many{
            stepParser
        } separator: {
            ","
        }
    }
    
    enum Step {
        case equals(s: Substring, n: Int)
        case minus(s: Substring)
    }
}
