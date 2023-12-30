//
// Created by Graham Berks on 15/12/2021.
//

import Foundation

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int

    init(_ xVal: Int, _ yVal: Int) {
        x = xVal
        y = yVal
    }
    
    func neightboursInVerticalAndHorizontal() -> Set<Point> {
        [
            Point(x, y - 1),
            Point(x, y + 1),
            Point(x - 1, y),
            Point(x + 1, y),
        ]
    }
    
    func neighbours() -> Set<Point> {
        [
            Point(x - 1, y - 1),
            Point(x, y - 1),
            Point(x + 1, y - 1),
            Point(x - 1, y),
            Point(x + 1, y),
            Point(x - 1, y + 1),
            Point(x, y + 1),
            Point(x + 1, y + 1)
        ]
    }
}

struct LineSegment {
    let start: Point
    let end: Point
}

struct Point3D: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    init(_ xVal: Int, _ yVal: Int, _ zVal: Int) {
        x = xVal
        y = yVal
        z = zVal
    }
    
    func ignoreZPlane() -> Point {
        Point(x, y)
    }
}

struct DoublePoint: Equatable, Hashable {
    let x: Double
    let y: Double
    
    init(_ xVal: Double, _ yVal: Double) {
        x = xVal
        y = yVal
    }
    
    init(_ xVal: Int, _ yVal: Int) {
        x = Double(xVal)
        y = Double(yVal)
    }
}

struct DoublePoint3D: Equatable, Hashable {
    let x: Double
    let y: Double
    let z: Double
    
    init(_ xVal: Double, _ yVal: Double, _ zVal: Double) {
        x = xVal
        y = yVal
        z = zVal
    }
    
    init(_ xVal: Int, _ yVal: Int, _ zVal: Int) {
        x = Double(xVal)
        y = Double(yVal)
        z = Double(zVal)
    }
    
    func ignoreZPlane() -> DoublePoint {
        DoublePoint(x, y)
    }
}

func getGrid(s: String) -> Dictionary<Point, Int> {
    let data = s.lines
    var entries: [(Point, Int)] = []

    for y in 0..<data.count {
        for x in 0..<data[y].count {
            entries.append( (Point(x,y), Int(String(data[y][x]))!) )
        }
    }

    return Dictionary<Point, Int>(uniqueKeysWithValues: entries)
}

func overlapOfLineSegments(of segment1: LineSegment, and segment2: LineSegment) -> LineSegment? {
    // Sort the points to make the algorithm easier to understand
    let sortedPoints = [segment1.start, segment1.end, segment2.start, segment2.end].sorted {
        if $0.x == $1.x {
            $0.y < $1.y
        } else {
            $0.x < $1.x
        }
    }

    // Check for overlap
    if max(segment1.start.x, segment2.start.x) <= min(segment1.end.x, segment2.end.x) &&
       max(segment1.start.y, segment2.start.y) <= min(segment1.end.y, segment2.end.y) {
        return LineSegment(start: sortedPoints[1], end: sortedPoints[2])
    }

    return nil
}


func doLineSegmentsIntersect(_ segment1: LineSegment, _ segment2: LineSegment) -> Bool {
    // Helper function to check if q lies on line segment 'pr'
    func onSegment(p: Point, q: Point, r: Point) -> Bool {
        return q.x <= max(p.x, r.x) && q.x >= min(p.x, r.x) &&
               q.y <= max(p.y, r.y) && q.y >= min(p.y, r.y)
    }

    // Helper function to find the orientation of the ordered triplet (p, q, r)
    // Returns:
    // 0 --> p, q, and r are colinear
    // 1 --> Clockwise
    // 2 --> Counterclockwise
    func orientation(p: Point, q: Point, r: Point) -> Int {
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
