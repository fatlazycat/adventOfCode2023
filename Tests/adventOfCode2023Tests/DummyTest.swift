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

}
