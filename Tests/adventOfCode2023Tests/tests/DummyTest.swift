//
//  DummyTest.swift
//  adventOfCode2021Tests
//
//  Created by Graham Berks on 28/11/2021.
//

import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class DummyTest: XCTestCase {

    func testDummy() {
        let data = dummyData.lines.map { try! Int.parser().parse($0) }
        print(data)
        assertThat(data == [12,32])
    }
    
    func testGPT() {
        func rotateArray90Degrees(_ inputArray: [[Character]]) -> [[Character]] {
            let numRows = inputArray.count
            let numCols = inputArray[0].count
            
            var rotatedArray = Array(repeating: Array(repeating: Character(" "), count: numRows), count: numCols)
            
            for i in 0..<numRows {
                for j in 0..<numCols {
                    rotatedArray[j][numRows - 1 - i] = inputArray[i][j]
                }
            }
            
            return rotatedArray
        }

        // Example input array
        let inputArray: [[Character]] = [
            ["A", "B", "C"],
            ["D", "E", "F"],
            ["G", "H", "I"]
        ]

        let rotatedArray = rotateArray90Degrees(inputArray)

        for row in rotatedArray {
            let rowString = String(row)
            print(rowString)
        }
    }
}


