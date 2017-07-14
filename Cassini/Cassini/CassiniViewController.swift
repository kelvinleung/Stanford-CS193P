//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Kelvin Leung on 14/07/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""] {
            if let imageVC = (segue.destination.contents as? ImageViewController) {
                imageVC.imageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
}

//  add a var to check if the VC is a UINavigationController
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
