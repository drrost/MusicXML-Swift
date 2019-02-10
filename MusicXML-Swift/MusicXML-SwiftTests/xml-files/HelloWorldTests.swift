//
//  HelloWorldTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 1/14/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class HelloWorldTests: XCTestCase {

    func testHelloWorldDocument() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("HelloWorld.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        let measure = score.part.measures[0]
        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Music")
        XCTAssertTrue(score.part.id == "P1")
        XCTAssertTrue(measure.number == 1)

        XCTAssertTrue(measure.attributes?.divisions == 1)
        XCTAssertTrue(measure.attributes?.key.fifths == 0)
        XCTAssertTrue(measure.attributes?.time.beats == "4")
        XCTAssertTrue(measure.attributes?.time.beatType == "4")
        XCTAssertTrue(measure.attributes?.clef?.sign == .G)
        XCTAssertTrue(measure.attributes?.clef?.line == 2)

        XCTAssertTrue(measure.notes.count == 1)
        let note = measure.notes[0]
        XCTAssertTrue(note.pitch.step == .C)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 4)
        XCTAssertTrue(note.type == .whole)
    }
}
