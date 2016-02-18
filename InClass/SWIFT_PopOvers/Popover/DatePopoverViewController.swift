//
//  DatePopoverViewController.swift
//  Popover
//
//  Created by Blake Oistad on 11/10/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class DatePopoverViewController: UIViewController {

    
    var currentDate :NSDate!
    @IBOutlet var myDatePicker :UIDatePicker!
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        currentDate = sender.date
        print("Chose: \(currentDate)")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        myDatePicker.date = currentDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
