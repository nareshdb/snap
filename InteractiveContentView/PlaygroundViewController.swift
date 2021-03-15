//
//  PlaygroundViewController.swift
//  InteractiveContentView
//
//  Created by Naresh Bhadresha on 15/03/21.
//  Copyright © 2021 Naresh. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {

    ///The stubborn view which doesn't like moving away from its place and moves backs to the original position when no draggeds
    var stubbornView: UIView!
    var stubbornViewsPanGesture: UIPanGestureRecognizer!
    var stubbornViewAnimator: UIDynamicAnimator!
    var stubbornViewSnapBehavior: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUIOnDidLoad()
    }
    
    func setupUIOnDidLoad() {
        
        self.stubbornView = UIView.init(frame: CGRect.init(origin: self.view.center, size: self.view.frame.size.applying(CGAffineTransform.init(scaleX: 0.2, y: 0.2))))
        self.view.addSubview(stubbornView)
        
        //Giving a fresh color to stubbornView everytime
        self.stubbornView.setRandomBackgroundColor()
        
        //Adding rounded corners, easy for the eyes
        self.stubbornView.setRoundedCorners(with: 4)
        
        //Incase the background color matches stubbornviews color, we will need a shadow
        self.stubbornView.setTouchUpShadow()
        
        stubbornViewsPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.stubbornViewDragged(_:)))
        self.stubbornView.addGestureRecognizer(stubbornViewsPanGesture)
        
        self.stubbornViewAnimator = UIDynamicAnimator(referenceView: view)
        
    }
    
    @objc func stubbornViewDragged(_ sender: UIPanGestureRecognizer){
        switch sender.state {
        case .cancelled, .ended:
            DispatchQueue.main.async {
                self.stubbornView.setTouchUpShadow()
                if let snapBehavior = self.stubbornViewSnapBehavior {
                    self.stubbornViewAnimator.removeBehavior(snapBehavior)
                }
                let snapBehavior = UISnapBehavior.init(item: self.stubbornView, snapTo: self.view.center)
                self.stubbornViewAnimator.addBehavior(snapBehavior)
                self.stubbornViewSnapBehavior = snapBehavior
            }
        case .changed:
            DispatchQueue.main.async {
                let translation = sender.translation(in: self.view)
                self.stubbornView.center = CGPoint(x: self.stubbornView.center.x + translation.x, y: self.stubbornView.center.y + translation.y)
                sender.setTranslation(CGPoint.zero, in: self.view)
            }
        default:
            DispatchQueue.main.async {
                self.stubbornView.setTouchUpShadow()
            }
            break
        }
    }
}

