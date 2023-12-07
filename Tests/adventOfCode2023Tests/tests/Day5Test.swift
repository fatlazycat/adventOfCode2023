import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day5Test : XCTestCase {
    
    func testPart1Dummy() {
       assertThat(processPart1(data: day5DummyData) == 35)
    }
    
    func testPart1() {
       assertThat(processPart1(data: day5Data) == 265018614)
    }
    
    func testPart2Dummy() {
        assertThat(processPart2(data: day5DummyData) == 46)
    }
    
// Slow Running
//    func testPart2() {
//        assertThat(processPart2(data: day5Data) == 63179500)
//    }
    
    func testPart2DummyAgain() {
        assertThat(processPart2Again(data: day5DummyData) == 46)
    }
  
// Slow Running
//    func testPart2Again() {
//        assertThat(processPart2Again(data: day5Data) == 63179500)
//    }
    
    func processPart2(data: [String]) -> Int {
        let mapsRaw = try! mapParser.parse(data.dropFirst(2).joined(separator: "\n"))
        let mapsProcessed = mapsRaw.map{ ($0, $1.map{ Lookup(destination: $0.0, source: $0.1, range: $0.2) }) }
        let maps = Dictionary(uniqueKeysWithValues: mapsProcessed)
        let seedRanges = try! seedParser.parse(data[0]).chunked(size: 2, partialWindows: false)
        var currentMin: Int? = nil
        
        seedRanges.forEach({ range in
            let start = range[0]
            let length = range[1]
            
            (start..<start + length).forEach( { seed in
                let possibleMin = processSeed(seed: seed, maps: maps)
                
                if let current = currentMin {
                    currentMin = min(current, possibleMin)
                } else {
                    currentMin = possibleMin
                }
            })
        })
        
        return currentMin!
    }
    
    func processPart2Again(data: [String]) -> Int {
        let mapsRaw = try! mapParser.parse(data.dropFirst(2).joined(separator: "\n"))
        let mapsProcessed = mapsRaw.map{ ($0, $1.map{ Lookup(destination: $0.0, source: $0.1, range: $0.2) }) }
        let maps = Dictionary(uniqueKeysWithValues: mapsProcessed)
        let seedRanges = try! seedParser.parse(data[0]).chunked(size: 2, partialWindows: false)
        var location: Int = 0
        var stop = false
        var result: Int? = nil
        
        while(!stop) {
            let seed = findSeedForLocation(location: location, maps: maps)
            let inRange = seedRanges.filter({ range in
                let start = range[0]
                let length = range[1]
                
                return seed >= start && seed < start + length
            })
            
            if !inRange.isEmpty {
                stop = true
                result = location
            } else {
                location += 1
            }
        }
        
        return result!
    }
    
    func processPart1(data: [String]) -> Int {
        let seeds = try! seedParser.parse(data[0])
        let mapsRaw = try! mapParser.parse(data.dropFirst(2).joined(separator: "\n"))
        let mapsProcessed = mapsRaw.map{ ($0, $1.map{ Lookup(destination: $0.0, source: $0.1, range: $0.2) }) }
        let maps = Dictionary(uniqueKeysWithValues: mapsProcessed)
        let locations = seeds.map{ processSeed(seed: $0, maps: maps) }
        
        return locations.min()!
    }

    
    func lookupValue(valToMap: Int, data: [Lookup]) -> Int {
        let match = data.first(where: { l in valToMap >= l.source && valToMap < l.source + l.range })
        
        if let foundMatch = match {
            let offset = valToMap - foundMatch.source
            return foundMatch.destination + offset
        } else {
            return valToMap
        }
    }
    
    func lookupValueReverse(valToMap: Int, data: [Lookup]) -> Int {
        let match = data.first(where: { l in valToMap >= l.destination && valToMap < l.destination + l.range })
        
        if let foundMatch = match {
            let offset = valToMap - foundMatch.destination
            return foundMatch.source + offset
        } else {
            return valToMap
        }
    }
    
    func processSeed(seed: Int, maps: [Substring : [Day5Test.Lookup]]) -> Int {
        let soil = lookupValue(valToMap: seed, data: maps["seed-to-soil"]!)
        let fertilizer = lookupValue(valToMap: soil, data: maps["soil-to-fertilizer"]!)
        let water = lookupValue(valToMap: fertilizer, data: maps["fertilizer-to-water"]!)
        let light = lookupValue(valToMap: water, data: maps["water-to-light"]!)
        let temp = lookupValue(valToMap: light, data: maps["light-to-temperature"]!)
        let humidity = lookupValue(valToMap: temp, data: maps["temperature-to-humidity"]!)
        let location = lookupValue(valToMap: humidity, data: maps["humidity-to-location"]!)
        
        return location
    }

    func findSeedForLocation(location: Int, maps: [Substring : [Day5Test.Lookup]]) -> Int {
        let humidity = lookupValueReverse(valToMap: location, data: maps["humidity-to-location"]!)
        let temp = lookupValueReverse(valToMap: humidity, data: maps["temperature-to-humidity"]!)
        let light = lookupValueReverse(valToMap: temp, data: maps["light-to-temperature"]!)
        let water = lookupValueReverse(valToMap: light, data: maps["water-to-light"]!)
        let fertilizer = lookupValueReverse(valToMap: water, data: maps["fertilizer-to-water"]!)
        let soil = lookupValueReverse(valToMap: fertilizer, data: maps["soil-to-fertilizer"]!)
        let seed = lookupValueReverse(valToMap: soil, data: maps["seed-to-soil"]!)
        
        return seed
    }
        
    let seedParser = Parse(input: Substring.self) {
        Skip{ "seeds:" }
        Many {
            Whitespace()
            Int.parser()
            Whitespace()
        }
    }
    
    let mapParser = Parse(input: Substring.self) {
        Many {
            Prefix{ $0 != " " }
            Skip{ " map:" }
            Whitespace(1, .vertical)
            Many {
                Int.parser()
                Whitespace()
                Int.parser()
                Whitespace()
                Int.parser()
                Whitespace(1, .vertical)
            }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
    
    struct Lookup {
        let destination: Int
        let source: Int
        let range: Int
    }
}

let day5DummyData = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4

""".lines
