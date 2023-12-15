import XCTest
import Parsing
import Foundation

class Day15Test : XCTestCase {
    
    func testPart1Dummy(){
        let rawData = try! Day15Test.parser.parse(day15DummyData)
//        let data = rawData.map{ try! Day15Test.stepParser.parse($0)}
        
        XCTAssertEqual(1320, rawData.map{ getNumber($0) }.reduce(0, +))
    }
    
    func testPart1(){
        let rawData = try! Day15Test.parser.parse(day15Data)
        
        XCTAssertEqual(509167, rawData.map{ getNumber($0) }.reduce(0, +))
    }
    
    func testHash() {
        XCTAssertEqual(52, getNumber("HASH"))
    }
    
    func getNumber(_ s: Substring) -> Int {
//        Determine the ASCII code for the current character of the string.
//        Increase the current value by the ASCII code you just determined.
//        Set the current value to itself multiplied by 17.
//        Set the current value to the remainder of dividing itself by 256.
        
        foldl(sequence: s.toCharArray(), base: 0) { (acc, item) in
            let ascii = Int(item.asciiValue!)
            return (acc + ascii) * 17 % 256
        }
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
            Prefix{ $0 != "," }
        } separator: {
            ","
        }
    }
    
    enum Step {
        case equals(s: Substring, n: Int)
        case minus(s: Substring)
    }
}
