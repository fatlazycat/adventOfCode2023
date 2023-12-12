import XCTest
import Parsing
import Foundation
import SwiftHamcrest

class Day11Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = day11DummyData.lines
        XCTAssertEqual(getSumOfShortestPaths(data, multiple: 2), 374)
    }
    
    func testPart1(){
        let data = day11Data.lines
        XCTAssertEqual(getSumOfShortestPaths(data, multiple: 2), 9974721)
    }
    
    func testPart2Dummy(){
        let data = day11DummyData.lines
        XCTAssertEqual(getSumOfShortestPaths(data, multiple: 10), 1030)
    }
    
    func testPart2DummyAgain(){
        let data = day11DummyData.lines
        XCTAssertEqual(getSumOfShortestPaths(data, multiple: 100), 8410)
    }
    
    func testPart2(){
        let data = day11Data.lines
        XCTAssertEqual(getSumOfShortestPaths(data, multiple: 1000000), 702770569197)
    }
    
    func testExpandedUniverse() {
        let data = day11DummyData.lines
        let grid = createGrid(from: data)
        XCTAssertEqual(getExpandedUniverseRows(grid), [3, 7])
        XCTAssertEqual(getExpandedUniverseCols(grid), [2, 5, 8])
    }
    
    func getSumOfShortestPaths(_ data: [String], multiple: Int) -> Int {
        let galaxy = createGrid(from: data)
        let galaxies = getGalaxies(galaxy)
        let galaxyPairs = getAllPairs(from: galaxies)
        let expandedRows = getExpandedUniverseRows(galaxy)
        let expandedCols = getExpandedUniverseCols(galaxy)
        let shortestPaths = galaxyPairs.map{ getShortestPath($0, $1, expandedRows, expandedCols, multiple: multiple) }
        return shortestPaths.reduce(0, +)
    }
    
    func getShortestPath(_ a: Point, _ b: Point, _ rows: [Int], _ cols: [Int], multiple: Int) -> Int {
        let maxX = max(a.x, b.x)
        let minX = min(a.x, b.x)
        let maxY = max(a.y, b.y)
        let minY = min(a.y, b.y)
        let expandedCols = cols.filter({ minX...maxX ~= $0 }).count
        let expandedRows = rows.filter({ minY...maxY ~= $0}).count
        
        return (maxX - minX) + (maxY - minY) + (expandedCols + expandedRows) * (multiple-1)
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
    
    func getExpandedUniverseRows(_ data: [[Character]]) -> [Int] {
        (0..<data.count).map{ row in
            data[row].filter({ $0 == "#" }).count == 0 ? row : nil
        }.compactMap{ $0 }
    }
    
    func getExpandedUniverseCols(_ data: [[Character]]) -> [Int] {
        let width = data[0].count
        let height = data.count
        
        return (0..<width).compactMap { col in
            (0..<height).filter({ row in data[row][col] == "#" }).count == 0 ? col : nil
        }
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
