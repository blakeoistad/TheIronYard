//
//  ViewController.swift
//  Swift2Xcode7iOS9
//
//  Created by Blake Oistad on 10/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    private var colorArray = ["Red", "Green", "Blue", "Yellow", "Purple", "Black", "White"]
    private var colorNameArray = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.blackColor(), UIColor.lightGrayColor()]
    @IBOutlet weak private var ratingStackView  :UIStackView!
    @IBOutlet weak private var attribLabel      :UILabel!
    
    
    //MARK: - Generated Interfaces              .h is an interface file, .m is an implementation file
    //Navigate > Jump to Generated Interface
    
    
    //MARK: - Defer
    
    private func aMethodThatDefers() {
        print("Step 2")
        defer {                                 //this says to print this info in defer brackets after the rest of this method is run
            print("Defer could be used for clean up?")
        }
        print("Step 3")
    }
    
    
    //MARK: - Key Commands
    
    func runThisKeyCommand() {
        print("Using the Keyboardt")
    }
    
    func createKeyCommand() {
        print("Create key")
        let keyCommand = UIKeyCommand(input: "s", modifierFlags: .Control, action: "runThisKeyCommand")
        addKeyCommand(keyCommand)
    }
    
    //MARK: - .map Function
    
    private func dotMapExamples() {
        let numbersArray = [1,2,3,4,5,6,7,17,22,345]
        print("Original: + \(numbersArray)")
        let squareArray = numbersArray.map {$0 * $0}
        print("Square: + \(squareArray)")
        let dArray = numbersArray.map {"\($0) dollars"}
        print("Dollars: + \(dArray)")
        print("Post: \(numbersArray)")
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .OrdinalStyle
        let ordArray = numbersArray.map {formatter.stringFromNumber($0)!}
        print("Ord: + \(ordArray)")
    }

    
    
    //MARK: - Attributed String Methods
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return colorArray[row]
//    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attrib = [NSForegroundColorAttributeName : colorNameArray[row]]
        return NSAttributedString(string: colorArray[row], attributes: attrib)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorArray.count
    }
    
    
    
    
    
    private func createAttributedString() {
        let myMutableString = NSMutableAttributedString()
        
        let font1 = UIFont(name: "Avenir-Light", size: 14.0)
        let attrib1 = [NSFontAttributeName : font1!]
        
        let introAttribString = NSAttributedString(string: "My name is ", attributes: attrib1)
        
        let font2 = UIFont(name: "AvenirNext-Bold", size: 16.0)
        
        let nameAttribString = NSAttributedString(string: "Blake", attributes: [NSFontAttributeName : font2!, NSForegroundColorAttributeName : UIColor.redColor()])
        
        let closeAttribString = NSAttributedString(string: ", and don't forget it!", attributes: attrib1)
        
        myMutableString.appendAttributedString(introAttribString)
        myMutableString.appendAttributedString(nameAttribString)
        myMutableString.appendAttributedString(closeAttribString)
        
        attribLabel.attributedText = myMutableString
        
        
    }
    
    
    
    //MARK: - Stack View Methods
    
        @IBAction private func addButtonPressed(sender: UIButton) {
        print("Add")
        let starImageView = UIImageView(image: UIImage(named: "Star"))
        starImageView.contentMode = UIViewContentMode.ScaleAspectFit                     //allows you to in code set aspect ratio
        let starCount = ratingStackView.arrangedSubviews.count
        ratingStackView.insertArrangedSubview(starImageView, atIndex: starCount - 1)
        UIView.animateWithDuration(0.25) { () -> Void in
            self.ratingStackView.layoutIfNeeded()
        }
    }
    
        @IBAction private func removeButtonPressed(sender: UIButton) {
        print("Remove")
        //need count of how many items we have
        let starCount = ratingStackView.arrangedSubviews.count
        if starCount > 0 {
            let starToRemove = ratingStackView.arrangedSubviews[starCount - 2]
            ratingStackView.removeArrangedSubview(starToRemove)         //removes the images but not the data
            starToRemove.removeFromSuperview()                          //removes completely from memory
            UIView.animateWithDuration(0.25) { () -> Void in
                self.ratingStackView.layoutIfNeeded()
            }
        }
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAttributedString()
        print("Step 1")
        aMethodThatDefers()
        print("Step 4")
        createKeyCommand()
        dotMapExamples()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

