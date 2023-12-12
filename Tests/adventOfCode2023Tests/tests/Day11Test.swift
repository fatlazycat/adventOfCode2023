import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day11Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = day11DummyData.lines
        assertThat(getSumOfShortestPaths(data) == 374)
    }
    
    func testPart1(){
        let data = day11Data.lines
        XCTAssertEqual(getSumOfShortestPaths(data), 9974721)
    }
    
    func getSumOfShortestPaths(_ data: [String]) -> Int {
        let grid = createGrid(from: data)
        let expandedUniverse = expandUniverse(grid)
        let galaxies = getGalaxies(expandedUniverse)
        let galaxyPairs = getAllPairs(from: galaxies)
        let shortestPaths = galaxyPairs.map{ getShortestPath($0, $1) }
        return shortestPaths.reduce(0, +)
    }
    
    func getShortestPath(_ a: Point, _ b: Point) -> Int {
        let maxX = max(a.x, b.x)
        let minX = min(a.x, b.x)
        let maxY = max(a.y, b.y)
        let minY = min(a.y, b.y)
        
        return (maxX - minX) + (maxY - minY)
    }
    
    func getAllPairs<T>(from array: [T]) -> [(T, T)] {
        return array.enumerated().flatMap { (index, element) in
            array.dropFirst(index + 1).map { (element, $0) }
        }
    }
    
    func testExpandUniverse(){
        let data = day11DummyData.lines
        let grid = createGrid(from: data)
        let expandedUniverse = expandUniverse(grid)
        assertThat(expandedUniverse == createGrid(from: day11ExpandedUniverse.lines))
    }
    
    func getGalaxies(_ data: [[Character]]) -> [Point] {
        var result = [Point]()
        
        (0..<data.count).forEach({row in
            (0..<data[row].count).forEach({col in
                if data[row][col] == "#" {
                    result.append(Point(col, row))
                }
            })
        })
        
        return result
    }
    
    
    func expandUniverse(_ data: [[Character]]) -> [[Character]] {
        var expandedUniverse = [[Character]]()
        
        (0..<data.count).forEach({ row in
            if data[row].filter({ $0 == "#" }).count == 0 {
                expandedUniverse.append(data[row])
                expandedUniverse.append(data[row])
            } else {
                expandedUniverse.append(data[row])
            }
        })
        
        var offset = 0
        let width = expandedUniverse[0].count
        let height = expandedUniverse.count
        
        (0..<width).forEach({ originalCol in
            let col = originalCol + offset
            
            if (0..<height).filter({ row in expandedUniverse[row][col] == "#" }).count == 0 {
                (0..<height).forEach({ row in
                    expandedUniverse[row].insert(".", at: col)
                })
                offset += 1
            }
        })
        
        return expandedUniverse
    }
    
    func createGrid(from strings: [String]) -> [[Character]] {
        var grid = [[Character]]()
        
        for string in strings {
            let row = Array(string)
            grid.append(row)
        }
        
        return grid
    }
}
