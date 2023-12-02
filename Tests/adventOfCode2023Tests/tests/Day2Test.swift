import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day2Test : XCTestCase {
    
    func testDay2Part1Dummy() {
        parseGames(lines: part1DummyData)
    }
    
    func parseGames(lines: [String]) -> [Game] {
        let roundParser = Parse(input: Substring.self) {
            Many {
                Whitespace()
                Int.parser()
                Whitespace()
                OneOf {
                    "green".map { Colour.green }
                    "red".map { Colour.red }
                    "blue".map { Colour.blue }
                }
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
        let rounds: [[(Int, Colour)]]
    }
    
    enum Colour: Equatable {
        case green
        case red
        case blue
    }
    
    struct Round {
        let green: Int = 0
        let blue: Int = 0
        let red: Int = 0
    }
    
    let part1DummyData = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
""".lines
}
