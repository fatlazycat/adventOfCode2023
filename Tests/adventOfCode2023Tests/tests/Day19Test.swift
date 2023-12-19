import XCTest
import Parsing
import Foundation

class Day19Test : XCTestCase {
    
    func testPart1Dummy(){
        let rawData = parseData(lines: day19DummyData.lines)
        let workflows = rawData[0].map{ try! Day19Test.workflowParser.parse($0) }
        let ratings = rawData[1].map{ try! Day19Test.ratingParser.parse($0) }
        XCTAssertEqual(19114, part1(ratings: ratings, workflows: workflows))
    }
    
    func testPart1(){
        let rawData = parseData(lines: day19Data.lines)
        let workflows = rawData[0].map{ try! Day19Test.workflowParser.parse($0) }
        let ratings = rawData[1].map{ try! Day19Test.ratingParser.parse($0) }
        XCTAssertEqual(374873, part1(ratings: ratings, workflows: workflows))
    }
    
    func testPart2Dummy(){
        let rawData = parseData(lines: day19DummyData.lines)
        let workflows = rawData[0].map{ try! Day19Test.workflowParser.parse($0) }
        let workflowMap = Dictionary(uniqueKeysWithValues: workflows.map{ ($0.name, $0) })
        XCTAssertEqual(167409079868000, part2(workflowMap: workflowMap))
    }
    
    func testPart2(){
        let rawData = parseData(lines: day19Data.lines)
        let workflows = rawData[0].map{ try! Day19Test.workflowParser.parse($0) }
        let workflowMap = Dictionary(uniqueKeysWithValues: workflows.map{ ($0.name, $0) })
        XCTAssertEqual(122112157518711, part2(workflowMap: workflowMap))
    }
    
    func part1(ratings: [Rating], workflows: [Workflow]) -> Int {
        let workflowMap = Dictionary(uniqueKeysWithValues: workflows.map{ ($0.name, $0) })
        let range = XmasRange(x: Range(lower: 1, upper: 4000), m: Range(lower: 1, upper: 4000), a: Range(lower: 1, upper: 4000), s: Range(lower: 1, upper: 4000))
        let acceptedRanges = acceptedRanges(xmasRange: range, rules: workflowMap["in"]!.rules, workflowMap: workflowMap)
        let accepted = ratings.filter({ rating in acceptedRanges.first{ $0.contained(otherX: rating.x, otherM: rating.m, otherA: rating.a, otherS: rating.s)} != nil })
        
        return accepted.map{ $0.sum() }.reduce(0, +)
    }
    
    func part2(workflowMap: [Substring : Workflow]) -> Int {
        let range = XmasRange(x: Range(lower: 1, upper: 4000), m: Range(lower: 1, upper: 4000), a: Range(lower: 1, upper: 4000), s: Range(lower: 1, upper: 4000))
        let result = acceptedRanges(xmasRange: range, rules: workflowMap["in"]!.rules, workflowMap: workflowMap)
        
        return result.map{ $0.getCombinations() }.reduce(0, +)
    }
    
    func acceptedRanges(xmasRange: XmasRange, rules: [Rule], workflowMap: [Substring : Workflow]) -> [XmasRange] {
        let rule = rules.first!
        let restOfRules = rules.dropFirst()
        
        switch rule {
        case .Accept:
            return [xmasRange]
        case .Reject:
            return []
        case .Condition(let ruleRating, let cond, let num, let destination):
            let newRanges = updateRange(r: xmasRange, ruleRating: ruleRating, cond: cond, num: num)
            
            if destination == "A" {
                return [newRanges.0] + acceptedRanges(xmasRange: newRanges.1, rules: Array(restOfRules), workflowMap: workflowMap)
            } else if destination == "R" {
                return [] + acceptedRanges(xmasRange: newRanges.1, rules: Array(restOfRules), workflowMap: workflowMap)
            } else {
                return acceptedRanges(xmasRange: newRanges.0, rules: workflowMap[destination]!.rules, workflowMap: workflowMap) +
                acceptedRanges(xmasRange: newRanges.1, rules: Array(restOfRules), workflowMap: workflowMap)
            }
        case .Destination(let destination):
            if destination == "A" {
                return [xmasRange]
            } else if destination == "R" {
                return []
            } else {
                return acceptedRanges(xmasRange: xmasRange, rules: workflowMap[destination]!.rules ,workflowMap: workflowMap)
            }
        }
    }
    
