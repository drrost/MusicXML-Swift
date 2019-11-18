//
//  HomeViewController.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 1/5/19.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scoreView: ScorePartwiseView!

    let parser = MusicXMLParser()

    override func viewDidLoad() {
        super.viewDidLoad()

        update("rest-32nd.xml")
    }

    func update(_ fileName: String) {
        if let scorePartwise = parser.parse(fileName) {
            scoreView.update(scorePartwise)
        }
    }

}
