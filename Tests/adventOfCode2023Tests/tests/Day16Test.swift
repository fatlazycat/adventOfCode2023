import XCTest
import Parsing
import Foundation

class Day16Test : XCTestCase {

    func testPart1Dummy(){
        let rawData = Day16Test.loadData(filename: "Day16DummyData")
        print(rawData)
//        let rawData = try! Day15Test.parser.parse(day15DummyData)
        
//        XCTAssertEqual(1320, rawData.map{ getNumber($0) }.reduce(0, +))
    }

    
    static func loadData(filename: String) -> String {
        
        let bundle = Bundle.module
        
        let dataURL = bundle.url(
        forResource: filename,
        withExtension: "txt")

      guard let dataURL,
        let data = try? String(contentsOf: dataURL, encoding: .utf8)
      else {
        fatalError("Couldn't find file '\(filename).txt' in the 'dataFiles' directory.")
      }

      // On Windows, line separators may be CRLF. Converting to LF so that \n
      // works for string parsing.
      return data.replacingOccurrences(of: "\r", with: "")
    }
}
