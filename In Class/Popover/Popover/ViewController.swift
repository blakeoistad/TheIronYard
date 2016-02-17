//
//  ViewController.swift
//  Popover
//
//  Created by Blake Oistad on 11/10/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    
    
    //MARK: - Popover Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "datePopoverSegue" {
            let destController = segue.destinationViewController as! DatePopoverViewController
            destController.currentDate = NSDate().dateByAddingTimeInterval(-24*60*60)//this gets us yesterday
            print("sent: \(destController.currentDate)")
            destController.popoverPresentationController!.delegate = self
            
        }
    }
    
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        print("Did Dismiss")
        let dateController = popoverPresentationController.presentedViewController as! DatePopoverViewController
        let recievedDate = dateController.currentDate
        print("Recieved: \(recievedDate)")
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None                //prevents it from defaulting to modal presentation style on phone as opposed to being a pop over
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

