//
//  SwipeButton.swift
//  iOS-SwipeBars
//
//  Created by Kamil Szczepański on 22/02/2017.
//  Copyright © 2017 Kamil Szczepański. All rights reserved.
//

import UIKit

class SwipeButton: UIButton {
    var currentVC: UIViewController?
    var bottomVC: BotMenuViewController = AppDelegate.viewHook

    func swipeUpPrep() {
        removeActions()
        
        self.addTarget(self, action: #selector(self.swipeUp(recognize:)), for: UIControlEvents.touchUpInside)
        
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeUp(recognize:)))
        recognizer.direction = .up
        self.addGestureRecognizer(recognizer)
    }
    
    func swipeDownPrep() {
        removeActions()

        self.addTarget(self, action: #selector(self.swipeDown(recognize:)), for: UIControlEvents.touchUpInside)
        
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDown(recognize:)))
        recognizer.direction = .down
        self.addGestureRecognizer(recognizer)
    }
    
    fileprivate func removeActions() {
        self.gestureRecognizers?.forEach(self.removeGestureRecognizer)
        self.removeTarget(nil, action: nil, for: UIControlEvents.allEvents)
    }
    
    
    @objc fileprivate func swipeUp(recognize: UISwipeGestureRecognizer) {
        self.bottomVC.removeFromParentViewController()
        swipeDownPrep()
        
        self.currentVC!.view.addSubview(self.bottomVC.view)
        self.currentVC!.addChildViewController(self.bottomVC)
        self.bottomVC.view.layoutIfNeeded()
        
        self.bottomVC.view.frame=CGRect(x: 0 , y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: self.bottomVC.tblMenuOptions.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.bottomVC.view.frame=CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.bottomVC.tblMenuOptions.bounds.size.height,
                                     width: UIScreen.main.bounds.size.width, height: self.bottomVC.tblMenuOptions.bounds.size.height);
            
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.bottomVC.tblMenuOptions.bounds.size.height - self.bounds.size.height,
                                         width: UIScreen.main.bounds.size.width, height: self.bounds.size.height);
            self.setTitle("\\/", for: .normal)
        }, completion:nil)
    }
    
    @objc fileprivate func swipeDown(recognize: UISwipeGestureRecognizer) {
        swipeUpPrep()
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.bottomVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height,
                                     width: UIScreen.main.bounds.size.width, height: self.bottomVC.tblMenuOptions.bounds.size.height)
            
            self.setTitle("/\\", for: .normal)
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.bounds.size.height,
                                         width: UIScreen.main.bounds.size.width, height: self.bounds.size.height)
        }, completion: { (finished) -> Void in
            self.bottomVC.view.removeFromSuperview()
            self.bottomVC.removeFromParentViewController()
        })
    }

}
