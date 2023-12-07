import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day4Test : XCTestCase {
    let parser = Parse(input: Substring.self) {
        Skip{ "Card" }
        Whitespace()
        Int.parser()
        Skip{ ":" }
        Many {
            Whitespace()
            Int.parser()
            Whitespace()
        }
        Skip{ "|" }
        Many {
            Whitespace()
            Int.parser()
            Whitespace()
        }
    }
    
    func testPart1Dummy() {
        let data = day4DummyData.map{ try! parser.parse($0) }
        assertThat(calc(data: data) == 13)
    }
    
    func testPart1() {
        let data = day4Data.map{ try! parser.parse($0) }
        assertThat(calc(data: data) == 15205)
    }
    
    func testPart2Dummy() {
        let data = day4DummyData.map{ try! parser.parse($0) }
        assertThat(cardCount(data: data) == 30)
    }
    
    func testPart2() {
        let data = day4Data.map{ try! parser.parse($0) }
        assertThat(cardCount(data: data) == 6189740)
    }
    
    func cardCount(data: [(Int, [Int], [Int])]) -> Int {
        var cards = Dictionary<Int, Int>()
                
        data.forEach({ (card) in
            let matchesCount = Set(card.1).intersection(card.2).count
            
            cards[card.0] = cards[card.0, default: 0] + 1
            
            let currentCardCount = cards[card.0, default: 1]
            
            (card.0 + 1 ..< card.0 + 1 + matchesCount).forEach { wonCard in
                cards[wonCard] = cards[wonCard, default: 0] + currentCardCount
            }
        })
        
        return cards.values.reduce(0, +)
    }
    
    func calc(data: [(Int, [Int], [Int])]) -> Int {
        let matches = data.map{ Set($0.1).intersection($0.2) }
        let score = matches.map{ 2.pow(toPower: $0.count-1) }
        return score.reduce(0, +)
    }
}

extension Int {
    func pow(toPower: Int) -> Int {
        guard toPower >= 0 else { return 0 }
        return Array(repeating: self, count: toPower).reduce(1, *)
    }
}

let day4DummyData = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
""".lines
