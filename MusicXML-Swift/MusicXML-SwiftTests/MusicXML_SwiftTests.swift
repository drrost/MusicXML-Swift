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

    func testExample() {
        let parser = MusicXMLParser()
        guard let score = parser.parse("HelloWorld.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Music")
        XCTAssertTrue(score.part.id == "P1")
    }

}
