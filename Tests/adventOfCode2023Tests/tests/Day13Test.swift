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
    
    func testPart2Dummy(){
        let data = parseData(lines: day13DummyData)
        let result = data.map{ correctSmudge(data: $0) }
        
        XCTAssertEqual(result.reduce(0, +), 400)
    }
    
    func testPart2(){
        let data = parseData(lines: day13Data)
        let result = data.map{ correctSmudge(data: $0) }
        
        XCTAssertEqual(result.reduce(0, +), 22906)
    }
    
    func correctSmudge(data: [[Character]]) -> Int {
        let points = (0..<data.count).flatMap{ row in (0..<data[row].count).map{ col in Point(col, row) } }
        let original = getMirrorLineCalcWithData(data: data)
        
        let result = points.map{ p in
            let updatedGrid = swapPoint(p: p, data: data)
            return getMirrorLineCalcWithIgnore(data: updatedGrid, ignore: original)
        }.filter({ $0 != 0 })
        
        return result.first!
    }
    
    func swapPoint(p: Point, data: [[Character]]) -> [[Character]] {
        var copy = data
        
        if data[p.y][p.x] == "#" {
            copy[p.y][p.x] = "."
        } else {
            copy[p.y][p.x] = "#"
        }
        
        return copy
    }
    
    func getMirrorLineCalc(data: [[Character]]) -> Int {
        let vertical = [reduceFromTop(rotateArray90Degrees(data)), reduceFromBottom(rotateArray90Degrees(data))].flatMap{ $0 }.map{ $0.first }
        let horizontal = [reduceFromTop(data), reduceFromBottom(data)].flatMap{ $0 }.map{ $0.first * 100 }
        
        return (vertical + horizontal).reduce(0, +)
    }
    
    func getMirrorLineCalcWithIgnore(data: [[Character]], ignore: (Orientation, Int)) -> Int {
        
        var vertical = [reduceFromTop(rotateArray90Degrees(data)), reduceFromBottom(rotateArray90Degrees(data))].flatMap{ $0 }
        var horizontal = [reduceFromTop(data), reduceFromBottom(data)].flatMap{ $0 }
        
        if ignore.0 == Orientation.Horiztonal {
            horizontal.removeAll(where: { $0.first == ignore.1 })
        } else {
            vertical.removeAll(where: { $0.first == ignore.1 })
        }
        
        return (vertical.map{ $0.first } + horizontal.map{ $0.first * 100 }).reduce(0, +)
    }
    
    
    func getMirrorLineCalcWithData(data: [[Character]]) -> (Orientation, Int) {
        let vert1 = reduceFromTop(rotateArray90Degrees(data))
        let vert2 = reduceFromBottom(rotateArray90Degrees(data))
        let horz1 = reduceFromTop(data)
        let horz2 = reduceFromBottom(data)
        
        if !vert1.isEmpty {
            return (Orientation.Vertical, vert1.first!.first)
        } else if !vert2.isEmpty {
            return (Orientation.Vertical, vert2.first!.first)
        } else if !horz1.isEmpty {
            return (Orientation.Horiztonal, horz1.first!.first)
        } else {
            return (Orientation.Horiztonal, horz2.first!.first)
        }
    }

    enum Orientation {
        case Vertical
        case Horiztonal
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
