import XCTest
import Parsing
import Foundation

class Day13Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parseData(lines: day13DummyData)
        let verticals = data.map{ findReflection(lines: rotateArray90Degrees($0)) }.compactMap{ $0 }
        let horizontals = data.map{ findReflection(lines: $0) }.compactMap{ $0 }
        
        let verticalSum = verticals.reduce(0, { (acc, item) in acc + item.0 })
        let horizontalSum = horizontals.reduce(0, { (acc, item) in acc + (item.0*100) })
        
        XCTAssertEqual(verticalSum + horizontalSum, 405)
    }
    
    func testWindow() {
//        let data = parseData(lines: day13DummyData)
//        let horizontal = findReflection(lines: data[1])
//        print(horizontal)
        
        print("hello" == "hellothere")
    }

    func findReflection(lines: [String]) -> (Int, Int)? {
        let rowsPaired = lines.windowed(size: 4, step: 1)
        let match = rowsPaired.enumerated().first{ (index, pair) in
            pair[0] == pair[3] && pair[1] == pair[2]
        }

        if let result = match {
            return (result.offset+2, result.offset+3)
        } else {
            return nil
        }
        
    }
    
    func rotateArray90Degrees(_ input: [String]) -> [String] {
        let rowCount = input.count
        let colCount = input[0].count
        
        var rotatedArray = [String](repeating: "", count: colCount)
        
        for i in 0..<colCount {
            for j in 0..<rowCount {
                let charIndex = input[j].index(input[j].startIndex, offsetBy: i)
                rotatedArray[i].append(input[j][charIndex])
            }
        }
        
        return rotatedArray
    }
    
    func parseData(lines: [String]) -> [[String]] {
        lines.reduce([[]]) { (result: [[String]], line: String) -> [[String]] in
            guard let last = result.last else { return [[line]] }
            return line.isEmpty ? result + [[]] : result.dropLast() + [last + [line]]
        }.filter { !$0.isEmpty }
    }
    
//    let parser = Parse(input: Substring.self) {
//        Many {
//            Many {
//                Prefix(while: {$0 != "\n"})
//            } separator: {
//                Whitespace(1, .vertical)
//            }
//        } separator: {
//            Whitespace(2, .vertical)
//        }
//    }
    
}
