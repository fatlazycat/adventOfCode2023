import XCTest
import Parsing
import Foundation

class Day24Test : XCTestCase {
    
    func testPart1Dummy() {
        let data = day24DummyData.map{ try! parser.parse($0) }
        XCTAssertEqual(2, part1(data: data, min: 7.0, max: 27.0))
    }
    
    func testPart1() {
        let data = day24Data.map{ try! parser.parse($0) }
        XCTAssertEqual(16502, part1(data: data, min: 200000000000000.0, max: 400000000000000.0))
    }
    
    func part1(data: [Hailstone3D], min: Double, max: Double) -> Int {
        let dataInZPlane = data.map{ $0.ignoreZPlane() }
        let allPairs = dataInZPlane.allPairings()
        let solutions = allPairs.filter{ crossingPoint($0.0, $0.1, min: min, max: max) }
        return solutions.count
    }
    
    func filterCrossing(point: DoublePoint, min: Double, max: Double) -> Bool {
        point.x >= min && point.x <= max && point.y >= min && point.y <= max
    }
    
    func crossingPoint(_ one: Hailstone, _ two: Hailstone, min: Double, max: Double) -> Bool {
        if one.a * two.b == one.b * two.a {
            return false
        }
        
        let x = (one.c * two.b - two.c * one.b) / (one.a * two.b - two.a * one.b)
        let y = (two.c * one.a - one.c * two.a) / (one.a * two.b - two.a * one.b)
       
        return
                (x-one.point.x) * one.velocity.x >= 0 &&
                (y-one.point.y) * one.velocity.y >= 0 &&
                (x-two.point.x) * two.velocity.x >= 0 &&
                (y-two.point.y) * two.velocity.y >= 0 &&
                x >= min && x <= max &&
                y >= min && y <= max
    }

    
    struct Hailstone: Equatable, Hashable {
        let point: DoublePoint
        let velocity: DoublePoint
        
        var a: Double {
            velocity.y
        }
        
        var b: Double {
            -1 * velocity.x
        }
        
        var c: Double {
            velocity.y * point.x - velocity.x * point.y
        }
    }
    
    struct Hailstone3D: Equatable, Hashable {
        let point: DoublePoint3D
        let velocity: DoublePoint3D
        
        func ignoreZPlane() -> Hailstone {
            Hailstone(point: point.ignoreZPlane(), velocity: velocity.ignoreZPlane())
        }
    }
    
    let parser = Parse(input: Substring.self) {
        Int.parser()
        ","
        Whitespace()
        Int.parser()
        ","
        Whitespace()
        Int.parser()
        Whitespace()
        "@"
        Whitespace()
        Int.parser()
        ","
        Whitespace()
        Int.parser()
        ","
        Whitespace()
        Int.parser()
    }.map{ Hailstone3D(point: DoublePoint3D($0.0, $0.1, $0.2), velocity: DoublePoint3D($0.3, $0.4, $0.5)) }
}
