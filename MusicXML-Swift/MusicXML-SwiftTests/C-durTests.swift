//
//  C-durTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 1/14/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class C_durTests: XCTestCase {

    func testCdurGama() {

        let parser = MusicXMLParser()
        guard let score = parser.parse("C-dur.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Piano")
        XCTAssertTrue(score.part.id == "P1")
        XCTAssertTrue(score.part.measures.count == 2)

        // Check measure 1
        var measure = score.part.measures[0]
        XCTAssertTrue(measure.number == 1)

        XCTAssertTrue(measure.attributes?.divisions == 1)
        XCTAssertTrue(measure.attributes?.key.fifths == 0)
        XCTAssertTrue(measure.attributes?.time.beats == "4")
        XCTAssertTrue(measure.attributes?.time.beatType == "4")
        XCTAssertTrue(measure.attributes?.clef?.sign == .G)
        XCTAssertTrue(measure.attributes?.clef?.line == 2)

        XCTAssertTrue(measure.notes.count == 4)
        var note = measure.notes[0]
        XCTAssertTrue(note.pitch.step == .C)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        note = measure.notes[1]
        XCTAssertTrue(note.pitch.step == .D)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        note = measure.notes[2]
        XCTAssertTrue(note.pitch.step == .E)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        note = measure.notes[3]
        XCTAssertTrue(note.pitch.step == .F)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        // Check measure 2
        measure = score.part.measures[1]
        XCTAssertTrue(measure.number == 2)

        XCTAssertNil(measure.attributes)

        XCTAssertTrue(measure.notes.count == 4)
        note = measure.notes[0]
        XCTAssertTrue(note.pitch.step == .G)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        note = measure.notes[1]
        XCTAssertTrue(note.pitch.step == .A)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        note = measure.notes[2]
        XCTAssertTrue(note.pitch.step == .B)
        XCTAssertTrue(note.pitch.octave == 4)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)

        note = measure.notes[3]
        XCTAssertTrue(note.pitch.step == .C)
        XCTAssertTrue(note.pitch.octave == 5)
        XCTAssertTrue(note.duration == 1)
        XCTAssertTrue(note.voice == "1")
        XCTAssertTrue(note.type == .quarter)
    }
}
