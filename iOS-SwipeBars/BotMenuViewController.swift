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
    var swipeBtn: SwipeButton!
    
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
        
        swipeBtn = BaseViewController._view.viewWithTag(100) as! SwipeButton
        swipeBtn.bottomVC = self
        swipeBtn.swipeDownPrep()
        
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
