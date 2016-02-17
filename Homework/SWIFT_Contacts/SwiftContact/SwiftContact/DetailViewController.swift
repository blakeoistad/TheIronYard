//
//  DetailViewController.swift
//  SwiftContact
//
//  Created by Blake Oistad on 10/27/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext :NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var selectedContact :Contact?
    
    @IBOutlet weak var ratingStackView :UIStackView!
    
    @IBOutlet weak var contactFirstNameTextField :UITextField!
    @IBOutlet weak var contactLastNameTextField :UITextField!
    @IBOutlet weak var contactStreetTextField :UITextField!
    @IBOutlet weak var contactCityTextField :UITextField!
    @IBOutlet weak var contactStateTextField :UITextField!
    @IBOutlet weak var contactZipTextField :UITextField!
    @IBOutlet weak var contactEmailTextField :UITextField!
    @IBOutlet weak var contactPhoneTextField :UITextField!
    @IBOutlet weak var addStarButton: UIButton!
    
    
    //MARK: - Interactivity Methods
    
    func saveAndPop() {
        appDelegate.saveContext()
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        print("Done Button Pressed")
        if let _ = selectedContact {
        } else {
            let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("Contact", inManagedObjectContext: managedObjectContext)
            selectedContact = Contact(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        }
        selectedContact!.contactFirstName = contactFirstNameTextField.text
        selectedContact!.contactLastName = contactLastNameTextField.text
        selectedContact!.contactAddressStreet = contactStreetTextField.text
        selectedContact!.contactAddressCity = contactCityTextField.text
        selectedContact!.contactAddressState = contactStateTextField.text
        selectedContact!.contactAddressZipCode = contactZipTextField.text
        selectedContact!.contactEmail = contactEmailTextField.text
        selectedContact!.contactPhone = contactPhoneTextField.text
        let starRating = ratingStackView.arrangedSubviews.count
        print("Count \(starRating)")
        selectedContact!.contactRating = starRating
        selectedContact!.dateUpdated = NSDate()
        selectedContact!.userID = "User"
        saveAndPop()
    }

    
    @IBAction func deleteContact(sender: UIBarButtonItem) {
        print("Delete Button Pressed")
        managedObjectContext.deleteObject(selectedContact!)
        self.saveAndPop()
    }
    
    
    //MARK: - Stack View Methods
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Add")
        let starImageView = UIImageView(image: UIImage(named: "Star"))
        starImageView.contentMode = UIViewContentMode.ScaleAspectFit
        let starCount = ratingStackView.arrangedSubviews.count
        if starCount < 5 {
            ratingStackView.insertArrangedSubview(starImageView, atIndex: starCount)
            UIView.animateWithDuration(0.25) { () -> Void in
                self.ratingStackView.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func removeButtonPressed(sender: UIButton) {
        print("Remove")
        let starCount = ratingStackView.arrangedSubviews.count
        if starCount > 0 {
            let starToRemove = ratingStackView.arrangedSubviews[starCount - 1]
            ratingStackView.removeArrangedSubview(starToRemove)
            starToRemove.removeFromSuperview()
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.ratingStackView.layoutIfNeeded()
            })
        }
    }
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Got \(selectedContact?.contactFirstName)")
        
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if let uSelectedContact = selectedContact {
            
            contactFirstNameTextField.text = uSelectedContact.contactFirstName
            contactLastNameTextField.text = uSelectedContact.contactLastName
            contactStreetTextField.text = uSelectedContact.contactAddressStreet
            contactCityTextField.text = uSelectedContact.contactAddressCity
            contactStateTextField.text = uSelectedContact.contactAddressState
            contactZipTextField.text = uSelectedContact.contactAddressZipCode
            contactEmailTextField.text = uSelectedContact.contactEmail
            contactPhoneTextField.text = uSelectedContact.contactPhone
//            if uSelectedContact.contactRating! != 0 {
                for var x = 0; x < Int(uSelectedContact.contactRating!); x++ {
                    addButtonPressed(addStarButton)
                }
//            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
