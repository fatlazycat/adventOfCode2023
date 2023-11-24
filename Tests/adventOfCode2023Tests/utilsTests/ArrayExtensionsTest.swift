
import Foundation

import XCTest

class YourTestCase: XCTestCase {

    func testFromTupleOptional() {
        // Arrange
        let tuple = ("1", "2")

        // Act
        let result = Array<String>.fromTupleOptional(tuple)

        // Assert
        XCTAssertEqual(result, ["1", "2"], "Result should match expected array")
    }
}
