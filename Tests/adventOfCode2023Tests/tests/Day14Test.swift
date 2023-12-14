import XCTest
import Parsing
import Foundation

class Day14Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = parseData(lines: day14DummyData.lines)
        let titltedGrid = tiltNorth(data: data)
        
        XCTAssertEqual(136, sumLoad(grid: titltedGrid))
    }
    
    func testPart1(){
        let data = parseData(lines: day14Data.lines)
        let titltedGrid = tiltNorth(data: data)
        
        XCTAssertEqual(108614, sumLoad(grid: titltedGrid))
    }
    
    func testTiltNorth() {
        let data = parseData(lines: day14DummyData.lines)
        let expected = parseData(lines: day14TiltedNorth.lines)
        
        XCTAssertEqual(expected, tiltNorth(data: data))
    }
    
    func sumLoad(grid: [[Character]]) -> Int {
        var result = 0
        var size = grid.count
        
        (0..<grid.count).forEach({ row in
            (0..<(grid[row].count)).forEach({ col in
                if grid[row][col] == "O" {
                    result += size
                }
            })
            
            size -= 1
        })
        
        return result
    }
    
    func tiltNorth(data: [[Character]]) -> [[Character]] {
        var grid = data
        var stop = false
        var changeInRound = false
        
        while !stop {
            (0..<(grid.count-1)).forEach({ row in
                (0..<(grid[row].count)).forEach({ col in
                    if grid[row][col] == "." && grid[row+1][col] == "O" {
                        grid[row][col] = "O"
                        grid[row+1][col] = "."
                        changeInRound = true
                    }
                })
            })
            
            if !changeInRound {
                stop = true
            }
            
            changeInRound = false
        }
        
        return grid
    }
    
    func parseData(lines: [String]) -> [[Character]] {
        lines.map{ $0.toCharArray() }
    }
    
    func printCharacterGrid(_ grid: [[Character]]) {
        for row in grid {
            let rowString = String(row)
            print(rowString)
        }
    }
}
