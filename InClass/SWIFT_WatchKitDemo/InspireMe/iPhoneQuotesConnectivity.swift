//
//  iPhoneQuotesConnectivity.swift
//  InspireMe
//
//  Created by Blake Oistad on 11/19/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import WatchConnectivity

final class ConnectivityController: NSObject, WCSessionDelegate{

    static let sharedInstance = ConnectivityController()
    
    func setUpWatchConnectivity() {
        if WCSession.isSupported() {
            print("supported session!")
            let session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        print("received data")
    }
    
    func sendData() {
        let session = WCSession.defaultSession()
        if session.watchAppInstalled {
            do {
                let quoteDicts = QuotesSerializer.dictionariesFromQuotes(QuotesManager.sharedManager.quotes)
                try session.updateApplicationContext(["quotes" : quoteDicts])
            } catch {
                print("failed to send info to watch")
            }
        } else {
            print("no watch app installed bruh")
        }
    }

    
}
