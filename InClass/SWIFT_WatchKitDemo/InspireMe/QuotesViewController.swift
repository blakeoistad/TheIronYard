//
//  ViewController.swift
//  InspireMe
//
//  Created by Arvind Subramanian on 11/17/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import UIKit


class QuotesViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateQuote()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func nextQuote(sender: AnyObject) {
        populateQuote()
    }
    
    private func populateQuote() {
        let quote = QuotesManager.sharedManager.nextQuote()
        let quoteDisplay = QuoteDisplayObject(quote: quote)
        
        quoteLabel.text = quoteDisplay.quoteText
        authorLabel.text = quoteDisplay.authorText
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
}

