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
        
        XCTAssertEqual(145, getFocalPower(data: data))
    }
    
    func testPart2(){
        let rawData = try! Day15Test.parser.parse(day15Data)
        let data = rawData.map{ try! Day15Test.stepParser.parse($0)}
        
        XCTAssertEqual(259333, getFocalPower(data: data))
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
        let lenses = processInstructions(data: data)
        
        return lenses.map{ calcBox(box: $0) }.reduce(0, +)
    }
    
    func calcBox(box: (Int, [Lens])) -> Int {
        box.1.enumerated().map{ (index, item) in
            (index + 1) * item.strength * (box.0 + 1)
        }.reduce(0, +)
    }
        
    func processInstructions(data: [Step]) -> [Int : [Lens]] {
        let finalBoxes = foldl(sequence: data, base: [Int : [Lens]]()) {(acc, step) in
            let boxNumber = getHashOfStep(s: step)
            let box: [Lens] = acc[boxNumber, default: []]
            
            switch step {
            case .equals(let s, let n):
                if let existingLensIndex = box.firstIndex(where: { $0.name == s }) {
                    let updatedBox = box.replaceAtIndex(existingLensIndex, Lens(name: s, strength: n))
                    return acc.merging([boxNumber : updatedBox], uniquingKeysWith: { (_, new) in new })
                } else {
                    return acc.merging([boxNumber : box.appendElement(Lens(name: s, strength: n))], uniquingKeysWith: { (_, new) in new })
                }
            case .minus(let s):
                if let existingLensIndex = box.firstIndex(where: { $0.name == s }) {
                    let updatedBox = box.removeElement(at: existingLensIndex)
                    
                    if updatedBox.isEmpty {
                        return acc.removeValueFor(forKey: boxNumber)
                    } else {
                        let updatedBox = box.removeElement(at: existingLensIndex)
                        return acc.merging([boxNumber : updatedBox], uniquingKeysWith: { (_, new) in new })
                    }
                }
            }
            
            return acc
        }
        
        return finalBoxes
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
    
    enum Step : Equatable, Hashable {
        case equals(s: Substring, n: Int)
        case minus(s: Substring)
    }
    
    struct Lens : Equatable, Hashable {
        let name: Substring
        let strength: Int
    }
}
