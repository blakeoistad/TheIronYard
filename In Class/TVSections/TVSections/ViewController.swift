//
//  ViewController.swift
//  TVSections
//
//  Created by Blake Oistad on 11/11/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var displayTableView: UITableView!
    let metroStationsArray = ["Archives", "Bethesda", "Capitol South", "Clarendon", "Court House", "Crystal City", "Dupont Circle", "Federal Triangle", "Foggy Bottom", "Rockville", "Shady Grove"]
    let bikeStationsArray = ["20th & Bell St", "18th & Eads St.", "20th & Crystal Dr", "15th & Crystal Dr", "S Joyce & Army Navy Dr", "12th & Army Navy Dr", "27th & Crystal Dr", "S Glebe & Potomac Ave"]
    
    
    
    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2                                                        //two sections, one for each array of data
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return metroStationsArray.count
        } else if section == 1 {
            return bikeStationsArray.count
        }
        return 0                                //if not one of those two, return zero
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)     //decalre this basic cell universally but if you wanted custom cells, they would go in the ifs
    
        if indexPath.section == 0 {
            cell.textLabel!.text = metroStationsArray[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel!.text = bikeStationsArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Metro Stations"
        } else if section == 1 {
            return "Bike Stations"
        }
        return "Unknown"
    }
    
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Count: \(metroStationsArray.count)"
        } else if section == 1 {
            return "Count: \(bikeStationsArray.count)"
        }
        return "Unknown"
    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        //allows for customizing what is seen within the header sections
//    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

