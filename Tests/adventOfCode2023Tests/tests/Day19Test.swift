import XCTest
import Parsing
import Foundation

class Day19Test : XCTestCase {
    
    func testPart1Dummy(){
        let rawData = parseData(lines: day19DummyData.lines)
        let workflows = rawData[0].map{ try! Day19Test.workflowParser.parse($0) }.map{ Workflow.init(name: $0.0, rules: $0.1) }
        let ratings = rawData[1].map{ try! Day19Test.ratingParser.parse($0) }.map{ Rating(x: $0.0, m: $0.1, a: $0.2, s: $0.3) }
        let workflowMap = Dictionary(uniqueKeysWithValues: workflows.map{ ($0.name, $0) })
        XCTAssertEqual(19114, part1(ratings: ratings, workflowMap: workflowMap))
    }
    
    func testPart1(){
        let rawData = parseData(lines: day19Data.lines)
        let workflows = rawData[0].map{ try! Day19Test.workflowParser.parse($0) }.map{ Workflow.init(name: $0.0, rules: $0.1) }
        let ratings = rawData[1].map{ try! Day19Test.ratingParser.parse($0) }.map{ Rating(x: $0.0, m: $0.1, a: $0.2, s: $0.3) }
        let workflowMap = Dictionary(uniqueKeysWithValues: workflows.map{ ($0.name, $0) })
        XCTAssertEqual(374873, part1(ratings: ratings, workflowMap: workflowMap))
    }
    
    func part1(ratings: [Rating], workflowMap: [Substring : Workflow]) -> Int {
        ratings.filter({ isAccepted(rating: $0, workflowMap: workflowMap) }).map{ $0.sum() }.reduce(0, +)
    }
    
    func isAccepted(rating: Rating, workflowMap: [Substring : Workflow]) -> Bool {
        var current = workflowMap["in"]!
        var stop = false
        
        while !stop {
            let rules = current.rules
            let result = rules.first(where: {ruleMatch(rule: $0, rating: rating)})!
            
            switch result {
            case .Accept:
                return true
            case .Reject:
                return false
            case .Condition(_, _, _, let destination):
                if destination == "A" {
                    return true
                } else if destination == "R" {
                    return false
                }
                current = workflowMap[destination]!
            case .Destination(let destination):
                if destination == "A" {
                    return true
                } else if destination == "R" {
                    return false
                }
                current = workflowMap[destination]!
            }
        }
    }
    
    func ruleMatch(rule: Rule, rating: Rating) -> Bool {
        return switch rule {
        case .Condition(let ruleRating, let cond, let num, _):
            switch ruleRating {
            case "x":
                compareRule(val: rating.x, cond: cond, num: num)
            case "m":
                compareRule(val: rating.m, cond: cond, num: num)
            case "a":
                compareRule(val: rating.a, cond: cond, num: num)
            case "s":
                compareRule(val: rating.s, cond: cond, num: num)
            default:
                fatalError("Unknown type")
            }
        default:
            true
        }
    }

    func compareRule(val: Int, cond: Character, num: Int) -> Bool {
        if cond == "<" {
            val < num
        } else {
            val > num
        }
    }
    
    struct Workflow : Equatable, Hashable {
        let name: Substring
        let rules: [Rule]
    }

    enum Rule : Equatable, Hashable {
        case Accept
        case Reject
        case Condition(Substring, Character, Int, Substring)
        case Destination(Substring)
    }
    
    struct Rating : Equatable, Hashable{
        let x: Int
        let m: Int
        let a: Int
        let s: Int
        
        func sum() -> Int {
            x + m + a + s
        }
    }
    
    func testParsers() {
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Reject])], [try! Day19Test.workflowParser.parse("in{R}")].map{ Workflow.init(name: $0.0, rules: $0.1) })
        XCTAssertEqual(Rule.Condition("b", "<", 1, "qz"), try! Day19Test.ruleParser.parse("b<1:qz"))
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Condition("b", "<", 1, "qz")])], [try! Day19Test.workflowParser.parse("in{b<1:qz}")].map{ Workflow.init(name: $0.0, rules: $0.1) })
        
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Condition("b", "<", 1, "qz"),Rule.Condition("c", ">", 2, "qq"), Rule.Accept])],
                       [try! Day19Test.workflowParser.parse("in{b<1:qz,c>2:qq,A}")].map{ Workflow.init(name: $0.0, rules: $0.1) })
        
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Condition("a", "<", 2006, "qkq"), Rule.Condition("m", ">", 2090, "A"), Rule.Destination("rfg")])],
                       [try! Day19Test.workflowParser.parse("in{a<2006:qkq,m>2090:A,rfg}")].map{ Workflow.init(name: $0.0, rules: $0.1) })
    }
    
    func testRatingParser() {
        XCTAssertEqual([Rating(x: 787, m: 2655, a: 1222, s: 2876)], [try! Day19Test.ratingParser.parse("{x=787,m=2655,a=1222,s=2876}")].map{ Rating(x: $0.0, m: $0.1, a: $0.2, s: $0.3) })
    }
    
    static let ratingParser = Parse(input: Substring.self) {
        "{x="
        Int.parser()
        ",m="
        Int.parser()
        ",a="
        Int.parser()
        ",s="
        Int.parser()
        "}"
    }
    
    static let workflowParser = Parse(input: Substring.self) {
        Prefix{ $0 != "{" }
        Skip { "{" }
        Many {
            ruleParser
        } separator: {
            ","
        }
        Skip { "}" }
    }
    
    static let ruleParser = Parse(input: Substring.UTF8View.self) {
        OneOf {
            "A".utf8.map{ Rule.Accept }
            "R".utf8.map{ Rule.Reject }
            From(.substring) { conditionParser.map{ Rule.Condition($0.0, $0.1, $0.2, $0.3) }}
            From(.substring) { Prefix{ $0 != "," && $0 != "}" }.map{ Rule.Destination($0)}}
        }
    }
    
    static let conditionParser = Parse(input: Substring.self) {
        Prefix{ $0 != "<" && $0 != ">" }
        First()
        Int.parser()
        ":"
        Prefix{ $0 != "," && $0 != "}" }
    }
    
    func parseData(lines: [String]) -> [[String]] {
        lines.reduce([[]]) { (result: [[String]], line: String) -> [[String]] in
            guard let last = result.last else { return [[line]] }
            return line.isEmpty ? result + [[]] : result.dropLast() + [last + [line]]
        }
    }
}
