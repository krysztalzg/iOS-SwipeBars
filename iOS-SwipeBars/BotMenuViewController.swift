//
//  BotMenuViewController.swift
//  iOS-SwipeBars
//
//  Created by Kamil Szczepański on 13/02/2017.
//  Copyright © 2017 Kamil Szczepański. All rights reserved.
//

import UIKit


protocol BotMenuDelegate {
    func botMenuItemSelectedAtIndex(_ index: Int)
}

class BotMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var tblMenuOptions: UITableView!
    var count = 0
    
    var arrayMenuOptions = [String]()
    var btnMenu : UIButton!
    var delegate: SlideMenuDelegate?
    var swipeBtn: UIButton!
    
    //MARK: View controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OperationQueue().addOperation {
            self.persistTest()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        swipeBtn = BaseViewController._view.viewWithTag(100) as! UIButton
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(BotMenuViewController.swipeDown(recognizer:)))
        recognizer.direction = .down
        swipeBtn.addGestureRecognizer(recognizer)
        
        updateArrayMenuOptions()
    }
    
    //MARK: Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BotCell")!
        let lblTitle : UILabel = cell.contentView.viewWithTag(100) as! UILabel
        
        lblTitle.text = arrayMenuOptions[indexPath.row]
        
        return cell
    }
    
    //MARK: Bottom menu
    
    func updateArrayMenuOptions(){
        arrayMenuOptions = ["Option1", "Option2"]
        
        tblMenuOptions.reloadData()
    }
    
    func swipeDown( recognizer: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height,
                                     width: UIScreen.main.bounds.size.width, height: self.tblMenuOptions.bounds.size.height)
            
            self.swipeBtn.setTitle("/\\", for: .normal)
            self.swipeBtn.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.swipeBtn.bounds.size.height,
                                         width: UIScreen.main.bounds.size.width, height: self.swipeBtn.bounds.size.height)

            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }
    
    
    //MARK: View persistency test
    func persistTest() {
        while true {
            count += 1
            OperationQueue.main.addOperation {
                self.testLabel.text = String(describing: self.count)
            }
            sleep(1)
        }
    }

}
