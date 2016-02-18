//
//  WatchQuotesConnectivity.swift
//  InspireMe
//
//  Created by Blake Oistad on 11/19/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation
import WatchConnectivity

final class WatchConnectivityController: NSObject, WCSessionDelegate {
    
    static let sharedInstance = WatchConnectivityController()
    
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
        print(applicationContext)
        
        guard let quotesDicts = applicationContext["quotes"] as? [QuoteDict] else {
            fatalError("bad data send from phone \(applicationContext)")
        }
        
        QuotesManager.sharedManager.quotes = QuotesParser.quotesFromDictionaries(quotesDicts)
    }

    
}