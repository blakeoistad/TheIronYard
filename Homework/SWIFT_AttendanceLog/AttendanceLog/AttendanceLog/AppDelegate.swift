//
//  AppDelegate.swift
//  AttendanceLog
//
//  Created by Blake Oistad on 11/12/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let beaconsManager = BeaconsManager()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        beaconsManager.checkForLocationAuthorization()
        beaconsManager.beaconManager.delegate = beaconsManager.self
        
        Parse.setApplicationId("pnoGKHAnhol9ceRP9EBg6QmsTq16nrMtZ0ak70JT",
            clientKey: "SSC2Omtez0JhkodrFcfoAARhW3tnb2dUw6Lg5Ymf")
        
        return true
    }

}

