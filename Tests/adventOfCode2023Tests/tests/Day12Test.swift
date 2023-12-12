import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day12Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = try! parser.parse(day12DummyData)
        let results = data.map{ getArrangements(s: $0.0, ls: $0.1) }
        XCTAssertEqual(results.reduce(0, +), 21)
    }
    
    func testPart1(){
        let data = try! parser.parse(day12Data)
        let results = data.map{ getArrangements(s: $0.0, ls: $0.1) }
        XCTAssertEqual(results.reduce(0, +), 7169)
    }
    
    func testPart2Dummy(){
        let data = try! parser.parse(day12DummyData)
        let results = data.map{ (s, counts) in
            let expandedS = (0..<5).map { _ in s }.joined(separator: "?")
            let expandedCounts = (0..<5).flatMap { _ in counts }
            return getArrangements(s: Substring(expandedS), ls: expandedCounts)
        }
        XCTAssertEqual(results.reduce(0, +), 525152)
    }
    
    func testPart2(){
        let data = try! parser.parse(day12Data)
        let results = data.map{ (s, counts) in
            let expandedS = (0..<5).map { _ in s }.joined(separator: "?")
            let expandedCounts = (0..<5).flatMap { _ in counts }
            return getArrangements(s: Substring(expandedS), ls: expandedCounts)
        }
        XCTAssertEqual(results.reduce(0, +), 1738259948652)
    }
    
    func getArrangements(s: Substring, ls: [Int]) -> Int {
        let memo = (0..<s.count).map{ i in s.dropFirst(i).prefix(while: { c in c != "." }).count }
        var dp = [Pair: Int]()
        
        func canTake(i: Int, l: Int) -> Bool {
            memo[i] >= l && (i+l == s.count || s[i+l] != "#")
        }
        
        func helper(si: Int, lsi: Int) -> Int {
            if lsi == ls.count {
                return s.dropFirst(si).filter({ $0 == "#"}).count == 0 ? 1 : 0
            } else if si >= s.count {
                return 0
            } else {
                let key = Pair(first: si, second: lsi)
                if dp[key] == nil {
                    let take = canTake(i: si, l: ls[lsi]) ? helper(si: si + ls[lsi] + 1, lsi: lsi + 1) : 0
                    let dontTake = s[s.index(s.startIndex, offsetBy: si)] != "#" ? helper(si: si + 1, lsi: lsi) : 0
                    dp[key] = take + dontTake
                }
                return dp[key]!
            }
        }
        
        return helper(si: 0, lsi: 0)
    }
    
    struct Pair: Equatable, Hashable {
        let first: Int
        let second: Int
    }
    
    let parser = Parse(input: Substring.self) {
        Many {
            Prefix{ $0 != " " }
            Whitespace()
            Many {
                Int.parser()
            } separator: {
                ","
            }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
}
