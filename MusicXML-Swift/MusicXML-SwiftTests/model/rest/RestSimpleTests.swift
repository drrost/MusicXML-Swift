//
//  RestSimpleTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 2/10/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class RestSimpleTests: XCTestCase {

    var parser: MusicXMLParser!

    override func setUp() {
        parser = MusicXMLParser()
    }

    func testFileContainsTwoWholeRests() {
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

    func testFileContainsOneHalfRest() {
        guard let score = parser.parse("rest-half.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .half)
        XCTAssertTrue(measure.notes[0].isRest == true)
    }

    func testFileContainsOneQuarterRest() {
        guard let score = parser.parse("rest-quarter.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .quarter)
        XCTAssertTrue(measure.notes[0].isRest == true)
    }

    func testFileContainsOneEighthRest() {
        guard let score = parser.parse("rest-eighth.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .eighth)
        XCTAssertTrue(measure.notes[0].isRest == true)
    }

}
