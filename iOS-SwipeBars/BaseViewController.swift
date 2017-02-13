//
//  BaseViewController.swift
//  iOS-SwipeBars
//
//  Created by Kamil Szczepański on 13/02/2017.
//  Copyright © 2017 Kamil Szczepański. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, SlideMenuDelegate {
    public let swipeBtn = UIButton()
    static var _view : UIView!
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BaseViewController._view = self.view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if topViewController.restorationIdentifier! != destViewController.restorationIdentifier!{
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int) {
        switch(index){
        case 0:
            self.openViewControllerBasedOnIdentifier("MainView")
        case 1:
            self.openViewControllerBasedOnIdentifier("TestView")
        default:
            break
        }
    }
    
    func swipeUp(recognize: UISwipeGestureRecognizer) {
        let menuVC = AppDelegate.viewHook
        menuVC.delegate = self
        menuVC.removeFromParentViewController()
        
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        menuVC.view.frame=CGRect(x: 0 , y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: menuVC.tblMenuOptions.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: UIScreen.main.bounds.size.height - menuVC.tblMenuOptions.bounds.size.height,
                                     width: UIScreen.main.bounds.size.width, height: menuVC.tblMenuOptions.bounds.size.height);
            
            self.swipeBtn.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - menuVC.tblMenuOptions.bounds.size.height - self.swipeBtn.bounds.size.height,
                                         width: UIScreen.main.bounds.size.width, height: self.swipeBtn.bounds.size.height);
            self.swipeBtn.setTitle("\\/", for: .normal)
        }, completion:nil)
    }
    
    func addSlideMenuButton() {
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    func addBottomMenuButton() {
        swipeBtn.backgroundColor = UIColor.lightGray
        swipeBtn.setTitle("/\\", for: .normal)
        swipeBtn.tag = 100
        swipeBtn.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 50, width: UIScreen.main.bounds.size.width, height: 50)
        
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(BaseViewController.swipeUp(recognize:)))
        recognizer.direction = .up
        swipeBtn.addGestureRecognizer(recognizer)
        
        self.view.addSubview(swipeBtn)
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : SlideMenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "SlideMenuView") as! SlideMenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self

        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - menuVC.tblMenuOptions.bounds.size.width, y: 0, width: menuVC.tblMenuOptions.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: menuVC.tblMenuOptions.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }

}
