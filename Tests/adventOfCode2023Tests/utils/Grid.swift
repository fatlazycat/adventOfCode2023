//
// Created by Graham Berks on 15/12/2021.
//

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int

    init(_ xVal: Int, _ yVal: Int) {
        x = xVal
        y = yVal
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