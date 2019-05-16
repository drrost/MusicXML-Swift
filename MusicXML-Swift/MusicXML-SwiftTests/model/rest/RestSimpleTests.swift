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
        checkRest(from: "rest-whole.xml", .whole)
    }

    func testFileContainsOneHalfRest() {
        checkRest(from: "rest-half.xml", .half)
    }

    func testFileContainsOneQuarterRest() {
        checkRest(from: "rest-quarter.xml", .quarter)
    }

    func testFileContainsOneEighthRest() {
        checkRest(from: "rest-eighth.xml", .eighth)
    }

    func testFileContainsOne16thRest() {
        checkRest(from: "rest-16th.xml", ._16th)
    }

    func testFileContainsOne32ndRest() {
        checkRest(from: "rest-32nd.xml", ._32nd)
    }

    func testFileContainsOne64thRest() {
        checkRest(from: "rest-64th.xml", ._64th)
    }

    func testFileContainsOne128thRest() {
        checkRest(from: "rest-128th.xml", ._128th)
    }

    func testFileContainsOne256thRest() {
        checkRest(from: "rest-256th.xml", ._256th)
    }

    // MARK: - Private

    fileprivate func checkRest(from fileName: String, _ noteType: NoteType) {
        guard let score = parser.parse(fileName) else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == noteType)
        XCTAssertTrue(measure.notes[0].isRest == true)
    }
}
