//
//  PlaygroundViewController.swift
//  InteractiveContentView
//
//  Created by Naresh Bhadresha on 15/03/21.
//  Copyright © 2021 Naresh. All rights reserved.
//

import UIKit

class PlaygroundViewController: UIViewController {

    ///The stubborn views which doesn't like moving away from its place and moves backs to the original position when dragged
    var stubbornViews: [SnapView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addSnaps()
    }
    
    func addSnaps() {
        
        DispatchQueue.main.async {
            let snapSize = self.view.frame.size.applying(CGAffineTransform.init(scaleX: 0.2, y: 0.2))
            
            let snap1Origin = self.view.center.applying(CGAffineTransform.init(scaleX: 0.5, y: 1))
            let snap1 = SnapView(frame: CGRect.init(origin: snap1Origin, size: snapSize), referenceView: self.view)
            
            let snap2Origin = self.view.center.applying(CGAffineTransform.init(scaleX: 1, y: 0.5))
            let snap2 =  SnapView(frame: CGRect.init(origin: snap2Origin, size: snapSize),
                                  referenceView: self.view)
            
            self.stubbornViews = [snap1, snap2]
            for _view in self.stubbornViews {
                self.view.addSubview(_view)
            }
        }
    }
    
}

