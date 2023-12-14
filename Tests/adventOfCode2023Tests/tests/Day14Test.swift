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
    
    func testPart2Dummy(){
        let data = parseData(lines: day14DummyData.lines)
        let finalGrid = gridAfterNumberOfTries(grid: data, tries: 1000000000)
        
        XCTAssertEqual(64, sumLoad(grid: finalGrid))
    }
    
// slow running
//    func testPart2(){
//        let data = parseData(lines: day14Data.lines)
//        let finalGrid = gridAfterNumberOfTries(grid: data, tries: 1000000000)
//        
//        XCTAssertEqual(96447, sumLoad(grid: finalGrid))
//    }
    
    func testOneCycle() {
        let data = parseData(lines: day14DummyData.lines)
        let tilttedGridNorth = tiltNorth(data: data)
        let tiltedGridWest = tiltNorth(data: rotateArray90Degrees(tilttedGridNorth))
        let tiltedGridSouth = tiltNorth(data: rotateArray90Degrees(tiltedGridWest))
        let tiltedGridEast = tiltNorth(data: rotateArray90Degrees(tiltedGridSouth))
        let cycle = rotateArray90Degrees(tiltedGridEast)
        
        XCTAssertEqual(parseData(lines: day14AfterOneCycle.lines), cycle)
    }
    
    func testTiltNorth() {
        let data = parseData(lines: day14DummyData.lines)
        let expected = parseData(lines: day14TiltedNorth.lines)
        
        XCTAssertEqual(expected, tiltNorth(data: data))
    }
    
    func gridAfterNumberOfTries(grid: [[Character]], tries: Int) -> [[Character]] {
        let cycleRepeatAfter = findCycleRepeat(grid: grid)
        
        if let (startNumber, repeatNumber) = cycleRepeatAfter {
            let toProcess = tries - startNumber
            let cyclesLeft = toProcess % (repeatNumber-startNumber)
            var currentGrid = grid
            
            // cycle to repeat then do cycles left
            (0..<repeatNumber).forEach({ _ in
                currentGrid = performCycle(grid: currentGrid)
            })
            (0..<cyclesLeft).forEach({ _ in
               currentGrid = performCycle(grid: currentGrid)
           })
            
            return currentGrid
        }
        
        return []
    }
    
    func findCycleRepeat(grid: [[Character]]) -> (Int, Int)? {
        var grids = [0 : grid]
        var number = 0
        var currentGrid = grid
        var stop = false
        var result: (Int, Int)? = nil
        
        while !stop {
            currentGrid = performCycle(grid: currentGrid)
            number += 1
            
            if let matchedGrid = grids.first(where: { $0.value == currentGrid }) {
                // found match
                
                result = (matchedGrid.key, number)
                stop = true
            }
            
            grids[number] = currentGrid
        }
        
        return result
    }
    
    func performCycle(grid: [[Character]]) -> [[Character]] {
        let tilttedGridNorth = tiltNorth(data: grid)
        let tiltedGridWest = tiltNorth(data: rotateArray90Degrees(tilttedGridNorth))
        let tiltedGridSouth = tiltNorth(data: rotateArray90Degrees(tiltedGridWest))
        let tiltedGridEast = tiltNorth(data: rotateArray90Degrees(tiltedGridSouth))
        return rotateArray90Degrees(tiltedGridEast)
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
}
