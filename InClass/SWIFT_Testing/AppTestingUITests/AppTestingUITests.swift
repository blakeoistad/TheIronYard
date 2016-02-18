//
//  AppTestingUITests.swift
//  AppTestingUITests
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import XCTest

class AppTestingUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
              continueAfterFailure = false
               XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUI1() {
        
        let app = XCUIApplication()
        let button1Button = app.buttons["Button 1"]
        button1Button.tap()
        
        let button2Button = app.buttons["Button 2"]
        button2Button.tap()
        
        let button3Button = app.buttons["Button 3"]
        button3Button.tap()
        button2Button.tap()
        button3Button.tap()
        
        let textField = app.otherElements.containingType(.Button, identifier:"Button 1").childrenMatchingType(.TextField).element
        textField.tap()
        textField.typeText("456")
        button1Button.tap()
        XCTAssertEqual(textField.textViews, "123234561", "testing UI")
    }
    
}
