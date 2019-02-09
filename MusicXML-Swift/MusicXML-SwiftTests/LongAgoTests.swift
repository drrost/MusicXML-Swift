//
//  LongAgoTests.swift
//  MusicXML-SwiftTests
//
//  Created by Rostyslav Druzhchenko on 1/14/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import XCTest

@testable import MusicXML_Swift

class LongAgoTests: XCTestCase {

    func testLongAgo() {

        let parser = MusicXMLParser()
        guard let score = parser.parse("05_long_ago.xml") else {
            XCTFail("`ScorePartwise object should not be nil")
            return
        }

        XCTAssertTrue(score.partList.scorePart.partName.partNameText == "Clarinet in Bb")
        XCTAssertTrue(score.part.id == "P1")
        XCTAssertTrue(score.part.measures.count == 24)
    }
}
