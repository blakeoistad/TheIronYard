//
//  ViewController.swift
//  ParseLogin
//
//  Created by Blake Oistad on 11/4/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    

   
    //MARK: - Properties
    
    @IBOutlet var loginButton: UIBarButtonItem!
    @IBOutlet var todoTextField: UITextField!
    
    
    //MARK: - User Default Methods
    
    func setUsernameDefault(username: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(username, forKey: "DefaultUsername")
        userDefaults.synchronize()
        
    }
    
    func getUsernameDefault() -> String {
        if let defaultUsername = NSUserDefaults.standardUserDefaults().stringForKey("DefaultUsername") {       //if theres a default username, set it
            return defaultUsername
        } else {
            return ""
        }
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func addRecord(sender: UIBarButtonItem) {
        if let uCurrentUser = PFUser.currentUser() {                    //if theres a current user, create new todo
            let newTodo = PFObject(className: "Todo")                   //if no "Todo" object, parse creates it for us on declaration
            newTodo["todoDesc"] = todoTextField.text
            newTodo.ACL = PFACL(user: uCurrentUser)                     //this object being added is accessible only to the user adding it
            
            newTodo.saveInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    let alert = UIAlertController(title: "Saved", message: "Your todo was saved", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Not Saved", message: "Your todo was not saved", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        } else {
            let alert = UIAlertController(title: "No User", message: "Your must be logged in to save todos", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Login Methods
    
    @IBAction func loginButtonPressed(sender: UIBarButtonItem) {
        if let _ = PFUser.currentUser()  {                      //if able to unwrap, that means we have a user
            PFUser.logOut()
            loginButton.title = "Log In"
        } else {
            //login controller
            let loginController = PFLogInViewController()
            loginController.delegate = self
            //sign up controller
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
        dismissViewControllerAnimated(true, completion: nil)                                        //dismisses login view controller once logged in
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
    
    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()                                                             //just in case, log the current user out
        loginButton.title = "Log In"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

