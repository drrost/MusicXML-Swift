//
//  RestHalfTests_Snapshots.swift
//  MusicXML-SwiftTests-Snapshots
//
//  Created by Rostyslav Druzhchenko on 27.11.2019.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

@testable import MusicXML_Swift

import FBSnapshotTestCase

class RestHalfTests_Snapshots: FBSnapshotTestCase {

        override func setUp() {
            super.setUp()

            fileNameOptions = .screenSize
//            recordMode = true
        }

        func testSimpleView() {
            // Given
            let homeVC: HomeViewController = .create("Main")
            _ = homeVC.view

            // When
            homeVC.update("rest-half.xml")

            // Then
            FBSnapshotVerifyViewController(homeVC)
        }
}
