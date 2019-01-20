//
//  CircularImageView.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 20/01/2019.
//  Copyright © 2019 Leunes Media. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = false;
    }
}
