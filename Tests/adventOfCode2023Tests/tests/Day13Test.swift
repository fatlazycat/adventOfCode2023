import XCTest
import Parsing
import Foundation

class Day13Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parseData(lines: day13DummyData)
        let results = data.map{ getMirrorLineCalc(data: $0) }
        
        XCTAssertEqual(results.reduce(0, +), 405)
    }
    
    func testPart1(){
        let data = parseData(lines: day13Data)
        let results = data.map{ getMirrorLineCalc(data: $0) }
        
        XCTAssertEqual(results.reduce(0, +), 27505)
    }
    
    func testWindow() {
        let data = parseData(lines: day13DummyData)
        
        let vertical1 = reduceFromTop(rotateArray90Degrees(data[1]))
        let vertical2 = reduceFromBottom(rotateArray90Degrees(data[1]))
        let horizontal1 = reduceFromTop(data[1])
        let horizontal2 = reduceFromBottom(data[1])
        print(vertical1)
        print("---")
        print(vertical2)
        print("---")
        print(horizontal1)
        print("---")
        print(horizontal2)
    }
    
    func testWindow2() {
        let data = parseData(lines: day13DummyData)
        
        let vertical1 = reduceFromTop(rotateArray90Degrees(data[0]))
        let vertical2 = reduceFromBottom(rotateArray90Degrees(data[0]))
        let horizontal1 = reduceFromTop(data[0])
        let horizontal2 = reduceFromBottom(data[0])
        print(vertical1)
        print("---")
        print(vertical2)
        print("---")
        print(horizontal1)
        print("---")
        print(horizontal2)
    }
    
    func getMirrorLineCalc(data: [[Character]]) -> Int {
        let vertical = [reduceFromTop(rotateArray90Degrees(data)) + reduceFromBottom(rotateArray90Degrees(data))].flatMap{ $0 }.map{ $0.first }
        let horizontal = [reduceFromTop(data) + reduceFromBottom(data)].flatMap{ $0 }.map{ $0.first * 100 }
        
        return (vertical + horizontal).reduce(0, +)
    }

    func reduceFromBottom(_ inputLines: [[Character]], index: Int = 1) -> [Match] {
        let height = inputLines.count

        if height < 2 {
            return []
        }
        
        var lines = inputLines
        
        // build comparisons
        if height.isOdd() {
            lines = inputLines.dropLast()
        }

        let pairs = pairUntilExhausted(lines)
        
        if pairs.filter({$0.0 == $0.1}).count == pairs.count {
            return [Match(index + pairs.count-1, index + pairs.count, pairs.count)]
        } else {
            // didn't match so shrink
            return reduceFromBottom(Array(lines.dropLast()), index: index)
        }
    }
    
    func reduceFromTop(_ inputLines: [[Character]], startIndex: Int = 1) -> [Match] {
        let height = inputLines.count

        if height < 2 {
            return []
        }
        
        var lines = inputLines
        var index = startIndex
        
        // build comparisons
        if height.isOdd() {
            lines = inputLines.dropFirstArray()
            index = index + 1
        }

        let pairs = pairUntilExhausted(lines)
        
        if pairs.filter({$0.0 == $0.1}).count == pairs.count {
            return [Match(index + pairs.count-1, index + pairs.count, pairs.count)]
        } else {
            // didn't match so shrink
            return reduceFromTop(Array(lines.dropFirstArray()), startIndex: index+1)
        }
    }
    
    
    func findReflection(lines: [[Character]], index: Int = 1) -> [Match] {
        let width = lines.count

        if width < 2 {
            return []
        }
        
        // build comparisons
        if width.isOdd() {
            let startPos = findReflection(lines: Array(lines.dropLast()), index: index)
            let endPos = findReflection(lines: Array(lines.dropFirst()), index: index+1)
            
            return [startPos + endPos].flatMap{$0}
        } else {
            let pairs = pairUntilExhausted(lines)
            
            if pairs.filter({$0.0 == $0.1}).count == pairs.count {
                return [Match(index + pairs.count-1, index + pairs.count, pairs.count)]
            } else {
                // didn't match so shrink
                let startPos = findReflection(lines: Array(lines.dropLast()), index: index)
                let endPos = findReflection(lines: Array(lines.dropFirst()), index: index+1)
                
                return [startPos + endPos].flatMap{$0}
            }
        }
    }
    
    struct Match {
        let first: Int
        let second: Int
        let size: Int
        
        init(_ first: Int, _ second: Int, _ size: Int) {
            self.first = first
            self.second = second
            self.size = size
        }
    }
    
    func pairUntilExhausted(_ inputArray: [[Character]]) -> [([Character], [Character])] {
        var result: [([Character], [Character])] = []
        var array = inputArray
        
        while array.count >= 2 {
            let firstElement = array.removeFirst()
            let lastElement = array.removeLast()
            result.append((firstElement, lastElement))
        }
        
        return result
    }
    
    func rotateArray90Degrees(_ inputArray: [[Character]]) -> [[Character]] {
        let numRows = inputArray.count
        let numCols = inputArray[0].count
        
        var rotatedArray = Array(repeating: Array(repeating: Character(" "), count: numRows), count: numCols)
        
        for i in 0..<numRows {
            for j in 0..<numCols {
                rotatedArray[j][numRows - 1 - i] = inputArray[i][j]
            }
        }
        
        return rotatedArray
    }
    
    func printCharacterGrid(_ grid: [[Character]]) {
        for row in grid {
            let rowString = String(row)
            print(rowString)
        }
    }
    
    func parseData(lines: [String]) -> [[[Character]]] {
        lines.reduce([[]]) { (result: [[String]], line: String) -> [[String]] in
            guard let last = result.last else { return [[line]] }
            return line.isEmpty ? result + [[]] : result.dropLast() + [last + [line]]
        }.filter { !$0.isEmpty }.map{ arr in arr.map{ s in s.toCharArray()} }
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
