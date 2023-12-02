import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day2Test : XCTestCase {
    
    func testDay2Part1Dummy() {
        let games = parseGames(lines: part1DummyData)
        let gamesTested = games.map{ doesRoundExceed(red: 12, green: 13, blue: 14, game: $0) ? 0 : $0.id }
        assertThat(gamesTested.reduce(0, +) == 8)
    }
    
    func testDay2Part1() {
        let games = parseGames(lines: day2Data)
        let gamesTested = games.map{ doesRoundExceed(red: 12, green: 13, blue: 14, game: $0) ? 0 : $0.id }
        assertThat(gamesTested.reduce(0, +) == 2006)
    }
    
    func testDay2Part2Dummy() {
        let games = parseGames(lines: part1DummyData)
        let gamesTested = games.map{ minColours(game: $0) }.map{ $0.0 * $0.1 * $0.2 }
        assertThat(gamesTested.reduce(0, +) == 2286)
    }
    
    func testDay2Part2() {
        let games = parseGames(lines: day2Data)
        let gamesTested = games.map{ minColours(game: $0) }.map{ $0.0 * $0.1 * $0.2 }
        assertThat(gamesTested.reduce(0, +) == 84911)
    }
    
    func minColours(game: Game) -> (Int, Int, Int) {
        let minRed = game.rounds.map{ $0[Colour.red] ?? 0 }.max()!
        let minGreen = game.rounds.map{ $0[Colour.green] ?? 0 }.max()!
        let minBlue = game.rounds.map{ $0[Colour.blue] ?? 0 }.max()!
        
        return (minRed, minGreen, minBlue)
    }
    
    func doesRoundExceed(red: Int, green: Int, blue: Int, game: Game) -> Bool {
        game.rounds.map{
                $0[Colour.red] ?? 0 > red ||
                $0[Colour.green] ?? 0 > green ||
                $0[Colour.blue] ?? 0 > blue
        }.contains(true)
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

        return lines.map{ try! gameParser.parse($0) }.map{ Game(id: $0.0, rounds: $0.1.map{ processColours(input: $0) }) }
    }
    
    func processColours(input: [(Int, Colour)]) -> [Colour : Int] {
        let swapped = input.map { ($0.1, $0.0) }
        return Dictionary(uniqueKeysWithValues: swapped)
    }
    
    struct Game {
        let id: Int
        let rounds: [[Colour : Int]]
    }
    
    enum Colour: Equatable {
        case green
        case red
        case blue
    }
    
    let part1DummyData = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
""".lines
}