    func updateRange(r: XmasRange, ruleRating: Substring, cond: Character, num: Int) -> (XmasRange, XmasRange) {
        let newRange = switch ruleRating {
        case "x":
            if cond == "<" {
                (XmasRange(x: Range(lower: r.x.lower, upper: num-1), m: r.m, a: r.a, s: r.s),
                 XmasRange(x: Range(lower: num, upper: r.x.upper), m: r.m, a: r.a, s: r.s))
            } else {
                (XmasRange(x: Range(lower: num + 1, upper: r.x.upper), m: r.m, a: r.a, s: r.s),
                 XmasRange(x: Range(lower: r.x.lower, upper: num), m: r.m, a: r.a, s: r.s))
            }
        case "m":
            if cond == "<" {
                (XmasRange(x: r.x, m: Range(lower: r.m.lower, upper: num - 1), a: r.a, s: r.s),
                 XmasRange(x: r.x, m: Range(lower: num, upper: r.m.upper), a: r.a, s: r.s))
            } else {
                (XmasRange(x: r.x, m: Range(lower: num + 1, upper: r.m.upper), a: r.a, s: r.s),
                 XmasRange(x: r.x, m: Range(lower: r.m.lower, upper: num), a: r.a, s: r.s))
            }
        case "a":
            if cond == "<" {
                (XmasRange(x: r.x, m: r.m, a: Range(lower: r.a.lower, upper: num - 1), s: r.s),
                 XmasRange(x: r.x, m: r.m, a: Range(lower: num, upper: r.a.upper), s: r.s))
            } else {
                (XmasRange(x: r.x, m: r.m, a: Range(lower: num + 1, upper: r.a.upper), s: r.s),
                 XmasRange(x: r.x, m: r.m, a: Range(lower: r.a.lower, upper: num), s: r.s))
            }
        case "s":
            if cond == "<" {
                (XmasRange(x: r.x, m: r.m, a: r.a, s: Range(lower: r.s.lower, upper: num - 1)),
                 XmasRange(x: r.x, m: r.m, a: r.a, s: Range(lower: num, upper: r.s.upper)))
            } else {
                (XmasRange(x: r.x, m: r.m, a: r.a, s: Range(lower: num + 1, upper: r.s.upper)),
                 XmasRange(x: r.x, m: r.m, a: r.a, s: Range(lower: r.s.lower, upper: num)))
            }
        default:
            fatalError("Unknown type")
        }
        
        return newRange
    }
    
    struct XmasRange {
        let x: Range
        let m: Range
        let a: Range
        let s: Range
        
        func getCombinations() -> Int {
            (x.upper - x.lower + 1) *
            (m.upper - m.lower + 1) *
            (a.upper - a.lower + 1) *
            (s.upper - s.lower + 1)
        }
        
        func contained(otherX: Int, otherM: Int, otherA: Int, otherS: Int) -> Bool {
            otherX >= x.lower && otherX <= x.upper &&
            otherM >= m.lower && otherM <= m.upper &&
            otherA >= a.lower && otherA <= a.upper &&
            otherS >= s.lower && otherS <= s.upper
        }
    }
    
    struct Range {
        let lower: Int
        let upper: Int
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
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Reject])], [try! Day19Test.workflowParser.parse("in{R}")])
        XCTAssertEqual(Rule.Condition("b", "<", 1, "qz"), try! Day19Test.ruleParser.parse("b<1:qz"))
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Condition("b", "<", 1, "qz")])], [try! Day19Test.workflowParser.parse("in{b<1:qz}")])
        
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Condition("b", "<", 1, "qz"),Rule.Condition("c", ">", 2, "qq"), Rule.Accept])],
                       [try! Day19Test.workflowParser.parse("in{b<1:qz,c>2:qq,A}")])
        
        XCTAssertEqual([Workflow(name: "in", rules: [Rule.Condition("a", "<", 2006, "qkq"), Rule.Condition("m", ">", 2090, "A"), Rule.Destination("rfg")])],
                       [try! Day19Test.workflowParser.parse("in{a<2006:qkq,m>2090:A,rfg}")])
    }
    
    func testRatingParser() {
        XCTAssertEqual([Rating(x: 787, m: 2655, a: 1222, s: 2876)], [try! Day19Test.ratingParser.parse("{x=787,m=2655,a=1222,s=2876}")])
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
    }.map{ Rating(x: $0.0, m: $0.1, a: $0.2, s: $0.3) }
    
    static let workflowParser = Parse(input: Substring.self) {
        Prefix{ $0 != "{" }
        Skip { "{" }
        Many {
            ruleParser
        } separator: {
            ","
        }
        Skip { "}" }
    }.map{ Workflow.init(name: $0.0, rules: $0.1) }
    
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
