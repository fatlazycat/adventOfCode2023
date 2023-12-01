import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day1Test : XCTestCase {
    
    func testDay1Part1Dummy() {
        assertThat(calc(lines: day1DummyData.lines) == 142)
    }
    
    func testDay1Part1() {
        assertThat(calc(lines: day1Data.lines) == 54968)
    }
    
    func testDay1Part2Dummy() {
        let data = day1DummyData2.lines.map{ replaceSpelledNumbers(s: $0) }
        assertThat(calc(lines: data) == 281)
    }
    
    func testDay1Part2() {
        let data = day1Data.lines.map{ replaceSpelledNumbers(s: $0) }
        assertThat(calc(lines: data) == 54094)
    }
    
    func calc(lines: [String]) -> Int {
        let pairs = lines.map{ ($0[$0.firstIndex(where: {$0.isNumber})!],
                               $0[$0.lastIndex(where: {$0.isNumber})!]) }
        let numbers = pairs.map{ Int(String([$0.0, $0.1]))! }
        
        return numbers.reduce(0, +)
    }
    
    func replaceSpelledNumbers(s: String) -> String {
        foldl(sequence: spelledOutNumbers, base: s, transform:{ (acc, e) in acc.replacingOccurrences(of: e.key, with: e.value) })
    }
    
}

public let spelledOutNumbers =
["one": "o1e",
 "two": "t2o",
 "three": "t3e",
 "four": "f4r",
 "five": "f5e",
 "six": "s6x",
 "seven": "s7n",
 "eight": "e8t",
 "nine": "n9e"]

public let day1DummyData = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""

public let day1DummyData2 = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""
