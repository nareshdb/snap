//
//  SnapView.swift
//  InteractiveContentView
//
//  Created by Naresh Bhadresha on 15/03/21.
//  Copyright © 2021 Naresh. All rights reserved.
//

import Foundation
import UIKit

class SnapView: UIView {
    
    var tapGesture: UIGestureRecognizer!
    var panGesture: UIPanGestureRecognizer!
    var animator: UIDynamicAnimator!
    var snapBehavior: UISnapBehavior?
    weak var animatorReferenceView: UIView? = nil
    var animatorReferencePosition: CGPoint!
    
    init(frame: CGRect, referenceView: UIView, snapCenter: CGPoint? = nil) {
        
        super.init(frame: frame)
        
        //Giving a fresh color to stubbornView everytime
        self.setRandomBackgroundColor()
        
        //Adding rounded corners, easy for the eyes
        self.setRoundedCorners(with: 4)
        
        //Incase the background color matches stubbornviews color, we will need a shadow
        self.setTouchUpShadow()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.stubbornViewDragged(_:)))
        self.addGestureRecognizer(panGesture)
        
        tapGesture = UIGestureRecognizer(target: self, action: #selector(self.stubbornViewDragged(_:)))
        self.addGestureRecognizer(tapGesture)
        
        self.animator = UIDynamicAnimator(referenceView: referenceView)
        self.animatorReferenceView = referenceView
        
        if let point = snapCenter {
            self.animatorReferencePosition = point
        }
        else {
            self.animatorReferencePosition = self.center
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func stubbornViewDragged(_ sender: UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            self.superview?.bringSubviewToFront(self)
            self.setTouchDownShadow()
        case .cancelled, .ended:
            DispatchQueue.main.async {
                self.setTouchUpShadow()
                if let snapBehavior = self.snapBehavior {
                    self.animator.removeBehavior(snapBehavior)
                }
                let snapBehavior = UISnapBehavior.init(item: self, snapTo: self.animatorReferencePosition)
                self.animator.addBehavior(snapBehavior)
                self.snapBehavior = snapBehavior
            }
        case .changed:
            DispatchQueue.main.async {
                let translation = sender.translation(in: self)
                self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: self)
            }
        default:
            DispatchQueue.main.async {
                self.setTouchUpShadow()
            }
            break
        }
    }

}
