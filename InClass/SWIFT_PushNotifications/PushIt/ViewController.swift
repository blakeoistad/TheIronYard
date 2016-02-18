//
//  ViewController.swift
//  PushIt
//
//  Created by Blake Oistad on 11/17/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK:- Interactivity Methods
    
    func getTopOfNextMinute() -> NSDate {
        let cal = NSCalendar.currentCalendar()
        let now: NSDateComponents = cal.components([.Hour, .Minute], fromDate: NSDate())       //gets components of current date in hours and minutes
        print("Firing at \(now.hour):\(now.minute + 1)")
        return cal.dateBySettingHour(now.hour, minute: now.minute + 1, second: 0, ofDate: NSDate(), options: NSCalendarOptions())!       //gets us top of next minute from current time
    }
    
    @IBAction func scheduleNotification(sender: UIButton) {
        let notification = UILocalNotification()
        notification.fireDate = getTopOfNextMinute()
        notification.alertBody = "This is a normal notification, bruh!"
        notification.soundName = "sound.aif"            //default dingbeep
        notification.category = "DEFAULT_CATEGORY"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    @IBAction func scheduleTextNotification(sender: UIButton) {
        let notification = UILocalNotification()
        notification.fireDate = getTopOfNextMinute()
        notification.alertBody = "This is a text notification, bruh!"
        notification.alertAction = "Cooliolio"
        notification.soundName = "sound.aif"            //default dingbeep
        notification.category = "TEXT_CATEGORY"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    @IBAction func scheduleButtonNotification(sender: UIButton) {
        let notification = UILocalNotification()
        notification.fireDate = getTopOfNextMinute()
        notification.alertBody = "This is a button notification, bruh!"
        notification.alertAction = "Cooliolio"
        notification.soundName = "sound.aif"            //default dingbeep
        notification.category = "BUTTON_CATEGORY"
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

