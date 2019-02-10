//
//  RestWholeTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 2/10/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class RestWholeTests: XCTestCase {

    func testFileContainsTwoWholeRests() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("rest-whole.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        measureHasOneWholeRest(score.part.measures[0])
        measureHasOneWholeRest(score.part.measures[1])
    }

    fileprivate func measureHasOneWholeRest(_ measure: Measure) {
        XCTAssertTrue(measure.notes[0].type == .whole)
        XCTAssertTrue(measure.notes[0].isRest == true)
    }

}
