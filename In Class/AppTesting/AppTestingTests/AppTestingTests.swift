//
//  AppTestingTests.swift
//  AppTestingTests
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import XCTest
@testable import AppTesting

class AppTestingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testContainsWor() {
        XCTAssertTrue(ViewController().stringContainsString("Hello World!", searchString: "Wor"), "Hello World contains Wor")
    }
    
    func testContainswor() {
        XCTAssertTrue(ViewController().stringContainsString("Hello World!", searchString: "wor"), "Hello World contains wor")
    }
    
    func genericUselessTest() {
        XCTAssertTrue(true, "Its True")
    }
    
    
    func testSquareOf2() {
        XCTAssertEqual(ViewController().squared(2), 4, "2 squared equals 4")
    }
    
    func testSquareOf18() {
        XCTAssertEqual(ViewController().squared(18), 324, "18 squared equals 324")
    }
    
    func testSquareOf0() {
        XCTAssertEqual(ViewController().squared(0), 0, "0 squared equals 0")
    }
    
    func testSquareOfN5() {
        XCTAssertEqual(ViewController().squared(-5), 25, "-5 quared equals 25")
    }
}
