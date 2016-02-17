//
//  DetailViewController.swift
//  Maintain_Tennant
//
//  Created by Blake Oistad on 11/5/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: - Properties
    
    var dataManager = DataManager()
    @IBOutlet var repairTitleTextField: UITextField!
    @IBOutlet var repairDescTextView: UITextView!
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        print("Save Button Pressed")
        
        let newRepair = Repair()
        
        newRepair.repairTitle = repairTitleTextField.text!
        newRepair.repairDesc = repairDescTextView.text!
        newRepair.subject = repairTitleTextField.text!
        newRepair.body = repairDescTextView.text!
        
        if newRepair.repairTitle!.characters.count > 0 && newRepair.repairDesc!.characters.count > 0 {
            print("Repair info- Title: \(newRepair.repairTitle!) Description: \(newRepair.repairDesc!) Message Subject: \(newRepair.repairTitle!) Message Body: \(newRepair.repairDesc!)")
            dataManager.repairsArray.append(newRepair)
            print("Array Count now at \(dataManager.repairsArray.count), Title: \(dataManager.repairsArray.last!.repairTitle!), Desc: \(dataManager.repairsArray.last!.repairDesc!)")
            dataManager.postRepairsToServer()
            navigationController!.popToRootViewControllerAnimated(true)
            
        } else {
            print("No data in new repair")
            navigationController!.popToRootViewControllerAnimated(true)
        }
    }
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
