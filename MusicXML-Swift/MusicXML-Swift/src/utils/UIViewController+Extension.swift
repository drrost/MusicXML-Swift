//
//  UIViewController+Extension.swift
//  MusicXML-Swift
//
//  Created by Rostyslav Druzhchenko on 18.11.2019.
//  Copyright © 2019 Rostyslav Druzhchenko. All rights reserved.
//

import UIKit

extension UIViewController {

    class func create<T>(_ storyboardName: String, _ identifier: String = "\(T.self)") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
