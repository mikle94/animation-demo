//
//  UIView+Ext.swift
//  Umzugscoach
//
//  Created by Mikle Kusmenko on 10/26/17.
//  Copyright © 2017 mk. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func animateAlpha(alpha: CGFloat = 1.0, duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
}
