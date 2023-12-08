import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day8Test : XCTestCase {
    
    func testPart1Dummy(){
        assertThat(part1(lines: day8DummyData) == 2)
    }
    
    func testPart1(){
        assertThat(part1(lines: day8Data) == 18023)
    }
    
    func part1(lines: [String]) -> Int {
        let directions = lines[0]
        let mapRaw = try! parser.parse(lines.dropFirst(2).joined(separator: "\n"))
        let mapValues = mapRaw.map{ (String($0.0), (String($0.1), String($0.2))) }
        let map = Dictionary(uniqueKeysWithValues: mapValues)
        var i = 0
        var steps = 0
        var stop = false
        var location = "AAA"
        
        while(!stop) {
            if i == directions.count {
                i = 0
            }
            
            let entry = map[location]!
            
            if directions[i] == "L" {
                location = entry.0
            } else {
                location = entry.1
            }
            
            i += 1
            steps += 1
            
            if location == "ZZZ" {
                stop = true
            }
        }
        
        return steps
    }
    
    let parser = Parse(input: Substring.self){
        Many {
            Prefix{ $0 != " " }
            Skip{ " = (" }
            Prefix{ $0 != "," }
            Skip{ ", " }
            Prefix{ $0 != ")" }
            Skip{ ")" }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
}
