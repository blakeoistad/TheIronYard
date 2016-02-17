//
//  ViewController.swift
//  AttendanceLog
//
//  Created by Blake Oistad on 11/12/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    //MARK: - Properties
    
    @IBOutlet var loginButton: UIBarButtonItem!
    
    
    
    //MARK: - User Default Methods
    
    func setUsernameDefault(username: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(username, forKey: "DefaultUsername")
        userDefaults.synchronize()
    }
    
    func getUsernameDefault() -> String {
        if let defaultUsername = NSUserDefaults.standardUserDefaults().stringForKey("DefaultUsername") {
            return defaultUsername
        } else {
            return ""
        }
    }
    
    //MARK: - Interactivity Methods
    
    
    
    //MARK: - Login Methods

    @IBAction func loginButtonPressed(sender: UIBarButtonItem) {
        if let _ = PFUser.currentUser() {
            PFUser.logOut()
            loginButton.title = "Log In"
        } else {
            let loginController = PFLogInViewController()
            loginController.delegate = self
            let signupController = PFSignUpViewController()
            signupController.delegate = self
            loginController.signUpController = signupController
            
            let username = getUsernameDefault()
            print("got user:\(username)")
            loginController.logInView!.usernameField!.text = username
            presentViewController(loginController, animated: true, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        let username = logInController.logInView!.usernameField!.text!
        print(username)
        setUsernameDefault((logInController.logInView!.usernameField!.text)!)
        loginButton.title = "Log Out"
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    func newDataRecieved(currentUser: PFUser) {
        let checkedIn = PFObject(className: "checkedIn")
        checkedIn.ACL = PFACL(user: currentUser)
        checkedIn["userIn"] = currentUser.username
        checkedIn.saveInBackgroundWithBlock({ (success,error) -> Void in
            if success {
                let alert = UIAlertController(title: "Checked In!", message: "You're in! Have a great day", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
    
    func fetchCurrentlySignedInUser() {
        if let uCurrentUser = PFUser.currentUser() {
            let query = PFQuery(className:"checkedIn")
            query.whereKey("userIn", equalTo:uCurrentUser.username!)
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    print("Successfully retrieved \(objects!.count) scores.")
                    
                    if (objects!.count == 0) {
                        self.newDataRecieved(uCurrentUser)
                    } else if let uObjects = objects {
                        print("userIn is \(String(uObjects[0]["userIn"]))")
                        if !(String(uObjects[0]["userIn"]) == uCurrentUser.username) {
                            print("there is stuff in the array")
                            self.newDataRecieved(uCurrentUser)
                        }
                    } else {
                        print("got into nothing in the array")
                        self.newDataRecieved(uCurrentUser)
                    }
                } else {
                    // Log details of the failure
                    //print("Error: \(error!) \(error!.userInfo!)")
                }
            }
        } else {
            let alert = UIAlertController(title: "No User", message: "You are not logged in! Go log in first!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()
        loginButton.title = "Log In"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetchCurrentlySignedInUser", name: "recievedDataFromServer", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

