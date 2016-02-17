//
//  ViewController.swift
//  SwiftContact
//
//  Created by Blake Oistad on 10/27/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit
import CoreData
import Contacts
import ContactsUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate, CNContactViewControllerDelegate {

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext :NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var contactArray = [Contact]()
    var contactStore = CNContactStore()
    var selectedContact = Contact?()
    @IBOutlet weak var contactTableView :UITableView!
    
    //MARK: - Contact Methods
    
    func requestAccessToContactType(type: CNEntityType) {
        contactStore.requestAccessForEntityType(type) { (accessGranted: Bool, error: NSError?) -> Void in
            if accessGranted {
                print("Contact Access Granted")
            } else {
                print("Contact Access Not Granted")
            }
        }
    }
    
    func checkContactAuthorizationStatus(type: CNEntityType) {
        let status = CNContactStore.authorizationStatusForEntityType(type)
        
        switch status {
        case CNAuthorizationStatus.NotDetermined:
            print("Auth Status Not Determined")
            requestAccessToContactType(type)
        case CNAuthorizationStatus.Authorized:
            print("Auth Status Authorized")
        case CNAuthorizationStatus.Denied, CNAuthorizationStatus.Restricted:
            print("Auth Status Denied/Restricted")
        }
    }
    
    
    //MARK: - Section Methods
    
    var sectionsArray = [String]()
    
    func createSectionArray() -> [String] {
        var categorySet = Set<String>()
        for contact in contactArray {
            categorySet.insert(String(contact.contactLastName!.characters.first!))
        }
        print(categorySet)
        return Array(categorySet).sort()
        //TODO: - Figure out optionals issue
    }
    
    func filterContactsByLastName(category: String) -> [Contact] {
        let filteredContacts = contactArray.filter({
            String($0.contactLastName!.characters.first!) == category
        })
        return filteredContacts
    }

    
    
    
    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterContactsByLastName(sectionsArray[section]).count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let firstName = filterContactsByLastName(sectionsArray[indexPath.section]) [indexPath.row].contactFirstName!
        let lastName = filterContactsByLastName(sectionsArray[indexPath.section]) [indexPath.row].contactLastName!
        
        cell.textLabel!.text = String("\(firstName) \(lastName)")
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsArray[section]
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Count:\(filterContactsByLastName(sectionsArray[section]).count)"
    }

    
//    func sortByLastName() {
//        sectionsArray.sort(
//    }
    
    
    
    
    
    
    
    
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func showContactsList(sender: UIBarButtonItem) {
        let contactListVC = CNContactPickerViewController()
        contactListVC.delegate = self
        presentViewController(contactListVC, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        
        let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("Contact", inManagedObjectContext: managedObjectContext)
        selectedContact = Contact(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        
        selectedContact!.contactFirstName = contact.givenName
        selectedContact!.contactLastName = contact.familyName
        
        if contact.emailAddresses.count > 0 {
            selectedContact!.contactEmail = contact.emailAddresses[0].value as? String
        } else {
            selectedContact!.contactEmail = ""
        }
        
        if contact.phoneNumbers.count > 0 {
            selectedContact!.contactPhone = (contact.phoneNumbers[0].value as? CNPhoneNumber)!.stringValue
        } else {
            selectedContact!.contactPhone = ""
        }
        
        if contact.postalAddresses.count > 0 {
            for address in contact.postalAddresses as [CNLabeledValue] {
                selectedContact!.contactAddressStreet = (address.value as! CNPostalAddress).street
                selectedContact!.contactAddressCity = (address.value as! CNPostalAddress).city
                selectedContact!.contactAddressState = (address.value as! CNPostalAddress).state
                selectedContact!.contactAddressZipCode = (address.value as! CNPostalAddress).postalCode
            }
        } else {
            selectedContact!.contactAddressStreet = "n"
            selectedContact!.contactAddressCity = ""
            selectedContact!.contactAddressState = ""
            selectedContact!.contactAddressZipCode = ""
        }
        
        appDelegate.saveContext()
    }
    
    
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        print("Edit Button Pressed")
        contactTableView.editing = !contactTableView.editing
    }
    

    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("Delete")
            let contactToDelete = contactArray[indexPath.row]
            managedObjectContext.deleteObject(contactToDelete)
            appDelegate.saveContext()
            contactArray = fetchContact()!
            contactTableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! DetailViewController
        if segue.identifier == "segueEdit" {
            let indexPath = contactTableView.indexPathForSelectedRow!
            let selectedContact = contactArray[indexPath.row]
            destController.selectedContact = selectedContact
            contactTableView.deselectRowAtIndexPath(indexPath, animated: true)
            print("Edit Contact")
        } else if segue.identifier == "segueAdd" {
            destController.selectedContact = nil
            print("Add Contact")
        }
    }
    
    //MARK: - Core Data Methods
    
    func tempAddRecords() {
        let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("Contact", inManagedObjectContext: managedObjectContext)
        let currentContact :Contact! = Contact(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        currentContact.contactFirstName = "Jimsey"
        currentContact.contactLastName = "Balls"
        currentContact.dateEntered = NSDate()
        currentContact.userID = "System"
        appDelegate.saveContext()
    }
    
    func fetchContact() -> [Contact]? {
        let fetchRequest :NSFetchRequest! = NSFetchRequest(entityName: "Contact")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "contactLastName", ascending: true)]
        do {
            let tempArray = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [Contact]
            return tempArray
        } catch {
            return nil
        }
    }
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tempAddRecords()
//        let firstContact = contactArray.first
//        print("count: \(contactArray.count) contact:\(firstContact!.contactFirstName)")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        contactArray = fetchContact()!
        sectionsArray = createSectionArray()
        contactTableView.reloadData()

        //consider figuring out how to write a conditional to say only refresh the table view if information has changed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

