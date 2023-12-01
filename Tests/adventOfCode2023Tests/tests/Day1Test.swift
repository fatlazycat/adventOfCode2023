import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day1Test : XCTestCase {
    
    func testDay1Part1Dummy() {
        let data = day1DummyData.lines
        let pairs = data.map{ ($0[$0.firstIndex(where: {$0.isNumber})!],
                               $0[$0.lastIndex(where: {$0.isNumber})!]) }
        let numbers = pairs.map{ Int(String([$0.0, $0.1]))! }
        assertThat(numbers.reduce(0, +) == 142)
    }
    
    func testDay1Part1() {
        let data = day1Data.lines
        let pairs = data.map{ ($0[$0.firstIndex(where: {$0.isNumber})!],
                               $0[$0.lastIndex(where: {$0.isNumber})!]) }
        let numbers = pairs.map{ Int(String([$0.0, $0.1]))! }
        assertThat(numbers.reduce(0, +) == 54968)
    }
    
}

public let day1DummyData = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""
