//
//  UIView+Extensions.swift
//  InteractiveContentView
//
//  Created by Naresh Bhadresha on 15/03/21.
//  Copyright © 2021 Naresh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setRandomBackgroundColor() {
        self.backgroundColor = UIColor.getRandomUIColor()
    }
    
    func setTouchDownShadow() {
        self.setShadow(color: UIColor.black, offset: CGSize.init(width: 0, height: 0), opacity: 0.5, radius: 3.0)
    }
    
    func setTouchUpShadow() {
        self.setShadow(color: UIColor.black, offset: CGSize.init(width: 0, height: 0), opacity: 0.5, radius: 5.0)
    }
    
    func setShadow(color: UIColor,
                   offset: CGSize,
                   opacity: Float,
                   radius: Float
                   ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = CGFloat(radius)
    }
    
    ///Sets rounded corners with provided radius. If radius is not provided, makes the view rounded by using height/2 as the radius
    func setRoundedCorners(with radius: CGFloat? = nil) {
        if let r = radius {
            self.layer.cornerRadius = r
        }
        else {
            self.layer.cornerRadius = self.frame.height/2
        }
    }
}
