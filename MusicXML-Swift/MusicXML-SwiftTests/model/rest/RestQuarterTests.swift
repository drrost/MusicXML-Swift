//
//  RestQuarterTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 2/10/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class RestQuarterTests: XCTestCase {

    func testFileContainsOneHalfRest() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("rest-quarter.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .quarter)
        XCTAssertTrue(measure.notes[0].isRest == true)
    }

}
