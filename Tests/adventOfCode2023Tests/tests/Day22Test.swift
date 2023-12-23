import XCTest
import Parsing
import Foundation

class Day22Test : XCTestCase {
    
    func testPart1Dummy(){
        let bricks = try! parser.parse(day22DummyData)
        let allCombos = bricks.getAllUniquePairs()
        let crossingBricks = allCombos.filter({ doLineSegmentsIntersect($0.0, $0.1)})
        crossingBricks.forEach({ b in
            print("Brick \(b.0.name) to Brick \(b.1.name)")
        })
    }
    
//    Brick A is the only brick supporting bricks B and C.
//    Brick B is one of two bricks supporting brick D and brick E.
//    Brick C is the other brick supporting brick D and brick E.
//    Brick D supports brick F.
//    Brick E also supports brick F.
//    Brick F supports brick G.
//    Brick G isn't supporting any bricks.
    
    struct Brick: Equatable, Hashable {
        let start: Point3D
        let end: Point3D
        let name: Substring
    }
    
    func doLineSegmentsIntersect(_ segment1: Brick, _ segment2: Brick) -> Bool {
        // Helper function to check if q lies on line segment 'pr'
        func onSegment(p: Point3D, q: Point3D, r: Point3D) -> Bool {
            return q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) &&
                   q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y)
        }

        // Helper function to find the orientation of the ordered triplet (p, q, r)
        // Returns:
        // 0 --> p, q, and r are colinear
        // 1 --> Clockwise
        // 2 --> Counterclockwise
        func orientation(p: Point3D, q: Point3D, r: Point3D) -> Int {
            let val = (q.y - p.y) * (r.x - q.x) - (q.x - p.x) * (r.y - q.y)
            if val == 0 { return 0 }  // colinear
            return (val > 0) ? 1 : 2  // clock or counterclockwise
        }

        let p1 = segment1.start
        let q1 = segment1.end
        let p2 = segment2.start
        let q2 = segment2.end

        // Find the four orientations needed for general and special cases
        let o1 = orientation(p: p1, q: q1, r: p2)
        let o2 = orientation(p: p1, q: q1, r: q2)
        let o3 = orientation(p: p2, q: q2, r: p1)
        let o4 = orientation(p: p2, q: q2, r: q1)

        // General case
        if o1 != o2 && o3 != o4 {
            return true
        }

        // Special cases
        // p1, q1, and p2 are colinear and p2 lies on segment p1q1
        if o1 == 0 && onSegment(p: p1, q: p2, r: q1) { return true }

        // p1, q1, and q2 are colinear and q2 lies on segment p1q1
        if o2 == 0 && onSegment(p: p1, q: q2, r: q1) { return true }

        // p2, q2, and p1 are colinear and p1 lies on segment p2q2
        if o3 == 0 && onSegment(p: p2, q: p1, r: q2) { return true }

        // p2, q2, and q1 are colinear and q1 lies on segment p2q2
        if o4 == 0 && onSegment(p: p2, q: q1, r: q2) { return true }

        // Doesn't fall in any of the above cases
        return false
    }
    
    let parser = Parse(input: Substring.self) {
        Many {
            Day22Test.rowParser
        } separator: {
            Whitespace(1, .vertical)
        }
    }
    
    static let rowParser = Parse(input: Substring.self) {
        Int.parser()
        ","
        Int.parser()
        ","
        Int.parser()
        "~"
        Int.parser()
        ","
        Int.parser()
        ","
        Int.parser()
        ","
        Prefix{ $0 != "," }
        ","
    }.map{ Brick(start: Point3D($0.0, $0.1, $0.2), end: Point3D($0.3, $0.4, $0.5), name: $0.6) }
}
