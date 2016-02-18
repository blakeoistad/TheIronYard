//
//  NetworkManager.swift
//  SwiftTune
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    static let sharedInstance = NetworkManager()            //creates the singleton, prevents multiples of this class accidentally being created
    
    
    //remember to import reachability.h in bridge header
    private var serverReach: Reachability?
    var serverAvailable = false
    
    func reachabilityChanged(note: NSNotification) {        //any time reachability changes, we get a notification, takes the object from notification as reachabilility and so on
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus().rawValue == NotReachable.rawValue)            //is the reachability status not reachable? if it is, server unavailable
        if serverAvailable {
            print("Changed: Server Available")
        } else {
            print("Changed: Server Not Available")
        }
    }
    
    override init() {               //by default, the object has an init that just instantiates the object, must override to do custom stuff
        super.init()
        print("Starting Network Manager")
        let dataManager = DataManager.sharedInstance
        serverReach = Reachability(hostName: dataManager.baseURLString)
        serverReach?.startNotifier()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
    }
    
    
}
