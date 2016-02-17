//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Blake Oistad on 10/26/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK - AUTO LAYOUT
    //set display to be view with label inside, base all other buttons on the size (equal width and height) to clear button
    
    
    
    
    
    //MARK - Initial Variables
    
    var currentOperator = ""
    var left = 0.0
    var right = 0.0
    var result = 0.0
    
    //var firstVal = Float()
    //var secondVal = Float()
    
    @IBOutlet weak var displayLabel : UILabel!
    
    
    //MARK - Value Button Methods
    
    @IBAction func valueButtonPressed(valueEntered: UIButton) {
        print("\(valueEntered.titleLabel!.text!) Button Pressed")
        displayLabel.text = displayLabel.text! + valueEntered.titleLabel!.text!
        if currentOperator == "" {
            left = Double(displayLabel.text!)!
        } else {
            right = Double(displayLabel.text!)!
        }
    }

    
    //MARK - Operator Methods
    
    @IBAction func operatorButtonPressed(operationEntered: UIButton) {
        print("\(operationEntered.titleLabel!.text!)")
        displayLabel.text = ""
        currentOperator = operationEntered.titleLabel!.text!
    }
    

    
    @IBAction func clearButtonPressed(sender: UIButton) {
        print("Clear Button Pressed")
        left = 0
        right = 0
        result = 0
        currentOperator = ""
        displayLabel.text = ""
    }
    
    @IBAction func decimalButtonPressed(sender: UIButton) {
        print("Decimal Button Pressed")
        displayLabel.text! += "."
    }
    
    @IBAction func equalsButtonPressed(sender: UIButton) {
        if currentOperator == "+" {
            result = left + right
            left = result
            displayLabel.text = String(format: "%.2f", result)
        } else if currentOperator == "-" {
            result = left - right
            left = result
            displayLabel.text = String(format: "%.2f", result)
        } else if currentOperator == "x" {
            result = left * right
            left = result
            displayLabel.text = String(format: "%.2f", result)
        } else if currentOperator == "/" {
            result = left / right
            left = result
            displayLabel.text = String(format: "%.2f", result)
        }
    }
    

    
    
    //MARK - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentOperator = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

