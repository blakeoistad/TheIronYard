//
//  AppDelegate.swift
//  ParseLogin
//
//  Created by Blake Oistad on 11/4/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Parse.setApplicationId("ZAi5zfv7fzsCglPCPD1QGRnadlvlFNRQh42ugDXo",
            clientKey: "AXmuILMmvLNoFaGjWKJQ2MIE6bwC3ZmXXTufnrV4")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        return true
    }

}

