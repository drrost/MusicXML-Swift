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

        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Piano")
        XCTAssertTrue(score.part.id == "P1")
        XCTAssertTrue(score.part.measures.count == 2)

        // Check measure 1
        var measure = score.part.measures[0]
        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Piano")
        XCTAssertTrue(score.part.id == "P1")
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
    }

}
