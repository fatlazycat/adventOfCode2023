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

struct Point3D: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    init(_ xVal: Int, _ yVal: Int, _ zVal: Int) {
        x = xVal
        y = yVal
        z = zVal
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
