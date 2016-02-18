//
//  InterfaceController.swift
//  InspireMe+WatchKit Extension
//
//  Created by Blake Oistad on 11/19/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    //MARK:- Properties
    
    @IBOutlet var quoteLabel: WKInterfaceLabel!
    @IBOutlet var authorLabel: WKInterfaceLabel!
    
    @IBAction func nextQuoteButton() {
        populateQuote()
    }
    
    func populateQuote() {
        let quote = QuotesManager.sharedManager.nextQuote()
        let quoteDisplayObject = QuoteDisplayObject(quote: quote)
        
        quoteLabel.setText(quoteDisplayObject.quoteText)
        authorLabel.setText(quoteDisplayObject.authorText)
    }
    
    
    //MARK:- Life Cycle Methods
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        populateQuote()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
