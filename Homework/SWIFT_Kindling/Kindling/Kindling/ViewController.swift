//
//  ViewController.swift
//  Kindling
//
//  Created by Blake Oistad on 11/4/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //MARK: - Properties
    
    var usersArray = [PFUser]()
    
    @IBOutlet var loginButton: UIBarButtonItem!
    
    @IBOutlet var usersCollectionView: UICollectionView!
    
    @IBOutlet var settingsButton: UIBarButtonItem!
    
    
    //MARK: - Collection View Methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Items in Section Count:\(usersArray.count)")
        return usersArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UserCollectionViewCell
        let currentUser = usersArray[indexPath.row]
        cell.userUserNameLabel!.text = currentUser.username
        print("Current Users: \(currentUser.username)")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(140, 180)
    }
    
    
    
    //MARK: - Parse Methods
    
    func fetchUsersFromParse() {
        let fetch = PFUser.query()
        fetch!.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if error == nil {
                self.usersArray = objects as! [PFUser]
                print("Users Found: \(self.usersArray)")
                self.usersCollectionView.reloadData()
            } else {
                print("No Users Found")
            }
            
        })
    }
    
    
    
    
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
            
            let signUpController = PFSignUpViewController()
            signUpController.delegate = self
            loginController.signUpController = signUpController
            
            let username = getUsernameDefault()
            print ("Got User:\(username)")
            loginController.logInView!.usernameField!.text = username
            presentViewController(loginController, animated: true, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        let username = logInController.logInView!.usernameField!.text!
        print(username)
        setUsernameDefault((logInController.logInView!.usernameField!.text!))
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
    
    
    
    func parseDataDelivered() {
        print("Parse Delivered Data")
        usersCollectionView.reloadData()
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()
        loginButton.title = "Log In"
        settingsButton.enabled = false
        fetchUsersFromParse()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

