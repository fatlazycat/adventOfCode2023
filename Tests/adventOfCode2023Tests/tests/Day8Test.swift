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
    
    func testPart2Dummy(){
        assertThat(part2(lines: day8DummyData2) == 6)
    }

    func testPart2(){
        assertThat(part2(lines: day8Data) == 14449445933179)
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
    
    func part2(lines: [String]) -> Int {
        let directions = lines[0]
        let mapRaw = try! parser.parse(lines.dropFirst(2).joined(separator: "\n"))
        let mapValues = mapRaw.map{ (String($0.0), (String($0.1), String($0.2))) }
        let map = Dictionary(uniqueKeysWithValues: mapValues)
        let locations = map.keys.filter{ $0.last == "A"}
        
        let smallestSteps = locations.map { startLocation in
            var i = 0
            var steps = 0
            var stop = false
            var location = startLocation
            
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
                
                if location.last == "Z" {
                    stop = true
                }
            }
            
            return steps
        }
        
        return lcmOfArray(smallestSteps)
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

func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a
    var b = b
    while b != 0 {
        let temp = b
        b = a % b
        a = temp
    }
    return a
}

func lcm(_ a: Int, _ b: Int) -> Int {
    if a == 0 || b == 0 {
        return 0
    }
    return abs(a * b) / gcd(a, b)
}

func lcmOfArray(_ numbers: [Int]) -> Int {
    guard numbers.count > 1 else {
        fatalError("Array must contain at least two numbers.")
    }

    var result = numbers[0]
    
    for i in 1..<numbers.count {
        result = lcm(result, numbers[i])
    }
    
    return result
}
