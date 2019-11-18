//
//  ViewController.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/5/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreView: ScorePartwiseView!

    let parser = MusicXMLParser()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scorePartwise = parser.parse("note-whole-division-1.xml") {
            scoreView.update(scorePartwise)
        }
    }

}
