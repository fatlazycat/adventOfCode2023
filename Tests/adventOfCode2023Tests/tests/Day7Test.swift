import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day7Test : XCTestCase {
    
    func testPart1Dummy() {
        assertThat(calcPart1(s: day7DummyData) == 6440)
    }
    
    func testPart1() {
        assertThat(calcPart1(s: day7Data) == 248217452)
    }
    
    func calcPart1(s: String) -> Int {
        let data = try! parser.parse(s)
        let hands = data.map{ Hand(cards: $0.0, bet: $0.1) }
        let orderedHands = hands.sorted()
        let prize = orderedHands.enumerated().map{ (i, h) in h.bet * (i+1) }
        return prize.reduce(0, +)
    }
    
    let parser = Parse(input: Substring.self) {
        Many {
            Prefix{ $0 != " "}
            Whitespace()
            Int.parser()
        } separator: {
            Whitespace(1, .vertical)
        }
    }
    
    struct Hand : Comparable {
        static func < (lhs: Day7Test.Hand, rhs: Day7Test.Hand) -> Bool {
            !lhs.orderBefore(rhs: rhs)
        }
        
        let cards: Substring
        let bet: Int
        let hand: Int
        
        init(cards: Substring, bet: Int) {
            self.cards = cards
            self.bet = bet
            self.hand = Day7Test.Hand.calcHand(cards)
        }
        
        private static func calcHand(_ s: Substring) -> Int {
            let seqs = s.histogram()
            
            if seqs.count == 1 {
                return CardHand.five.rawValue
            } else if seqs.count == 2 {
                if seqs.contains(where: { $0.value == 4} ) {
                    return CardHand.four.rawValue
                } else {
                    return CardHand.full.rawValue
                }
            } else if seqs.count == 3 {
                if seqs.contains(where: { $0.value == 3} ) {
                    return CardHand.three.rawValue
                } else {
                    return CardHand.twoPair.rawValue
                }
            } else if seqs.count == 4 {
                return CardHand.onePair.rawValue
            }
            
//            return s.toCharArray().map{ cardRank[String($0)]! }.max()!
            return CardHand.high.rawValue
        }
        
        func orderBefore(rhs: Hand) -> Bool {
            // Return true if LHS should be before RHS
            let lhsHand = self.hand
            let rhsHand = rhs.hand
            
            if lhsHand != rhsHand {
                return lhsHand > rhsHand
            } else {
                // compare cards
                let zipped = zip2(self.cards.toCharArray(), rhs.cards.toCharArray())
                let firstMismatch = zipped.first(where: { $0.0 != $0.1 })
                
                return cardRank[String(firstMismatch!.0)]! > cardRank[String(firstMismatch!.1)]!
            }
            
        }
    }
    
    enum CardHand : Int {
        case five = 27
        case four = 26
        case full = 25
        case three = 24
        case twoPair = 23
        case onePair = 22
        case high = 21
    }
}

let cardRank = [
    "A" : 14,
    "K" : 13,
    "Q" : 12,
    "J" : 11,
    "T" : 10,
    "9" : 9,
    "8" : 8,
    "7" : 7,
    "6" : 6,
    "5" : 5,
    "4" : 4,
    "3" : 3,
    "2" : 2,
]
