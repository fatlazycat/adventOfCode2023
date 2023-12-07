import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day6Test : XCTestCase {
    
    func testPart1Dummy() {
        let results = day6DummyData.map{ calcDistance(raceTime: $0.time, record: $0.record) }
        assertThat(results.reduce(1, *) == 288)
    }
    
    func testPart1DummyCalc() {
        let results = day6DummyData.map{ calcPasses(raceTime: $0.time, record: $0.record) }
        assertThat(results.reduce(1, *) == 288)
    }
    
    func testPart1() {
        let results = day6Data.map{ calcDistance(raceTime: $0.time, record: $0.record) }
        assertThat(results.reduce(1, *) == 131376)
    }
    
    func testPart1Calc() {
        let results = day6Data.map{ calcPasses(raceTime: $0.time, record: $0.record) }
        assertThat(results.reduce(1, *) == 131376)
    }
    
    func testPart2DummyCalc() {
        let result = calcPasses(raceTime: 71530, record: 940200)
        assertThat(result == 71503)
    }
    
    func testPart2Calc() {
        let result = calcPasses(raceTime: 51699878, record: 377117112241505)
        assertThat(result == 34123437)
    }
    
    func calcDistance(raceTime: Int, record: Int) -> Int {
        (0...raceTime).map{ $0 * (raceTime - $0) }.filter{ $0 > record }.count
    }
    
    func calcPasses(raceTime: Int, record: Int) -> Int {
        let min = calcMin(raceTime: raceTime, record: record)
        let max = calcMax(raceTime: raceTime, record: record)
        
        return max - min + 1
    }
    
    func calcMin(raceTime: Int, record: Int) -> Int {
        (0...raceTime).first{ $0 * (raceTime - $0) > record }!
    }
    
    func calcMax(raceTime: Int, record: Int) -> Int {
        (0...raceTime).reversed().first{ $0 * (raceTime - $0) > record }!
    }
    
}

let day6DummyData = [
    Race(time: 7, record: 9),
    Race(time: 15, record: 40),
    Race(time: 30, record: 200),
]

//Time:      7  15   30
//Distance:  9  40  200

// Hold * (Race - Hold) = record
// Record 9
// Hold * ( 9 - hold ) = 9
