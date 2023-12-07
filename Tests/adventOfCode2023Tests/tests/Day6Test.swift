import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day6Test : XCTestCase {
    
    func testPart1Dummy() {
        let results = day6DummyData.map{ calcDistance(raceTime: $0.time, record: $0.record) }
        assertThat(results.reduce(1, *) == 288)
    }
    
    func testPart1() {
        let results = day6Data.map{ calcDistance(raceTime: $0.time, record: $0.record) }
        assertThat(results.reduce(1, *) == 131376)
    }
    
    func calcDistance(raceTime: Int, record: Int) -> Int {
        (0...raceTime).map{ $0 * (raceTime - $0) }.filter{ $0 > record }.count
    }
}

let day6DummyData = [
    Race(time: 7, record: 9),
    Race(time: 15, record: 40),
    Race(time: 30, record: 200),
]

//Time:      7  15   30
//Distance:  9  40  200

// Hold * (Race - Hold)
