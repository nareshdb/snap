//
//  UIColor+Extensions.swift
//  InteractiveContentView
//
//  Created by Naresh Bhadresha on 15/03/21.
//  Copyright © 2021 Naresh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func getRandomUIColor() -> UIColor {
        return UIColor.init(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1.0)
    }
}
