import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day2Test : XCTestCase {
    
    func testDay2Part1Dummy() {
        parseGames(lines: part1DummyData)
        
        //        let games = part1DummyData.map {
        //            try! rowParser.parse($0)
        //        }
//        let roundData = "8 green, 6 blue, 20 red"
//        let roundsData = "8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
//        
//        let roundParser = Parse(input: Substring.self) {
//            Many {
//                Whitespace()
//                Int.parser()
//                Whitespace()
//                Prefix { $0 != "," && $0 != ";" }
//            } separator: {
//                ","
//            }
//        }
//        
//        let roundsParser = Parse(input: Substring.self) {
//            Many {
//                roundParser
//            } separator: {
//                ";"
//            }
//        }
//        
//        let round = try! roundParser.parse(roundData)
//        let rounds = try! roundsParser.parse(roundsData)
//        
//        print(round)
//        print(rounds)
    }
    
    func parseGames(lines: [String]) -> [Game] {
        let roundParser = Parse(input: Substring.self) {
            Many {
                Whitespace()
                Int.parser()
                Whitespace()
                Prefix { $0 != "," && $0 != ";" }
            } separator: {
                ","
            }
        }
        
        let roundsParser = Parse(input: Substring.self) {
            Many {
                roundParser
            } separator: {
                ";"
            }
        }
        
        let gameParser = Parse(input: Substring.self) {
            Skip{ "Game "}
            Int.parser()
            Skip{ ":" }
            roundsParser
        }
        
        let games = lines.map{ try! gameParser.parse($0) }.map{ Game(id: $0.0, rounds: $0.1) }
        
        print(games)
        return games
    }

    
//    let rowParser = Parse(input: Substring.self) {
//        Game(id: $0, rounds: $1)
//    } with: {
//        Skip{ "Game "}
//        Int.parser()
//        Skip{ ":" }
//        Many {
//            Many {
//                Whitespace()
//                Int.parser()
//                Whitespace()
//                Prefix { $0 != "," }
//            } separator: {
//                ","
//            } terminator: {
//                "\n"
//            }
//        } separator: {
//            ";"
//        } terminator: {
//            "\n"
//        }
//    }
    
    struct Game {
        let id: Int
        let rounds: [[(Int, Substring)]]
    }
    
    struct Round {
        let green: Int
        let blue: Int
        let red: Int
    }
    
    let part1DummyData = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
""".lines
}
