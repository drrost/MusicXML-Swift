//
//  NoteTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 2/9/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class NoteTests: XCTestCase {

    func testDurationComesTypeIfTypeIsAbsentInXml() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("rest-whole.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .whole)
    }

    func testNoteIsWholeWhenDuration4Divisions1() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("note-whole-division-1.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .whole)
    }

    func testNoteIsHalfWhenDuration4Divisions2() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("note-whole-division-2.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(measure.notes[0].type == .half)
    }

}
