//
//  NetworkManager.swift
//  Forecast
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    
    private var serverReach: Reachability?
    var serverAvailable = false
    
    func reachabilityChanged(note: NSNotification) {
        let reach = note.object as! Reachability
        serverAvailable = !(reach.currentReachabilityStatus().rawValue == NotReachable.rawValue)
        if serverAvailable {
            print("Changed: Server Available")
        } else {
            print("Changed: Server Not Available")
        }
    }
    
    override init() {
        super.init()
        print("Starting Network Manager")
        let dataManager = DataManager.sharedInstance
        serverReach = Reachability(hostName: dataManager.baseURLString)
        serverReach?.startNotifier()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
    }
    

}
