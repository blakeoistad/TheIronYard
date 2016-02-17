//
//  ViewController.swift
//  Maintain_Tennant
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    @IBOutlet var repairsTableView: UITableView!
    @IBOutlet var completionSegmentedControl: UISegmentedControl!
    
    

    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.repairsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RepairTableViewCell
        let currentRepair = dataManager.repairsArray[indexPath.row]
        cell.repairTitleLabel!.text = currentRepair.repairTitle!
        cell.repairDescLabel!.text = currentRepair.repairDesc!
        if currentRepair.date_submitted!.characters.count != 0 {
            cell.repairSubmittedDateLabel!.text = currentRepair.date_submitted!
        } else {
            cell.repairSubmittedDateLabel!.text = "No data"
        }


        
        return cell
    }
    
    
    
    
    //MARK: - Interactivity Methods
    
    
    @IBAction func segmentedControlChanged(sender: UISegmentedControl) {
        switch completionSegmentedControl.selectedSegmentIndex {
        case 0:
            print("Show Completed")

            break
        case 1:
            print("Show Incomplete")
            break
        default: break
        }
    }
    
    
    
    
    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
        if dataManager.repairsArray.count != 0 {
            print("Current Count: \(dataManager.repairsArray.count)")
            print("Last Repair: \(dataManager.repairsArray.last!.repairDesc!)")
            repairsTableView.reloadData()
        } else {
            print("Nothing currently in the array")
        }
        
    }
    
    func newDataReceived() {
        print("Got new data")
        repairsTableView.reloadData()
    }
    
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        dataManager.getRepairsFromServer()
//        dataManager.tempAddRecord()
        print("Current Record Count: \(dataManager.repairsArray.count)")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

