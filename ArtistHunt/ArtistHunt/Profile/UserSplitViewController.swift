//
//  UserSplitViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 20/01/2019.
//  Copyright © 2019 Leunes Media. All rights reserved.
//

import UIKit

class UserSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
