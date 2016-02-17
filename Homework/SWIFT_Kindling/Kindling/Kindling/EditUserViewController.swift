//
//  EditUserViewController.swift
//  Kindling
//
//  Created by Blake Oistad on 11/4/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import Parse

class EditUserViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var genderTextField: UITextField!
    @IBOutlet var orientationTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var profilePicImageView: UIImageView!
    
    let currentUser = PFUser.currentUser()
    
    //MARK: - User Display Methods
    
    func displayUserData() {
        usernameLabel!.text = currentUser!.username
    }
    
    
    
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        print("Done Button Pressed") 
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
