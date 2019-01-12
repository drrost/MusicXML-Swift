//
//  MusicXML_SwiftTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 1/5/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest
@testable import MusicXML_Swift

class MusicXMLSwiftTests: XCTestCase {

    override func setUp() {
    }

    func testHelloWorldDocument() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("HelloWorld.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Music")
        XCTAssertTrue(score.part.id == "P1")
        XCTAssertTrue(score.part.measure.number == 1)

        XCTAssertTrue(score.part.measure.attributes.divisions == 1)
        XCTAssertTrue(score.part.measure.attributes.key.fifths == 0)
        XCTAssertTrue(score.part.measure.attributes.time.beats == "4")
        XCTAssertTrue(score.part.measure.attributes.time.beatType == "4")
        XCTAssertTrue(score.part.measure.attributes.clef?.sign == .G)
        XCTAssertTrue(score.part.measure.attributes.clef?.line == 2)

        XCTAssertTrue(score.part.measure.note.pitch.step == .C)
        XCTAssertTrue(score.part.measure.note.pitch.octave == 4)
        XCTAssertTrue(score.part.measure.note.duration == 4)
        XCTAssertTrue(score.part.measure.note.type == .whole)
    }

    func testHelloWorldRepresentation() {

        let parser = MusicXMLParser()
        guard let score = parser.parse("HelloWorld.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        // TODO: Check generated image
    }

    func testCdurGama() {

        let parser = MusicXMLParser()
        guard let score = parser.parse("C-dur.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

    }

}
