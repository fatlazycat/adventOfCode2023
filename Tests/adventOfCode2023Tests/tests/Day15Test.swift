import XCTest
import Parsing
import Foundation

class Day15Test : XCTestCase {
    
    func testPart1Dummy(){
        let rawData = try! Day15Test.parser.parse(day15DummyData)
        
        XCTAssertEqual(1320, rawData.map{ getNumber($0) }.reduce(0, +))
    }
    
    func testPart1(){
        let rawData = try! Day15Test.parser.parse(day15Data)
        
        XCTAssertEqual(509167, rawData.map{ getNumber($0) }.reduce(0, +))
    }
    
    func testPart2Dummy(){
        let rawData = try! Day15Test.parser.parse(day15DummyData)
        let data = rawData.map{ try! Day15Test.stepParser.parse($0)}
        let focalPower = getFocalPower(data: data)
        
//        XCTAssertEqual(1320, rawData.map{ getNumber($0) }.reduce(0, +))
    }
    
    func testProcessInstructions() {
        let rawData = try! Day15Test.parser.parse(day15DummyData)
        let data = rawData.map{ try! Day15Test.stepParser.parse($0)}
        let expected = [
            0 : [Lens(name: "rn", strength: 1), Lens(name: "cm", strength: 2)],
            3 : [Lens(name: "ot", strength: 7), Lens(name: "ab", strength: 5), Lens(name: "pc", strength: 6)]
            ]
        
        XCTAssertEqual(expected, processInstructions(data: data))
    }
    
    func testHash() {
        XCTAssertEqual(52, getNumber("HASH"))
        XCTAssertEqual(1, getNumber("qp"))
    }
    
    func getFocalPower(data: [Step]) -> Int {
        return 0
    }
        
    func processInstructions(data: [Step]) -> [Int : [Lens]] {
        var boxes = [Int : [Lens]]()
        
        data.forEach({ step in
            let boxNumber = getHashOfStep(s: step)
            var box: [Lens] = boxes[boxNumber, default: []]
            
            switch step {
            case .equals(let s, let n):
                if let existingLensIndex = box.firstIndex(where: { $0.name == s }) {
                    box[existingLensIndex] = Lens(name: s, strength: n)
                    boxes[boxNumber] = box
                } else {
                    box.append(Lens(name: s, strength: n))
                    boxes[boxNumber] = box
                }
            case .minus(let s):
                if let existingLensIndex = box.firstIndex(where: { $0.name == s }) {
                    box.remove(at: existingLensIndex)
                    
                    if box.isEmpty {
                        boxes[boxNumber] = nil
                    } else {
                        boxes[boxNumber] = box
                    }
                }
            }
        })
        
        return boxes
    }
    
    func getHashOfStep(s: Step) -> Int {
        switch s {
        case .equals(let s, _):
            getNumber(s)
        case .minus(let s):
            getNumber(s)
        }
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
    
    enum Step : Equatable {
        case equals(s: Substring, n: Int)
        case minus(s: Substring)
    }
    
    struct Lens : Equatable {
        let name: Substring
        let strength: Int
    }
}
