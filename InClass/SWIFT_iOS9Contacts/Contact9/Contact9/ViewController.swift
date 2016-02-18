//
//  ViewController.swift
//  Contact9
//
//  Created by Blake Oistad on 10/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate, CNContactViewControllerDelegate {

    var contactStore = CNContactStore()
    @IBOutlet weak var lastNameTextField :UITextField!
    
    
    
    //MARK: - Contact Methods
    
    func requestAccessToContactType(type: CNEntityType) {
        contactStore.requestAccessForEntityType(type) { (accessGranted: Bool, error: NSError?) -> Void in
            if accessGranted {
                print("Granted")
            } else {
                print("Not Granted")        //display message saying we dont have access to this function
            }
        }
    }
    
    
    func checkContactAuthorizationStatus(type: CNEntityType) {
        let status = CNContactStore.authorizationStatusForEntityType(type)
        
        switch status {
        case CNAuthorizationStatus.NotDetermined:               //could delete CNAUTHORIZATIONSTATUS due to the fact that were switching on status, whihc it knows is authorization status
            print("Not Determined")
            requestAccessToContactType(type)
        case CNAuthorizationStatus.Authorized:
            print("Authorized")
        case CNAuthorizationStatus.Denied, CNAuthorizationStatus.Restricted:
            print("Denied/Restricted")
            //DONT NEED DEFAULT BECAUSE WEVE EXHAUSTED ALL POSSIBLE CASES FOR CNAUTHORIZATIONSTATUS
        }
    }
    
    
    //MARK: - Interactivity Methods
    
    func displayContact(contact: CNContact) {
        let contactVC = CNContactViewController(forContact: contact)
        contactVC.delegate = self
        contactVC.contactStore = contactStore           //needs to know which contactStore to use, currently there is only one
        navigationController!.pushViewController(contactVC, animated: true)
    }
    
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        print("Done with " + (contact!.familyName))
    }
    
    func presentContactMatchingName(name: String) {
        let predicate = CNContact.predicateForContactsMatchingName(name)
        let keysToFetch = [CNContactViewController.descriptorForRequiredKeys()]
        do {
            let contacts = try contactStore.unifiedContactsMatchingPredicate(predicate, keysToFetch: keysToFetch)           //try to search & match the predicate we set (name) and get its key values, facebook is contained in "unified" contact list, all contacts available to search from
            if let firstContact = contacts.first {
                print("Contact: " + firstContact.givenName)
                displayContact(firstContact)
            }
        } catch {
            print("Error")          //hey, your search returned no values
        }
    }
    
    @IBAction func showContactEditor(sender: UIBarButtonItem) {
        print("Edit")
        if let lastname = lastNameTextField.text {              //if we have something for lastname, use it, otherwise do nothing. unwrapped
        presentContactMatchingName(lastname)
        }
    }
    
    @IBAction func showContactList(sender: UIBarButtonItem) {
        let contactListVC = CNContactPickerViewController()
        contactListVC.delegate = self
        presentViewController(contactListVC, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {          //override method to find out when the selected contact is made, dismisses the view controller
        let fullName = CNContactFormatter.stringFromContact(contact, style: .FullName)                        //gives us the Full name, middle, jr. dr. or whatever based on the full name in their contact
        print("Name: \(contact.givenName) \(contact.familyName) or \(fullName!)")
        
        for email in contact.emailAddresses as [CNLabeledValue] {                                             //emailAddresses in a cnlabeled value array
            print("Email (" + CNLabeledValue.localizedStringForLabel(email.label) + "): " + (email.value as! String))
        }
        
        for phone in contact.phoneNumbers as [CNLabeledValue] {
            print("Phone (" + CNLabeledValue.localizedStringForLabel(phone.label) + "): " + (phone.value as! CNPhoneNumber).stringValue)
        }
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkContactAuthorizationStatus(CNEntityType.Contacts)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

