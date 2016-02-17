//
//  ViewController.swift
//  MyFirstSwift
//
//  Created by Blake Oistad on 10/26/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var myLabel   : UILabel!
    @IBOutlet weak var myButton  : UIButton!
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func myButtonPressed(sender: UIButton) {
        print("My Button Pressed")
        myLabel.text = "Pressed"
        myButton.setTitle("Again", forState: .Normal)
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

