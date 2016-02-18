//
//  ViewController.swift
//  AppTesting
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var myTextField: UITextField!

    
    //MARK: - Interactivity Methods
    
    @IBAction func button1Pressed(sender: UIButton) {
        myTextField.text! += "1"
    }
    
    @IBAction func button2Pressed(sender: UIButton) {
        myTextField.text! += "2"
    }
    
    @IBAction func button3Pressed(sender: UIButton) {
        myTextField.text! += "3"
    }
    
    
    //MARK: - Core Methods
    
    func squared(number: Int) ->Int {
        return number * number
    }
    
    func stringContainsString(sourceString: String, searchString: String) -> Bool {
        if sourceString.lowercaseString.rangeOfString(searchString.lowercaseString) != nil {
            print("Exists")
            return true
        } else {
            return false
        }
    }
    
    
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

