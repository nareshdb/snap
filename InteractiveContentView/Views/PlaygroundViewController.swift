//
//  PlaygroundViewController.swift
//  InteractiveContentView
//
//  Created by Naresh Bhadresha on 15/03/21.
//  Copyright © 2021 Naresh. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {

    ///The snap views which doesn't like moving away from its place and moves backs to the original position when dragged
    var snaps: [SnapView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addSnaps()
    }
    
    func addSnaps() {
        
        DispatchQueue.main.async {
            
            let numberOfSnaps = Int.random(in: 1...5)
            
            self.snaps = (1...numberOfSnaps).map { (index) -> SnapView in
                
                let snapSize = self.view.frame.size.applying(CGAffineTransform
                    .init(scaleX: CGFloat.random(in: 0.15...0.25), y: CGFloat.random(in: 0.15...0.25)))
                let snapOrigin = self.view.center.applying(CGAffineTransform.init(scaleX: CGFloat.random(in: 0.5...1.5), y: CGFloat.random(in: 0.5...1.5)))
                return SnapView(frame: CGRect.init(origin: snapOrigin, size: snapSize), referenceView: self.view)
            }
            
            for _view in self.snaps {
                self.view.addSubview(_view)
            }
        }
    }
    
}

