//
//  QuotesDisplayObject.swift
//  InspireMe
//
//  Created by Blake Oistad on 11/19/15.
//  Copyright © 2015 WeddingWire. All rights reserved.
//

import Foundation

final class QuoteDisplayObject {
    let authorText: String
    let quoteText: String
    
    init(quote: Quote) {
        quoteText = quote.text
        authorText = QuoteDisplayObject.formatAuthorText(quote.author)
    }
    
    static func formatAuthorText(authorText: String) -> String {
        return "-- \(authorText)"
    }
}
