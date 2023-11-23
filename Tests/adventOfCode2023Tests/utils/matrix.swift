//
//  matrix.swift
//  adventOfCode2021
//
//  Created by Graham Berks on 04/12/2021.
//

import Foundation

func rotateGrid90DegreesCounterClockwise(grid: [[Int]]) -> [[Int]] {
    let gridSize = grid.count
    var result = [[Int]](repeating: [Int](repeating: 0, count: gridSize), count: gridSize)

    for x in 0...gridSize-1 {
        for y in 0...gridSize-1 {
            result[y][(gridSize - 1) - x] = grid[x][y]
        }
    }

    return result
}
